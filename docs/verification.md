# 验证策略

rv32c 采用**定向指令流仿真**作为当前阶段的主要验证手段，逐级覆盖数据冒险、控制冒险与访存通路。

## 验证层次

```mermaid
graph LR
    A["指令级测试"] --> B["流水线冒险测试"]
    B --> C["访存通路测试"]
    C --> D["RTL 生成检查"]
```

## 当前测试

全部为定向指令流 / 单元测试，`sbt test` 共 31 项。

### 指令与流水线（`src/test/scala/rv32c/sim/RiscvCoreTest.scala`）

| 用例 | 覆盖点 | 关键断言 |
|------|--------|----------|
| RV32I basic program | 基本 ALU、RAW 旁路、访存写读、load-use 冒险、分支、跳转自循环 | x3==12、x4==12、x6==17、被跳过指令未执行 |
| RV32M program | mul/mulh/mulhsu/mulhu、div/divu/rem/remu（含负数、除零、MIN/-1 溢出）与除法结果旁路 | 逐项结果 + 除法器结果转入后续 add |
| RV64I program | 64 位 `addi/slli/srai`、`*W` 截断与符号扩展、`sd/ld/lw/lwu` 载入扩展 | 逐项 64 位结果 |
| RV64M program | `MULW/DIVW/DIVUW/REMW/REMUW`（32 位判定、溢出、除零、结果符号扩展）与旁路 | 逐项结果 |
| RV32C program | 压缩取指（2 字节 PC 粒度）、`pc[1]=1` 起始的 32 位指令拼接、Q0/Q1/Q2 代表指令（`C.LI/C.SWSP/C.LWSP/C.ADD/C.ADDI4SPN/C.SW/C.LW`） | x1==27、x3==7、x8==4、x10==7 |
| RV32C arith coverage | `C.ADDI/C.LUI/C.ADDI16SP/C.ANDI/C.SRLI/C.SRAI/C.SLLI/C.MV/C.ADD/C.SUB/C.XOR/C.OR/C.AND`，以及 imm=64 的 `C.SW/C.LW`（锁定 CRS2' 与 uimm[6] 字段） | x1==8、x16==0x1000、x2==36、x8==20、x9==7、x10==0xfffffffe、x11==32、x12==35、x13==8、x15==20 |
| RV32C flow coverage | `C.JAL`/`C.JR`/`C.BEQZ`（不跳）/`C.BNEZ`（跳）/`C.JALR`（链接=PC+2）/`C.J` 自循环 | x21==0x06、x1==0x22、x9==30、x10==1、x11==0、x15==4、x12==11 |
| RV32C reserved encoding traps | 保留压缩编码（`C.SRLI` shamt[5]=1）| `mcause==2`、`mepc` 指向故障压缩指令 |

### 特权/CSR/中断（`src/test/scala/rv32c/sim/ZicsrTrapTest.scala`）

CSR 读写与 WARL、M 模式同步异常（ecall/ebreak/非法指令/CSR 违例）、机器定时器中断 + MRET、U 模式往返。

### 配置模型单元测试

`IsaConfigSpec`（misa 推导、特权栈结构规则、命名）与 `CsrMapSpec`（CSR 地址唯一性、只读集、异常码）共 19 项。

## 运行方式

```bash
sbt test
```

单类运行：`sbt "testOnly rv32c.sim.RiscvCoreTest"`。SpinalSim 默认使用 iverilog 后端（`SimConfig.withIVerilog`），结果输出到 `simWork/`。

## 待补强方向

1. **RV64C 全指令覆盖**：RV64 专属压缩编码（`C.LD/C.SD`、64 位压缩移位）随 RTL 实现补齐
2. **指令集全覆盖测试**：为 RV32I / RV64I 每条指令生成独立的定向测试
3. **RISC-V 官方合规测试**：对接 `riscv-tests`（ISA 测试套件），加载预编译的测试镜像
4. **随机化测试**：随机指令流 + 参考模型（如 Spike ISA 模拟器）对拍
5. **波形分析**：打开 SpinalSim 波形，人工检查冒险停顿拍数与旁路行为
6. **覆盖率**：指令/分支/冒险路径的功能覆盖率统计

## 测试平台说明

`CpuTb` 将 `RiscvCore` 与两个零等待内存相连：

- 指令内存：复位后从 `resetVector` 取指
- 数据内存：字节掩码读写

两者均为组合读、同步写，方便直接观察流水线行为。接入真实 SRAM/缓存后，此测试平台可继续复用（仅需替换内存模型）。
