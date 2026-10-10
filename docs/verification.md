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

全部为定向指令流 / 单元测试，`sbt test` 共 71 项。

### 指令与流水线（`src/test/scala/rv32c/sim/RiscvCoreTest.scala`）

| 用例 | 覆盖点 | 关键断言 |
|------|--------|----------|
| RV32I basic program | 基本 ALU、RAW 旁路、访存写读、load-use 冒险、分支、跳转自循环 | x3==12、x4==12、x6==17、被跳过指令未执行 |
| RV32M program | mul/mulh/mulhsu/mulhu、div/divu/rem/remu（含负数、除零、MIN/-1 溢出）与除法结果旁路 | 逐项结果 + 除法器结果转入后续 add |
| RV64I program | 64 位 `addi/slli/srai`、`*W` 截断与符号扩展、`sd/ld/lw/lwu` 载入扩展 | 逐项 64 位结果 |
| RV64M program | `MULW/DIVW/DIVUW/REMW/REMUW`（32 位判定、溢出、除零、结果符号扩展）与旁路 | 逐项结果 |
| RV64C program | RV64 专属压缩编码：`C.LD/C.SD`、`C.LDSP/C.SDSP`（doubleword 存取）、`C.ADDIW`、`C.SUBW/C.ADDW`、6 位 shamt 压缩移位（`C.SLLI 40`、`C.SRAI 33`）；并以起始于 `pc[1]=1` 的 32 位 `addi` 验证 xlen=64 下的半字拼接 | x9==1<<37、x10=-1、x11=0xFFFFFFFF80000001、x12==5、x13==0x7FFFFFFF、x14==x15==x16==0x100000001、x1==7（跨半字 32 位指令） |
| RV32C program | 压缩取指（2 字节 PC 粒度）、`pc[1]=1` 起始的 32 位指令拼接、Q0/Q1/Q2 代表指令（`C.LI/C.SWSP/C.LWSP/C.ADD/C.ADDI4SPN/C.SW/C.LW`） | x1==27、x3==7、x8==4、x10==7 |
| RV32C arith coverage | `C.ADDI/C.LUI/C.ADDI16SP/C.ANDI/C.SRLI/C.SRAI/C.SLLI/C.MV/C.ADD/C.SUB/C.XOR/C.OR/C.AND`，以及 imm=64 的 `C.SW/C.LW`（锁定 CRS2' 与 uimm[6] 字段） | x1==8、x16==0x1000、x2==36、x8==20、x9==7、x10==0xfffffffe、x11==32、x12==35、x13==8、x15==20 |
| RV32C flow coverage | `C.JAL`/`C.JR`/`C.BEQZ`（不跳）/`C.BNEZ`（跳）/`C.JALR`（链接=PC+2）/`C.J` 自循环 | x21==0x06、x1==0x22、x9==30、x10==1、x11==0、x15==4、x12==11 |
| RV32C reserved encoding traps | 保留压缩编码（`C.SRLI` shamt[5]=1）| `mcause==2`、`mepc` 指向故障压缩指令 |
| RV32A atomics program | `LR.W/SC.W` 成功与地址不匹配失败、9 种 `AMO*.W` 的旧值返回与内存结果、AMO 结果旁路（紧随的 `add` 依赖） | 逐项旧值/内存值，x9==0（SC 成功）、x13==1（SC 失败）、失败 SC 目标哨兵值不变 |
| RV64A atomics program | `LR.D/SC.D`、`AMOADD.D` 64 位运算、`AMO*.W` 在 RV64 上的低字/高字访问（含地址 12 的高 32 位）与符号扩展回写、`AMOMAXU.W` 32 位无符号比较 | x2==5、x4==8、x12==1、x19==0xFFFFFFFF80000000、x28==1、x29==0x600000000，其余逐项 |
| RV32A misaligned LR trap | `LR.W` 地址未按宽度对齐 | `mcause==4`、`mepc` 指向故障指令 |
| RV32A misaligned AMO trap | `AMOADD.W` 地址未按宽度对齐 | `mcause==6`、`mepc` 指向故障指令 |
| RV32F load/store + fcsr + FS dirtying | `FLW/FSW` 往返（含 FP load-use 停顿）、`fcsr` 写读、`mstatus.FS` 提交置位 | x2==42、x6==0x5F、`mstatus & 0x6000 == 0x6000` |
| RV32F arithmetic / compare / classify / FMA | `fcvt.s.w`、`fadd.s/fsub.s/fmul.s/fdiv.s/fsqrt.s`、`fmadd.s`、`flt.s/feq.s`、`fclass.s`、`fmv.x.w` 全链路 | x4=0x40E00000(7.0)、x5=0x3F800000(1.0)、x6=0x41400000(12.0)、x7=0x3FAAAAAB(4/3)、x8=0x40000000(2.0)、x9=0x41700000(15.0)、x10==1、x11==1、x12==0x40 |
| RV32F FP op with FS=Off traps | `FS=Off` 时执行 `FLW` | `mcause==2`、`mepc` 指向故障指令 |
| RV32F fcsr access with FS=Off traps | `FS=Off` 时访问 `fcsr` | `mcause==2`、`mepc` 指向故障 CSR 访问 |
| RV32F misaligned FLW traps | `FLW` 地址未按宽度对齐 | `mcause==4`、`mepc` 指向故障指令 |
| RV32F misaligned FSW traps | `FSW` 地址未按宽度对齐 | `mcause==6`、`mepc` 指向故障指令 |
| FpUnit standalone sanity (F) | 直接驱动参数化 `FpUnit(8,23)` 的 ADD/SUB/MUL/DIV/SQRT | 3+4=0x40E00000、4-3=1.0、3*4=0x41400000、4/3=0x3FAAAAAB、sqrt(4)=0x40000000、1+1=2.0、1+2=3.0、1*1=1.0 |
| FpUnit spec battery (F) | 5 种舍入模式（含 ties-to-even/away 与 RDN/RUP）、DIV/SQRT 边界、min/max（NaN/±0/sNaN NV）、FSGNJ 系列、FCMP、FCLASS 全 10 类、FMA 四变体、整数↔浮点转换（含负值→无符号 NV、饱和、NX/carry）、次正规结果（min normal×0.5、min normal×min subnormal） | 逐项结果与 NV/DZ/OF/UF/NX 标志位 |
| FpUnit spec battery (D) | 直接驱动 `FpUnit(11,52)`：FADD/FSUB/FMUL/FDIV/FSQRT、`FCVT.S.D`/`FCVT.D.S` 格式桥、OF/UF/NX 边界 | 3.0=`0x4008000000000000`、4/3=`0x3FF5555555555555`(NX)、sqrt(2)=`0x3FF6A09E667F3BCD`(NX)、`fcvt.d.s(3.0)=0x4008000000000000`、`fcvt.s.d(sNaN)=0x7FF8000000000000`(NV)、`1e300→0x7F800000`(OF+NX)、`2^-150→0`(UF+NX) |
| RV64D arithmetic, conversions, NaN-boxing | `FLD/FSD`、`fadd.d/fmul.d/fdiv.d`、`fcvt.s.d`/`fcvt.d.s`、`flt.d`、`fmadd.d`、`fclass.d` 全链路与单精度结果 NaN-boxing | x4=`0x401C000000000000`(7.0)、x5=1.0、x6=12.0、x7=`0x3FF5555555555555`(4/3)、x8=`0x40400000`(fcvt.s.d)、x9=3.0(fcvt.d.s)、x10==1、x11=15.0(fmadd.d)、x12==0x40(fclass.d)、x14=`0xFFFFFFFF40400000`(NaN-boxed) |
| RV32B (Zbb) bit manipulation | `andn/orn/xnor`、`min/minu/max/maxu`、`clz/ctz/cpop`（含 `clz 0`/`ctz 0`/`cpop 0` 边界）、`sext.b/sext.h/zext.h`、`orc.b/rev8`、`rol/ror/rori` | x4==12、x5==0xFFFFFFFF、x7==3、x8==15、x9==0xFFFFFFFF、x11==28、x14==32、x15==32、x16==0、x21==0xFFFFFF80、x25==0xFF、x26==0x0F000000、x27==0x78 |
| RV64B (Zbb) bit manipulation and W forms | 64 位计数/字节操作、`clzw/cpopw`、`rolw/rorw`、`zext.h`、6 位 shamt 的 `rori` 与 `roriw` | x5==60、x6==0、x8==`0x0F00000000000000`、x12==28、x16==`0xFFFFFFFF80000000`、x18==0xFFFF、x19==`0xE000000000000001`、x20==`0x1E0000000`、x21==`0xFFFFFFFF80000000` |
| RV32B (Zbs) single-bit operations | `bset/bclr/binv/bext` 寄存器与立即数形式、位索引回绕、`bexti` 0/1 | x3==8、x5==0xFFFFFFF7、x7==1、x9==0、x11==0xFFFFFFFE、x12==0x80000000、x15==1、x16==0、x19==8（索引 35 回绕到 bit3） |
| RV64B (Zbs) single-bit operations with 6-bit indices | 6 位位索引（`funct7` 低位携带 shamt[5]）与全宽结果 | x3==x4==`0x10000000000`(bit40)、x5==`0xFFFFFEFFFFFFFFFF`、x8==`0x8000000000000000`(bit63)、x10==`0x100000000`(bit32)、x11==`0xFFFFFFFFFFFFFFDF`（索引 69 回绕到 bit5） |
| RV32B (Zba) address generation | `sh1add/sh2add/sh3add`（交换操作数） | x3==13、x4==23、x5==43、x6==11 |
| RV64B (Zba) word forms zero-extend rs1 | `add.uw`（rs1 bit31=1 零扩展）、`slli.uw`（6 位 shamt）、`sh*add.uw`、64 位 `sh1add` | x7==`0x80000003`、x8==`0x800000000`、x9==`0x100000003`、x10==`0x200000003`、x11==`0x400000003`、x13==`0x200000003` |
| RV32B (Zbc) carry-less multiply | `clmul`（0b1011×0b1101）、`clmulh`/`clmulr`（跨 bit31 的积）、全 1 操作数 | x3==0x7F、x6==0、x7==1、x8==2、x10==x11==`0x55555555`、x12==`0xAAAAAAAA` |
| RV64B (Zbc) carry-less multiply across the 64-bit boundary | `clmulh`/`clmulr`（跨 bit63 的积）、全 1 操作数 | x3==0、x4==1、x5==2、x7==x8==`0x5555555555555555`、x9==`0xAAAAAAAAAAAAAAAA` |

