# OpenClaw官方源代码镜像

这是一个OpenClaw官方源代码的完整镜像仓库，保持与[openclaw/openclaw](https://github.com/openclaw/openclaw)官方仓库的同步更新。

## 📦 仓库信息

- **官方仓库**: [openclaw/openclaw](https://github.com/openclaw/openclaw)
- **镜像仓库**: [guxiaolong01/openclaw-source-mirror](https://github.com/guxiaolong01/openclaw-source-mirror)
- **同步时间**: 2026-02-16 12:56
- **官方版本**: 2026.2.14
- **最新提交**: f1654b4 - test: isolate telegram bot behavior suite from unit-fast lane

## 🔄 同步机制

本仓库使用GitHub Actions自动同步官方仓库的更新：

1. **每日检查**: 每天UTC时间00:00检查官方仓库更新
2. **自动拉取**: 如果发现更新，自动拉取最新代码
3. **冲突处理**: 自动处理简单的合并冲突
4. **状态通知**: 同步结果通过GitHub Actions通知

## 📁 源代码统计

- **TypeScript文件**: 3,778 个
- **JavaScript文件**: 12 个  
- **JSON配置文件**: 116 个
- **文档文件**: 791 个
- **总文件数**: 5,673 个

## 🚀 使用方法

### 克隆本镜像
```bash
git clone https://github.com/guxiaolong01/openclaw-source-mirror.git
```

### 手动同步
```bash
cd openclaw-source-mirror
./sync-scripts/manual-sync.sh
```

## 📊 同步状态

![同步状态](https://github.com/guxiaolong01/openclaw-source-mirror/actions/workflows/sync.yml/badge.svg)

## 📝 许可证

本镜像仓库遵循OpenClaw官方仓库的许可证（MIT License）。
