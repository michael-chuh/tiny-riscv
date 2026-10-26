# rv32c — 可配置的 32 位 RISC-V CPU

rv32c 是一个用 **SpinalHDL** 编写的高效、参数化 RISC-V 处理器，采用经典五级流水线微架构，完整实现 RV32I / RV64I 基础整数指令集，并内置可配置的 **RV32M/RV64M** 乘除扩展、**RV32A/RV64A** 原子扩展、**RV32C/RV64C** 压缩扩展、**RV32F/RV64F** 单精度浮点扩展、**RV64D** 双精度浮点扩展以及 **Zba/Zbb/Zbs/Zbc/Zbkb/Zbkc/Zbkx/Zknh/Zksh/Zksed/Zknd/Zkne** 位操作扩展。

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
- RV32F / RV64F 单精度浮点扩展：独立浮点寄存器堆、FLW/FSW 访存、参数化 IEEE-754 运算单元（FADD/FSUB/FMUL/FDIV/FSQRT/FMA/FCMP/FCLASS/FMIN/FMAX/FSGNJ 与整数↔浮点转换），5 种舍入模式（RNE/RTZ/RDN/RUP/RMM）与 fflags 异常标志；EX 段组合运算 + 单周期冻结，复用统一 `freezeAll`
- RV64D 双精度浮点扩展：FLEN=64 浮点寄存器堆、FLD/FSD 访存，D 核同时实例化 binary32 与 binary64 两个 FPU 并按指令 fmt 路由（避免双重舍入），支持 `FCVT.S.D`/`FCVT.D.S` 格式转换与 FLEN=64 下的 NaN-boxing
- Zba/Zbb/Zbs/Zbc/Zbkb/Zbkc/Zbkx 位操作扩展：Zbb 提供 `andn/orn/xnor`、`clz/ctz/cpop`、`min/minu/max/maxu`、`rol/ror/rori`、`sext.b/sext.h/zext.h`、`orc.b/rev8` 及 RV64 W 形式（`clzw/ctzw/cpopw/rolw/rorw/roriw`）；Zbs 提供 `bset/bclr/binv/bext` 寄存器与立即数形式（RV32 5 位 / RV64 6 位位索引）；Zba 提供 `sh1add/sh2add/sh3add` 与 RV64 `add.uw/slli.uw/sh*add.uw`；Zbc 提供 `clmul/clmulh/clmulr` 无进位乘法；Zbkb 提供密码学位操作 `pack/packh/packw`、`brev8` 与 RV32 `zip/unzip`；Zbkc 提供 `clmul/clmulh`（Zbc 的无 `clmulr` 子集）；Zbkx 提供 `xperm4/xperm8` 交叉位置换。全部在 EX 段组合执行并复用现有 ALU 结果通路
- Zknh 哈希位操作扩展：提供 SHA-2 变换 `sha256sum0/sha256sum1/sha256sig0/sha256sig1`，RV64 提供 `sha512sum0/sha512sum1/sha512sig0/sha512sig1`，RV32 提供拆分形式 `sha512sum0r/sha512sum1r/sha512sig0l/sha512sig0h/sha512sig1l/sha512sig1h`，同样在 EX 段组合执行
- Zksh/Zksed 密码位操作扩展：Zksh 提供 SM3 变换 `sm3p0/sm3p1`；Zksed 提供 SM4 变换 `sm4ed/sm4ks`（4 位字节选择 `bs`），均按 32 位计算并符号扩展，在 EX 段组合执行
- Zknd/Zkne AES 密码位操作扩展：Zkne 提供加密轮变换 `aes32esi/aes32esmi`（RV32）与 `aes64es/aes64esm`（RV64）；Zknd 提供解密轮变换 `aes32dsi/aes32dsmi`（RV32）与 `aes64ds/aes64dsm/aes64im`（RV64）；密钥调度 `aes64ks1i/aes64ks2`（RV64，Zknd/Zkne 共用）。轮变换包含 ShiftRows/InvShiftRows、SubBytes 与可选 MixColumns/InvMixColumns，在 EX 段组合执行
- Zicond 条件运算扩展：`czero.eqz` / `czero.nez` 依据 rs2 是否为零选择 rs1 或零，全部在 EX 段组合执行
- Zifencei 指令流同步扩展：`fence.i` 在无缓存流水线上作为合法的提交点，未使能时按非法指令处理
- Zcb 附加压缩扩展：`c.lbu/c.lhu/c.lh/c.sb/c.sh` 压缩字节/半字访存，以及 `c.zext.b/c.sext.b/c.zext.h/c.sext.h/c.zext.w/c.not/c.mul` 压缩寄存器运算
- Zicntr 用户计数器扩展：`cycle/time/instret`（RV32 另有 `cycleh/timeh/instreth` 高半字）与 `mcounteren/scounteren` 使能门控；`mcycle/minstret` 为机器模式可写别名，`mcountinhibit` 的 CY/TM/IR 位可分别冻结 `cycle/time/instret`，退休指令计数在 WB 提交点累加
- S 模式（M/S/U 特权栈）：S 级 CSR（`sstatus/sie/stvec/sscratch/sepc/scause/stval/sip/satp`）、`medeleg/mideleg` 异常与中断委托、`SRET` 返回，以及 S 模式的 CSR 权限检查与定时器中断路由；`satp` 为 WARL，当前仅支持 BARE（SV39 待补）
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
- RV64I / RV64M / RV32C / RV64C / RV32A / RV64A / RV32F / RV64D / Zbb / Zbs / Zba / Zbc / Zbkb / Zbkc / Zbkx / Zknh / Zksh / Zksed / Zknd / Zkne / Zicond / Zcb / Zifencei / Zicntr / S 模式（M/S/U）定向测试通过，`sbt test` 共 130 项
- 已生成可综合的 `rtl/RiscvCore.v`（RV32IM）、`rtl/RiscvCoreC.v`（RV32IMC）、`rtl/RiscvCore64C.v`（RV64IMC）、`rtl/RiscvCoreA.v`（RV32IMA）、`rtl/RiscvCore64A.v`（RV64IMA）、`rtl/RiscvCoreF.v`（RV32F）、`rtl/RiscvCore64F.v`（RV64F）与 `rtl/RiscvCore64D.v`（RV64D）、`rtl/RiscvCoreB.v`（RV32IM+Zbb）、`rtl/RiscvCore64B.v`（RV64IM+Zbb）、`rtl/RiscvCoreBS.v`（RV32IM+Zbs）、`rtl/RiscvCore64BS.v`（RV64IM+Zbs）、`rtl/RiscvCoreBA.v`（RV32IM+Zba）、`rtl/RiscvCore64BA.v`（RV64IM+Zba）、`rtl/RiscvCoreBC.v`（RV32IM+Zbc）、`rtl/RiscvCore64BC.v`（RV64IM+Zbc）、`rtl/RiscvCoreBKB.v`/`rtl/RiscvCore64BKB.v`（RV32/RV64IM+Zbkb）、`rtl/RiscvCoreBKC.v`/`rtl/RiscvCore64BKC.v`（RV32/RV64IM+Zbkc）、`rtl/RiscvCoreBKX.v`/`rtl/RiscvCore64BKX.v`（RV32/RV64IM+Zbkx）与 `rtl/RiscvCoreBK.v`/`rtl/RiscvCore64BK.v`（RV32/RV64IM+Zbkb+Zbkc+Zbkx）以及 `rtl/RiscvCoreKNH.v`/`rtl/RiscvCore64KNH.v`（RV32/RV64IM+Zknh）、`rtl/RiscvCoreKSH.v`/`rtl/RiscvCore64KSH.v`（RV32/RV64IM+Zksh）、`rtl/RiscvCoreKSED.v`/`rtl/RiscvCore64KSED.v`（RV32/RV64IM+Zksed）与 `rtl/RiscvCoreKS.v`/`rtl/RiscvCore64KS.v`（RV32/RV64IM+Zksh+Zksed）、`rtl/RiscvCoreKNE.v`/`rtl/RiscvCore64KNE.v`（RV32/RV64IM+Zkne）、`rtl/RiscvCoreKND.v`/`rtl/RiscvCore64KND.v`（RV32/RV64IM+Zknd）、`rtl/RiscvCoreKN.v`/`rtl/RiscvCore64KN.v`（RV32/RV64IM+Zknd+Zkne）、`rtl/RiscvCoreZICOND.v`/`rtl/RiscvCore64ZICOND.v`（RV32/RV64IM+Zicond）、`rtl/RiscvCoreZCB.v`/`rtl/RiscvCore64ZCB.v`（RV32IMC+Zbb+Zcb / RV64IMC+Zba+Zbb+Zcb）与 `rtl/RiscvCoreZIFENCEI.v`/`rtl/RiscvCore64ZIFENCEI.v`（RV32/RV64IM+Zifencei）与 `rtl/RiscvCoreZICNTR.v`/`rtl/RiscvCore64ZICNTR.v`（RV32/RV64IM+Zicntr）与 `rtl/RiscvCoreS.v`/`rtl/RiscvCore64S.v`（RV32/RV64IM，M/S/U 特权栈，含 S 级 CSR、异常/中断委托与 SRET），异步复位、标准 Verilog

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
- [x] RV32F / RV64F 单精度浮点扩展（FLW/FSW + FPU，`RvExtension.SingleFloat` 配置）
- [x] RV64D 双精度浮点扩展（FLEN=64，FLD/FSD + 双 FPU + 格式转换与 NaN-boxing，`RvExtension.DoubleFloat` 配置）
- [x] Zba/Zbb/Zbs/Zbc 位操作扩展（`RvExtension.Zba/Zbb/Zbs/Zbc` 配置，RV32/RV64 位宽均支持）
- [x] Zbkb/Zbkc/Zbkx 密码学位操作扩展（`RvExtension.Zbkb/Zbkc/Zbkx` 配置，以及组合 `Zbkb+Zbkc+Zbkx`，RV32/RV64 位宽均支持）
- [x] Zknh SHA-2 哈希位操作扩展（`RvExtension.Zknh` 配置，RV32/RV64 位宽均支持，RV32 提供 SHA-512 拆分形式）
- [x] Zksh/Zksed SM3/SM4 密码位操作扩展（`RvExtension.Zksh/Zksed` 配置，以及组合 `Zksh+Zksed`，RV32/RV64 位宽均支持）
- [x] Zknd/Zkne AES 密码位操作扩展（`RvExtension.Zknd/Zkne` 配置，以及组合 `Zknd+Zkne`，RV32/RV64 位宽均支持）
- [x] Zicond 条件运算扩展（`RvExtension.Zicond` 配置，RV32/RV64 位宽均支持）
- [x] Zcb 附加压缩扩展（`RvExtension.Zcb` 配置，RV32/RV64 位宽均支持）
- [x] Zifencei 指令流同步扩展（`RvExtension.Zifencei` 配置，RV32/RV64 位宽均支持）
- [x] Zicntr 用户计数器扩展（`RvExtension.Zicntr` 配置，RV32/RV64 位宽均支持）
- [x] S 模式（M/S/U 特权栈、S 级 CSR、异常与中断委托、SRET；`satp` 仅 BARE）
- [ ] 分支预测器（BHT/gshare 插件化）
- [ ] I/D 缓存、AXI4 总线桥
- [ ] 多核（`numCores` 参数 + 互联总线）

## 许可证

MIT
