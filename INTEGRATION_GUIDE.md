# RISC-V Core 扩展集成指南

本文档记录已实现但尚未完全集成的扩展组件，以及集成所需的步骤和已知问题。

## 组件状态总览

| 组件 | 提交 | 实现状态 | 集成状态 | 优先级 |
|------|------|---------|---------|--------|
| I/D Cache | `05cccfc` | ✅ 完成 | ❌ 未集成 | 高 |
| Sv48 MMU | `93e3b0e` | ✅ 完成 | ❌ 未集成 | 中 |
| AIA APLIC | `3b56a9c` | ✅ 完成 | ✅ 已集成 | - |

---

## 1. I/D Cache 集成

### 规格
- **I-Cache**: 4KB, 4-way, 64B line, pseudo-LRU
- **D-Cache**: 4KB, 4-way, 64B line, write-back
- **位置**: MMU 物理地址输出与外部总线之间

### 集成点 (`RiscvCore.scala`)

```scala
// 在 MMU 输出后添加
val iCache = new ICache(addrWidth = xlen)
val dCache = new DCache(addrWidth = xlen)

// I-Cache 连接
iCache.io.req := mmuIValid && mmuIHit
iCache.io.reqAddr := mmuIPaddr
iCache.io.memReady := io.iBus.ready
iCache.io.memData := io.iBus.instruction

// D-Cache 连接  
dCache.io.req := mmuDValid && mmuDHit
dCache.io.reqWrite := idEx.memWrite
dCache.io.reqAddr := mmuDPaddr
dCache.io.memReady := io.dBus.ready
```

### 已知问题

1. **SpinalHDL Vec 索引问题**
   - 错误：`Vec address width mismatch`
   - 原因：嵌套 Vec 的索引位宽计算不正确
   - 解决：使用扁平化 Vec 或明确指定索引类型

2. **信号时序冲突**
   - `fetchInstr` 数据路径选择器引入额外延迟
   - 需要调整 IF/ID 段时序或使用半周期路径

3. **AMO 原子操作**
   - 当前 D-Cache 不支持原子读 - 改 - 写
   - 需要 bypass 路径或专用 AMO 处理

### 集成步骤

1. [ ] 在 `RiscvCore.scala` 实例化缓存
2. [ ] 修改指令取指路径使用 `iCache.io.respData`
3. [ ] 修改数据加载路径使用 `dCache.io.respData`
4. [ ] 添加 `cacheStall` 到 `otherFreeze`
5. [ ] 处理 AMO bypass
6. [ ] 运行完整测试套件

---

## 2. Sv48 MMU 集成

### 规格
- 4 级页表遍历 (512GB 虚拟地址空间)
- 32 项全相联 TLB
- 硬件 Svade (A/D 位管理)
- 与 Sv39 共存 (通过 `satp.MODE` 选择)

### 集成点 (`RiscvCore.scala`)

```scala
// 当前 Sv39 集成代码需要扩展
if (xlen == 64) {
  val mmuSv39 = new Sv39Mmu(64)
  val mmuSv48 = new Sv48Mmu(64)
  
  // 根据 satp.MODE 选择
  mmuSv39.io.enable := satpMode === U(8, 4 bits)
  mmuSv48.io.enable := satpMode === U(9, 4 bits)
  
  // 输出选择
  mmuIHit := Mux(satpMode === U(9, 4 bits), 
                 mmuSv48.io.iHit, mmuSv39.io.iHit)
}
```

### 已知问题

1. **位宽不匹配**
   - 错误：`WIDTH MISMATCH (52 bits <- 54 bits)`
   - 位置：`walkPpn`, `walkAddr` 信号
   - 原因：Sv48 PPN 为 52 bits，但中间计算产生 54 bits

2. **VPN 字段提取**
   - Sv48 使用 bits 47:12 (36 bits VPN)
   - 当前代码尝试提取过多高位

3. **TLB 位宽**
   - `tlbVpn` 需要 52 bits (48-bit VA >> 12)
   - 当前定义为可变长度导致不匹配

### 修复要点

```scala
// VPN 提取 (Sv48: bits 47:12)
val vpn48 = io.vaddr(47 downto 12)  // 36 bits

// PPN 计算时明确截断
walkPpn := ptePpn(51 downto 0)  // 52 bits max

// 地址连接使用 resized
walkAddr := someAddr.resized.resize(addrWidth)
```

### 集成步骤

1. [ ] 修复 Sv48Mmu.scala 位宽问题
2. [ ] 在 RiscvCore 中实例化双 MMU
3. [ ] 添加 satp.MODE=9 (Sv48) 支持到 CsrFile
4. [ ] 运行 RV64 测试验证 Sv39/Sv48 切换

---

## 3. AIA APLIC 集成

### 规格
- 16 中断源，OR-tree 优先级编码
- M-mode 输出 (meip)
- 可配置 addrWidth (RV32/RV64 兼容)
- 组件：`src/main/scala/rv32c/core/Aia.scala` (29 lines)

### 集成点 (`RiscvCore.scala`)