### 特权/CSR/中断（`src/test/scala/rv32c/sim/ZicsrTrapTest.scala`）

CSR 读写与 WARL、M 模式同步异常（ecall/ebreak/非法指令/CSR 违例）、机器定时器中断 + MRET、U 模式往返。

### 配置模型单元测试

`IsaConfigSpec`（misa 推导、特权栈结构规则、F/D 结构规则、Zba/Zbb/Zbs/Zbc 结构规则与命名）与 `CsrMapSpec`（CSR 地址唯一性、只读集、FP CSR 可见性、异常码）共 36 项。

## 运行方式

```bash
sbt test
```

单类运行：`sbt "testOnly rv32c.sim.RiscvCoreTest"`。SpinalSim 默认使用 iverilog 后端（`SimConfig.withIVerilog`），结果输出到 `simWork/`。

## 待补强方向

1. **指令集全覆盖测试**：为 RV32I / RV64I 每条指令生成独立的定向测试
2. **RISC-V 官方合规测试**：对接 `riscv-tests`（ISA 测试套件），加载预编译的测试镜像
3. **随机化测试**：随机指令流 + 参考模型（如 Spike ISA 模拟器）对拍
4. **波形分析**：打开 SpinalSim 波形，人工检查冒险停顿拍数与旁路行为
5. **覆盖率**：指令/分支/冒险路径的功能覆盖率统计

## 测试平台说明

`CpuTb` 将 `RiscvCore` 与两个零等待内存相连：

- 指令内存：复位后从 `resetVector` 取指
- 数据内存：字节掩码读写

两者均为组合读、同步写，方便直接观察流水线行为。接入真实 SRAM/缓存后，此测试平台可继续复用（仅需替换内存模型）。
