# rv32c — 可配置的 32 位 RISC-V CPU

rv32c 是一个用 **SpinalHDL** 编写的高效、参数化 RISC-V 处理器，采用经典五级流水线微架构，完整实现 RV32I / RV64I 基础整数指令集，并内置可配置的 **RV32M/RV64M** 乘除扩展、**RV32A/RV64A** 原子扩展与 **RV32C/RV64C** 压缩扩展。

项目设计目标：

- **先支持最小指令集**：以 RV32I 起步，通过插件式参数逐步扩展 M/F/D 等扩展
- **运行效率高**：五级流水线 + 数据旁路（forwarding）+ 分支在 EX 阶段提前判定
- **面向未来**：位宽（RV32→RV64）、多核数量均通过 `CoreConfig` 参数化，单处配置全核生效

## 特性

- 完整 RV32I 指令集（含 load/store 字节/半字/字访问、有符号/无符号扩展）
- 完整 RV32M 扩展：MUL/MULH/MULHSU/MULHU 组合实现；DIV/DIVU/REM/REMU 由 EX 段多周期除法器执行，运算期间整条流水线冻结，除零与 MIN/-1 边界按 RISC-V 规范处理
- 经典 5 级流水线：IF / ID / EX / MEM / WB
- RV32A / RV64A 原子扩展：LR/SC 预约集 + 9 种 AMO（ADD/SWAP/XOR/OR/AND/MIN/MAX/MINU/MAXU），AMO 在 MEM 级「读→改→写」冻结流水线保证原子性，LR/SC 与 AMO 对齐违例触发 cause 4/6
- RV32C / RV64C 压缩扩展：32 位指令总线内按 `pc[1]` 半字取指与拼接，RV64 专属编码（`C.LD/C.SD/C.ADDIW/C.*W` 等）按 `xlen` 展开
- 数据冒险全旁路（EX/MEM → EX、MEM/WB → EX）
- load-use 冒险：硬件停顿 1 拍
- 分支在 EX 阶段判定，跳过 2 条错误取指指令
- JAL/JALR 链接、AUIPC、LUI 完整支持
- 独立的指令总线与数据总线接口（握手协议，未来可接 AXI4 与缓存）
- 参数化位宽：`CoreConfig(xlen = 32)`，未来 `xlen = 64` 即可切到 RV64I
- 参数化多核：`CoreConfig(numCores = N)`，为多核互联预留了配置骨架

## 验证状态

- RV32I 定向测试通过：数据冒险旁路、load-use 停顿、分支跳过、访存读写均验证正确
- RV32M 定向测试通过：乘法（高位/有符号×无符号/无符号）、有符号与无符号除法/余数、负数运算、除零、MIN/-1 溢出回绕、除法结果旁路均验证正确
- RV64I / RV64M / RV32C / RV64C / RV32A / RV64A 定向测试通过，`sbt test` 共 39 项
- 已生成可综合的 `rtl/RiscvCore.v`（RV32IM）、`rtl/RiscvCoreC.v`（RV32IMC）、`rtl/RiscvCore64C.v`（RV64IMC）、`rtl/RiscvCoreA.v`（RV32IMA）与 `rtl/RiscvCore64A.v`（RV64IMA），异步复位、标准 Verilog

## 快速开始

依赖：JDK 17+、sbt、iverilog（仿真用）。

```bash
# 运行全部仿真测试
./scripts/run-tests.sh

# 生成 Verilog RTL（输出到 rtl/）
./scripts/gen-rtl.sh
```

## 目录结构

```
src/main/scala/rv32c/
├── CoreConfig.scala        # 全局参数化配置（位宽/扩展/多核/调试）
├── RiscvCore.scala         # 五级流水线核心与冒险控制
├── RiscvCoreGen.scala      # Verilog 生成入口
├── bus/                    # 指令总线 / 数据总线接口
├── core/                   # ALU、寄存器堆、译码器
└── sim/                    # 仿真内存模型

src/test/scala/rv32c/sim/   # 仿真测试平台与测试用例

docs/                       # 架构、配置、指令集、开发、验证文档
rtl/                        # 生成的 Verilog（可选）
```

## 设计文档

| 文档 | 说明 |
|------|------|
| [微架构设计](docs/architecture.md) | 流水线结构、冒险处理、旁路网络、分支策略 |
| [配置方法](docs/configuration.md) | CoreConfig 详解、RV32→RV64 迁移、多核扩展 |
| [指令集支持](docs/isa-support.md) | RV32I 指令覆盖矩阵与实现状态 |
| [开发指南](docs/development.md) | 如何新增指令、跑测试、生成 RTL、代码规范 |
| [验证策略](docs/verification.md) | 仿真验证方法与测试用例说明 |

## 路线图

- [x] RV32I 五级流水线（含旁路、load-use 停顿、分支提前判定）
- [x] RV32M / RV64M 扩展（组合乘法 + EX 多周期除法器，`RvExtension.MulDiv` 配置）
- [x] RV32C / RV64C 压缩扩展（`RvExtension.Compressed` 配置）
- [x] RV32A / RV64A 原子扩展（LR/SC + AMO 读-改-写，`RvExtension.Atomic` 配置）
- [x] RV64I 支持（`xlen = 64` 参数切换，RV32C/RV64C 共用压缩取指通路）
- [ ] F/D 浮点扩展
- [ ] 分支预测器（BHT/gshare 插件化）
- [ ] I/D 缓存、AXI4 总线桥
- [ ] 多核（`numCores` 参数 + 互联总线）

## 许可证

MIT
