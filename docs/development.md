# 开发指南

## 环境要求

- JDK 17+
- sbt 1.10.x
- iverilog（SpinalSim 仿真后端）

```bash
# 首次编译（会拉取 Scala/SpinalHDL 依赖）
sbt compile

# 运行全部测试
sbt test
# 或
./scripts/run-tests.sh

# 生成 Verilog
sbt "runMain rv32c.RiscvCoreGen"
# 或
./scripts/gen-rtl.sh
```

## 代码结构

```
src/main/scala/rv32c/
├── CoreConfig.scala       # 全局配置（改参数即改架构）
├── RiscvCore.scala        # 五级流水线 + 冒险控制（核心文件）
├── RiscvCoreGen.scala     # Verilog 生成入口
├── bus/BusInterfaces.scala
├── core/Alu.scala         # ALU + 操作枚举
├── core/RegisterFile.scala
├── core/Decoder.scala     # 组合译码 + 立即数生成
└── sim/SyncRamSim.scala   # 仿真内存模型
```

## 如何新增一条指令

以新增 M 扩展的 `MUL` 为例：

1. **扩展 ALU 枚举**：在 `core/Alu.scala` 的 `AluOp` 中增加 `MUL`，并在 `Alu` 的 `switch` 中加入对应逻辑。
2. **扩展译码器**：在 `core/Decoder.scala` 中为 `opcode=0110011, funct7=0000001, funct3=000` 的分支赋 `d.aluOp := AluOp.MUL`。
3. **确认数据通路**：R 型指令的 rs1/rs2/rd、写使能、写回选择（ALU 结果）均已通用，无需改动。
4. **补充测试**：在 `RiscvCoreTest` 中增加针对 `MUL` 的指令编码与寄存器断言。

> 如果新指令引入新的写回源或新的 EX 依赖，需要在 `RiscvCore.scala` 中同步扩展 `wbSel` 编码与冒险逻辑。

## 仿真测试

测试在 `src/test/scala/rv32c/sim/`：

- `CpuTb.scala`：把 `RiscvCore` 与指令/数据 RAM 组合成可仿真顶层，并加载程序
- `RiscvCoreTest.scala`：定义指令序列（手写编码），运行到目标 PC，检查寄存器堆

新增测试的步骤：

1. 用 Python/汇编器生成指令编码，例如：

```python
def enc(op, rd=0, f3=0, rs1=0, rs2=0, imm=0, fmt='I'):
    ...
```

2. 在 `RiscvCoreTest` 中增加 `test("描述") { ... }`，用 `runProgram` 运行并断言 `debugRegs`。

## 代码规范

- 位宽一律来自 `config.xlen`，禁止硬编码 32
- 组合逻辑用 `switch/when`，寄存器更新用流水线寄存器 + `valid` 位控制
- 新模块构造函数以 `xlen` 等参数传入，不访问全局
- 控制信号用枚举（`AluOp`/`BranchType`/`WbSel`），避免魔法数字
- 注释说明"为什么"，不解释"是什么"

## 常见问题

**Q：修改了配置但生成的 RTL 没变化？**
重新运行 `RiscvCoreGen`，确认新参数传入（`CoreConfig(xlen = 64)` 等）。

**Q：仿真出现 X 传播？**
检查流水线寄存器的 `init` 与 `valid` 位复位逻辑；复位后需等待若干周期再开始断言。
