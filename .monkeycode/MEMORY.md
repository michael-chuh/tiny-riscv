# User Instruction Memory

This file records user instructions, preferences, and teachings for reference in future interactions.

## Format

### User Instruction Entry
User instruction entries should follow this format:

[User Instruction Summary]
- Date: [YYYY-MM-DD]
- Context: [Mentioned scenario or time]
- Instructions:
  - [Content of user teaching or instruction, described line by line]

### Project Knowledge Entry
Entries discovered by the Agent during task execution should follow this format:

[Project Knowledge Summary]
- Date: [YYYY-MM-DD]
- Context: Discovered by Agent while performing [specific task description]
- Category: [Operations & Deployment|Build Methods|Testing Methods|Troubleshooting & Debugging|Workflow & Collaboration|Environment Configuration]
- Instructions:
  - [Specific knowledge points, described line by line]

## Deduplication Strategy
- Before adding a new entry, check for similar or identical instructions.
- If a duplicate is found, skip the new entry or merge it with the existing one.
- When merging, update the context or date information.
- This helps avoid redundant entries and keeps the memory file tidy.

## Entries

[User Instruction Summary]
- Date: 2026-09-10
- Context: 在配置模型层提交后，用户指定后续工作与提交规范
- Instructions:
  - Git 提交信息（commit message）此后一律使用英文书写
  - 配置模型层完成后，按依赖顺序从第 1 步继续推进（Decoder/CsrFile/trap 通路从 IsaConfig 派生态与合法集）

[Project Knowledge Summary]
- Date: 2026-09-16
- Context: Discovered by Agent while implementing the RV32C extension
- Category: Build Methods
- Instructions:
  - RTL 生成：`bash scripts/gen-rtl.sh` 调用 `rv32c.RiscvCoreGen`，按能力组合输出全部 42 个 `rtl/RiscvCore*.v`（位操作族含 `RiscvCoreB.v`/`RiscvCore64B.v` = Zbb、`RiscvCoreBS.v`/`RiscvCore64BS.v` = Zbs、`RiscvCoreBA.v`/`RiscvCore64BA.v` = Zba、`RiscvCoreBC.v`/`RiscvCore64BC.v` = Zbc、`RiscvCoreBKB.v`/`RiscvCore64BKB.v` = Zbkb、`RiscvCoreBKC.v`/`RiscvCore64BKC.v` = Zbkc、`RiscvCoreBKX.v`/`RiscvCore64BKX.v` = Zbkx、`RiscvCoreBK.v`/`RiscvCore64BK.v` = Zbkb+Zbkc+Zbkx、`RiscvCoreKNH.v`/`RiscvCore64KNH.v` = Zknh、`RiscvCoreKSH.v`/`RiscvCore64KSH.v` = Zksh、`RiscvCoreKSED.v`/`RiscvCore64KSED.v` = Zksed、`RiscvCoreKS.v`/`RiscvCore64KS.v` = Zksh+Zksed、`RiscvCoreKNE.v`/`RiscvCore64KNE.v` = Zkne、`RiscvCoreKND.v`/`RiscvCore64KND.v` = Zknd、`RiscvCoreKN.v`/`RiscvCore64KN.v` = Zknd+Zkne、`RiscvCoreZICOND.v`/`RiscvCore64ZICOND.v` = Zicond）；`rtl/` 已被 git 跟踪，重新生成后需一并提交
  - 测试命令：全量 `sbt -batch test`；单类 `sbt -batch "testOnly rv32c.sim.RiscvCoreTest"`；ISA 配置单测 `sbt -batch "testOnly rv32c.isa.IsaConfigSpec"`

[User Instruction Summary]
- Date: 2026-09-16
- Context: 用户指定 git 提交的作者签署规范
- Instructions:
  - 以后每次 git 提交都要增加 sign-off，作者为 Michael Chuh，邮箱 michael_chuh@163.com
  - 即在 commit message 末尾追加：`Signed-off-by: Michael Chuh <michael_chuh@163.com>`