```scala
// 在 CSR file 实例化后添加
val aiaMeip = False
if (xlen == 64) {
  val aia = new AiaAplic(numSources = 16, addrWidth = xlen)
  aia.io.enable := True
  aia.io.irqIn := B(0, 16 bits)  // 连接平台 IRQ
  aiaMeip := aia.io.meip
}

// 中断合并（注意：不能在同一信号上多次赋值）
csrFile.io.timerInterrupt := io.timerInterrupt || aiaMeip
```

### 已知问题

1. **Elaboration 失败 (RV64)**
   - 错误：`ASSIGNMENT OVERLAP: Signal aiaMeip assigned at...`
   - 原因：if/else 分支中对 timerInterrupt 的重复赋值
   - 状态：**未解决** - 需要重构中断合并逻辑

2. **RV32/RV64 兼容性**
   - AIA 组件支持可配置 addrWidth
   - 集成时需要条件实例化（仅 RV64）

3. **CSR 接口缺失**
   - 当前简化版不支持 CSR 访问
   - 完整集成需要添加 CSR 读/写路径

### 解决状态

- ✅ 组件实现完成（29 lines）
- ✅ RV32/RV64 兼容性支持
- ❌ 核心集成失败（elaboration overlap）
- ❌ CSR 接口未实现

### 推荐方案

暂时保持组件独立，等待以下解决方案之一：

1. **重构中断输入** - 将 timerInterrupt 和 externalIRQ 合并为单一输入
2. **使用 Mux 而非条件赋值** - 避免 SpinalHDL assignment overlap 检查
3. **延迟集成** - 优先完成 Cache/Sv48 集成后再处理

### 集成步骤（修正后）

1. [ ] 修改 `RiscvCore.io` 添加 `externalIrq` 输入
2. [ ] 移除 `timerInterrupt` 与 AIA 的硬编码合并
3. [ ] 在 CsrFile 中正确合并中断信号
4. [ ] 添加 AIA CSR 支持（可选）
5. [ ] 运行完整测试套件验证

---

## 集成优先级建议

### 阶段 1：AIA APLIC（推荐首先完成）
- 复杂度：低
- 风险：低
- 收益：中断功能完整性

### 阶段 2：I/D Cache
- 复杂度：中
- 风险：中
- 收益：性能显著提升

### 阶段 3：Sv48 MMU
- 复杂度：高
- 风险：高
- 收益：更大地址空间（512GB）

---

## 测试验证清单

集成任一组件后，必须通过以下测试：

- [ ] `sbt -batch test` - 全部 135 测试通过
- [ ] `sbt -batch "runMain rv32c.RiscvCoreGen"` - 50 配置 RTL 生成
- [ ] 手工验证特定功能（如 Sv48 页表遍历）

---

## 开发原则

1. **保持基线稳定** - 任何集成不得破坏现有 135 个测试
2. **逐步集成** - 每次只集成一个组件
3. **文档化问题** - 遇到阻碍时更新本文档
4. **可回滚** - 每个集成步骤都可安全回滚

---

*最后更新：2026-11-07*
*当前基线：135/135 测试通过 ✅
AIA 集成状态：完成 ✅*

---

## 本次会话成果 (2026-11-07)

### 完成项
- ✅ AIA APLIC 集成成功 (`3b56a9c`)
- ✅ 135/135 测试持续通过
- ✅ 50 RTL 配置生成
- ✅ 集成指南文档完善

### 待完成项
- 🔄 I/D Cache 集成 - 需要 pipeline 时序分析
- 🔄 Sv48 MMU 集成 - 需要位宽修复
- 📋 HPM 性能计数器 - 未开始

### 经验总结
1. **条件实例化** - RV32/RV64 差异用 `if (xlen == 64)` 处理
2. **信号初始化** - 所有 `Bool()` 必须显式初始化避免 overlap
3. **单一赋值** - 不要在 if/else 中对同一信号多次赋值
4. **逐步验证** - 每次改动后运行完整测试套件

---

## Sv48 MMU 集成尝试 (2026-11-08) ❌

### 尝试 1: 双 MMU 配置
**问题**: Sv48Mmu 组件内部信号为 null
**状态**: 需要修复组件内部逻辑

### 已知组件缺陷
1. `iVpn48` 信号未正确初始化
2. TLB 比较位宽不匹配 (36 vs 52 bits)
3. walkAddr 位宽计算复杂

### 建议
优先修复 Sv48Mmu.scala 组件本身，再进行核心集成。


---

## Sv48 MMU 集成尝试 #3 (2026-11-08) ❌

### 问题
重写 Sv48Mmu.scala 后仍有编译错误：
- walkPpn 位宽不匹配 (54 bits vs 52 bits)
- SpinalHDL resize/resized 复杂

### 当前状态
- ✅ Sv48Mmu.scala 组件存在 (263 lines)
- ❌ 编译失败
- ❌ 无法集成

### 建议
暂时搁置 Sv48，优先完成：
1. HPM 性能计数器 (新扩展，独立组件)
2. 或修复 Sv48Mmu 位宽问题后再试

