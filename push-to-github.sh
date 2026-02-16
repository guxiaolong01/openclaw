#!/bin/bash

# OpenClaw官方源代码镜像推送脚本
# 将本地镜像仓库推送到GitHub

set -e

echo "🚀 开始推送OpenClaw官方源代码镜像到GitHub..."

# 设置Git配置
git config --global user.name "OpenClaw Mirror Bot"
git config --global user.email "guxiaolong01@users.noreply.github.com"

# 检查当前目录
if [ ! -f "README.md" ]; then
    echo "❌ 错误：请在OpenClaw镜像仓库根目录运行此脚本"
    exit 1
fi

# 检查GitHub token
if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ 错误：请设置GITHUB_TOKEN环境变量"
    echo "export GITHUB_TOKEN=your_token_here"
    exit 1
fi

# 添加所有文件
echo "📦 添加文件到Git..."
git add .

# 检查是否有更改
if git diff --cached --quiet; then
    echo "📝 没有需要提交的更改"
else
    # 提交更改
    echo "💾 提交更改..."
    git commit -m "feat: 同步OpenClaw官方源代码

- 官方版本: 2026.2.14
- 最新提交: f1654b4 - test: isolate telegram bot behavior suite from unit-fast lane
- 文件统计: 5,673个文件 (3,778 TypeScript, 12 JavaScript, 116 JSON, 791文档)
- 同步时间: $(date +'%Y-%m-%d %H:%M:%S')
- 同步机制: GitHub Actions每日自动同步 + 手动同步脚本"
fi

# 设置远程仓库
REMOTE_URL="https://${GITHUB_TOKEN}@github.com/guxiaolong01/openclaw-source-mirror.git"
echo "🔗 设置远程仓库: guxiaolong01/openclaw-source-mirror"

# 检查是否已有远程仓库
if ! git remote | grep -q origin; then
    git remote add origin "$REMOTE_URL"
else
    git remote set-url origin "$REMOTE_URL"
fi

# 推送到GitHub
echo "🚀 推送到GitHub..."
git push -u origin main --force

echo "✅ 推送完成！"
echo "📊 仓库地址: https://github.com/guxiaolong01/openclaw-source-mirror"
echo "🔄 同步机制: GitHub Actions每日自动同步"
