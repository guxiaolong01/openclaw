#!/bin/bash
# OpenClaw官方仓库手动同步脚本

set -e

echo "🔧 OpenClaw官方仓库同步脚本"
echo "================================"

# 配置
UPSTREAM_REPO="https://github.com/openclaw/openclaw.git"
UPSTREAM_BRANCH="main"
MIRROR_BRANCH="main"

# 检查是否在Git仓库中
if [ ! -d .git ]; then
    echo "❌ 错误：当前目录不是Git仓库"
    exit 1
fi

# 添加上游远程仓库（如果不存在）
if ! git remote | grep -q upstream; then
    echo "➕ 添加上游远程仓库: $UPSTREAM_REPO"
    git remote add upstream "$UPSTREAM_REPO"
fi

# 获取上游更新
echo "🔄 获取上游仓库更新..."
git fetch upstream

# 检查是否有更新
LOCAL_COMMIT=$(git rev-parse $MIRROR_BRANCH)
UPSTREAM_COMMIT=$(git rev-parse upstream/$UPSTREAM_BRANCH)

if [ "$LOCAL_COMMIT" = "$UPSTREAM_COMMIT" ]; then
    echo "✅ 已经是最新版本，无需同步"
    echo "   本地提交: ${LOCAL_COMMIT:0:8}"
    echo "   上游提交: ${UPSTREAM_COMMIT:0:8}"
    exit 0
fi

echo "📥 发现更新，开始同步..."
echo "   本地提交: ${LOCAL_COMMIT:0:8}"
echo "   上游提交: ${UPSTREAM_COMMIT:0:8}"

# 合并上游更新
echo "🔀 合并上游更改..."
if git merge --no-edit upstream/$UPSTREAM_BRANCH; then
    echo "✅ 同步成功！"
    echo "   新提交: $(git rev-parse HEAD | cut -c1-8)"
    
    # 推送到镜像仓库
    echo "🚀 推送到镜像仓库..."
    if git push origin $MIRROR_BRANCH; then
        echo "🎉 同步完成并已推送！"
    else
        echo "⚠️  同步成功但推送失败，请手动推送"
    fi
else
    echo "❌ 合并冲突！需要手动解决"
    echo "   冲突文件:"
    git status --porcelain | grep -E "^UU"
    exit 1
fi

echo ""
echo "📊 同步统计:"
echo "   分支: $MIRROR_BRANCH"
echo "   时间: $(date)"
echo "   提交差异: $(git rev-list --count $LOCAL_COMMIT..HEAD) 个提交"
