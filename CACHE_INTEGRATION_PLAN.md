# I/D Cache 集成计划

## 当前状态

- ✅ I-Cache 组件完成 (`ICache.scala`, 98 lines)
- ✅ D-Cache 组件完成 (`DCache.scala`, 110 lines)
- ✅ 编译测试通过
- ✅ 占位符已添加到 `RiscvCore.scala`
- ⏳ 核心集成待完成

## 集成架构

```
┌─────────────────────────────────────────────────────────┐
│                    RiscvCore                            │
│                                                         │
│  ┌──────────┐         ┌──────────┐                     │
│  │ I-Cache  │         │ D-Cache  │                     │
│  │ 4KB 4-way│         │ 4KB 4-way│                     │
│  └────┬─────┘         └────┬─────┘                     │
│       │                    │                            │
│       v                    v                            │
│  ┌─────────────────────────────────┐                   │
│  │     MMU (Sv39/Sv48)             │                   │
│  │  - TLB                          │                   │
│  │  - Page table walker            │                   │
│  └─────────────────────────────────┘                   │
│       │                    │                            │
│       v                    v                            │
│    iBus                 dBus                           │
└─────────────────────────────────────────────────────────┘
```

## 集成步骤

### 步骤 1: 实例化缓存组件

```scala
// 在 MMU 实例化后添加
val withCache = true  // Configurable
if (withCache) {
  val iCache = new ICache(addrWidth = xlen)
  val dCache = new DCache(addrWidth = xlen)
  
  // Connections...
}
```

### 步骤 2: 连接 I-Cache 数据路径

**位置**: `RiscvCore.scala:301` (IF 段)

```scala
// 当前
val word = io.iBus.instruction

// 修改为
val word = Mux(withCache && iCache.io.respReady, 
               iCache.io.respData, 
               io.iBus.instruction)
```

**位置**: `RiscvCore.scala:339` (IF 段)

```scala
// 当前
fetchInstr := io.iBus.instruction

// 修改为
fetchInstr := Mux(withCache && iCache.io.respReady,
                  iCache.io.respData,
                  io.iBus.instruction)
```

### 步骤 3: 连接 D-Cache 数据路径

**位置**: `RiscvCore.scala:1309-1321` (WB 段)

```scala
// 当前
val byte = (io.dBus.readData >> (storeOffset * 8))(7 downto 0)

// 修改为
val dBusReadData = Mux(withCache && dCache.io.respReady,
                       dCache.io.respData,
                       io.dBus.readData)
val byte = (dBusReadData >> (storeOffset * 8))(7 downto 0)
```

### 步骤 4: 添加缓存控制信号

```scala
// Cache stall
val iCacheStall = withCache && iCache.io.req && !iCache.io.respReady
val dCacheStall = withCache && dCache.io.req && !dCache.io.respReady
val cacheStall = iCacheStall || dCacheStall

// 添加到 freeze 条件
val otherFreeze = memStall || fetchStall || ... || cacheStall
```

### 步骤 5: 连接 MMU 到缓存

```scala
// I-Cache MMU 接口
iCache.io.req := io.iBus.valid && mmuIHit
iCache.io.reqAddr := mmuIPaddr
iCache.io.memReady := io.iBus.ready
iCache.io.memData := io.iBus.instruction

// D-Cache MMU 接口
dCache.io.req := io.dBus.valid && mmuDHit && !idEx.atomic
dCache.io.reqWrite := idEx.memWrite
dCache.io.reqAddr := mmuDPaddr
dCache.io.memReady := io.dBus.ready
```

### 步骤 6: 处理 AMO 原子操作

AMO 操作需要 bypass 缓存：

```scala
// AMO bypass
val dCacheReq = io.dBus.valid && mmuDHit && !idEx.atomic
dCache.io.req := dCacheReq

// AMO 仍然走原始路径
when(idEx.atomic) {
  // Use io.dBus.readData directly
}
```

## 已知问题

### 1. Pipeline 时序

**问题**: 缓存访问引入额外延迟

**解决**:
- Option A: 插入 bubble 周期
- Option B: 使用半周期路径
- Option C: 调整 pipeline 级数

### 2. AMO 原子操作

**问题**: D-Cache 不支持读 - 改-写原子性

**解决**:
- Option A: AMO bypass 缓存
- Option B: 实现 atomic 路径
- Option C: 软件模拟 (LR/SC)

### 3. Cache 一致性

**问题**: I/D Cache 可能看到不一致数据

**解决**:
- 实现 `fence.i` 指令
- I-Cache flush on demand
- 软件管理一致性

## 测试计划

### 单元测试
- [ ] I-Cache 命中测试
- [ ] I-Cache 缺失测试
- [ ] D-Cache 命中测试
- [ ] D-Cache write-back 测试
- [ ] TLB 刷新测试

### 集成测试
- [ ] RV32I 基准测试 (带缓存)
- [ ] RV64I 基准测试 (带缓存)
- [ ] Cache 性能测试
- [ ] AMO bypass 测试
- [ ] fence.i 测试

### 回归测试
- [ ] 全部 135 测试通过
- [ ] 50 RTL 配置生成
- [ ] 性能基准对比

## 验收标准

1. **功能正确**
   - 135/135 测试通过
   - 无 functional bug

2. **性能提升**
   - IPC 提升 > 20% (估计)
   - Cache 命中率 > 85%

3. **代码质量**
   - 无编译警告
   - 无 timing violation
   - 文档完整

## 时间估算

| 步骤 | 预计时间 | 风险 |
|------|---------|------|
| 数据路径集成 | 2-3 小时 | 低 |
| 控制信号集成 | 1-2 小时 | 低 |
| AMO bypass | 2-3 小时 | 中 |
| 时序修复 | 4-8 小时 | 高 |
| 测试验证 | 2-3 小时 | 低 |
| **总计** | **11-19 小时** | **中** |

## 下一步

1. 实现步骤 1-3 (数据路径)
2. 运行测试验证
3. 实现步骤 4-5 (控制信号)
4. 处理 AMO bypass
5. 时序优化
6. 完整测试

---

*创建时间：2026-11-07*
*当前状态：准备开始集成*
