# 微架构设计

## 概述

rv32c 采用经典哈佛结构的五级流水线，指令和数据走独立总线。整体为单发射、按序（in-order）执行，目标是高时钟频率与简单可验证的设计，后续可逐步引入乱序或更深流水。

```mermaid
graph LR
    A["IF 取指"] --> B["ID 译码/读寄存器"]
    B --> C["EX 执行/分支判定"]
    C --> D["MEM 访存"]
    D --> E["WB 写回"]
```

## 五级流水线

### IF（取指）

- `pcReg` 输出到指令总线，握手成功后指令进入 IF/ID 寄存器
- 遇到停顿（stall）时 PC 冻结；遇到跳转/分支时 PC 更新为目标地址
- 复位后从 `CoreConfig.resetVector` 开始取指

### ID（译码）

- 组合译码器 `Decoder` 生成全部控制信号：寄存器写使能、ALU 操作、访存属性、分支类型、写回选择、立即数
- 立即数按 I / S / B / U / J 五种格式生成并符号扩展到位宽
- 读取寄存器堆，同时锁存到 ID/EX 寄存器

### EX（执行）

- 旁路单元根据 EX/MEM 与 MEM/WB 的结果优先选择操作数，消除绝大多数数据冒险
- ALU 完成算术/逻辑/移位/比较运算
- **分支与跳转在 EX 阶段提前判定**，条件跳转直接消耗转发后的操作数，避免等到 MEM 阶段，将错误预测代价从 3 拍降到 2 拍
- JALR 目标 = `rs1 + imm` 并强制按 2 字节对齐（清 LSB）

### MEM（访存）

- 根据指令访问数据总线（读写、字节/半字/字、符号扩展）
- 写数据与写掩码（byte strobe）在核心内生成，从地址低 2 位计算字节偏移
- 读回数据按访问宽度截取并做符号/零扩展

### WB（写回）

- 选择写回源：ALU 结果 / 访存结果 / `pc + 4`（JAL/JALR 链接）
- 写入寄存器堆（`rd == 0` 时忽略，符合 RISC-V 规范）

## 冒险处理

### 数据冒险（RAW）

采用全旁路（forwarding）方案，旁路优先级：

1. EX/MEM → EX（最近结果优先，且排除 load 结果未就绪的情况）
2. MEM/WB → EX

旁路判定条件：`regWrite && rd != 0 && rd == 源寄存器`。

### load-use 冒险

当 EX 阶段是 load 且 ID 阶段指令需要使用其目标寄存器时，硬件停顿 1 拍：

```text
检测: EX.MEMRead && EX.rd != 0 && (EX.rd == IF/ID.rs1 || EX.rd == IF/ID.rs2)
动作: 冻结 PC 与 IF/ID 寄存器，向 EX 阶段插入气泡
```

停顿一拍后 load 结果已进入 MEM/WB，旁路即可正确转发。

### RV32M 除法（多周期 EX 停顿）

DIV/DIVU/REM/REMU 在 EX 段由一个恢复除法器执行，运算期间整条流水线冻结：

```text
检测: EX.valid && (aluOp ∈ {DIV,DIVU,REM,REMU}) && !divider.done
动作: divStall=1，freezeAll = memStall || fetchStall || divStall，
      PC/IFID/IDEX/EXMEM/MEMWB 全部保持
完成: divider.done 一拍内释放停顿，除法器结果经 exMem.aluResult
      送入原有旁路与回写路径，同时 ack 除法器复位
```

结果通过既有 EX/MEM 旁路网络转发，流水线其余逻辑无需感知除法器的多周期特性。

### 控制冒险

分支在 EX 判定，跳转发生时：

- 冻结 IF/ID 中的 2 条错误取指指令（通过清 `valid` 位实现）
- PC 更新为分支/跳转目标

代价：条件分支错误预测固定 2 拍。JAL 无条件跳转同样 2 拍。

## 总线接口

核心通过两个握手接口对外访问，均支持 `valid/ready` 反压：

- `IBusInterface`：`valid` + `pc` → `ready` + `instruction`
- `DBusInterface`：`valid/write/size/address/writeData/writeMask` → `ready/readData`

当前仿真内存模型为零等待（组合读），未来可在此接口后接入 SRAM 控制器或缓存，无需改动核心。

## 关键设计决策

| 决策 | 选择 | 理由 |
|------|------|------|
| 分支判定阶段 | EX | 比 MEM 阶段少 1 拍错误预测代价，不引入专用预测器 |
| 旁路网络 | 两级全旁路 | 消除 RAW 冒险，仅保留 load-use 停顿 |
| 哈佛结构 | 独立 I/D 总线 | 避免单端口存储器的吞吐瓶颈，接口对称易扩展 |
| 位宽参数化 | 全程使用 `xlen` | 从 RV32 迁移 RV64 只需改一处配置 |
| RV32M 乘法 | ALU 内组合乘法 | 单周期出结果，零流水线代价 |
| RV32M 除法 | EX 段恢复除法器 + 整条流水线冻结 | 面积/时序友好；`withMulDiv=false` 时不实例化 |

## 未来演进（对应参数化预留）

- **RV64**：所有数据通路已按 `xlen` 生成，`xlen=64` 即得 RV64I
- **分支预测**：`BranchPredictorConfig` 已预留，可插入 BHT/gshare
- **缓存**：`withICache/withDCache` 配置项已定义，后续在总线接口后挂接
- **多核**：`numCores` 参数化，互联总线在核外组合
