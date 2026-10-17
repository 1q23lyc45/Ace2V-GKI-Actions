#!/usr/bin/env bash
set -e

echo "=== 开始克隆 ==="

# ---------------------------------------------------------------------------
# 1. 优先克隆 android_kernel_modules_oneplus_mt6983 到当前目录 (path="./")
# ---------------------------------------------------------------------------
echo ">>> [1/4] 正在将 android_kernel_modules_oneplus_mt6983 克隆到当前目录..."
git init
git remote add origin https://github.com/1q23lyc45/android_kernel_modules_oneplus_mt6983.git
git fetch origin lineage-22.2 --depth=1
git checkout -b lineage-22.2 origin/lineage-22.2

# ---------------------------------------------------------------------------
# 2. 克隆 android_kernel_oneplus_mt6983 到 path="kernel-5.10"
#    并处理 linkfile: dest="kernel_platform/common" src="."
# ---------------------------------------------------------------------------
echo ">>> [2/4] 正在克隆 android_kernel_oneplus_mt6983 到 kernel-5.10..."
mkdir -p kernel-5.10
git clone --depth=1 --branch lineage-22.2 \
    https://github.com/1q23lyc45/android_kernel_oneplus_mt6983.git \
    kernel-5.10

# 创建 Linkfile 软链接
echo ">>> 创建 linkfile 软链接 (kernel_platform/common -> ../kernel-5.10)..."
mkdir -p kernel_platform
rm -rf kernel_platform/common
ln -sf ../kernel-5.10 kernel_platform/common

# ---------------------------------------------------------------------------
# 3. 仅拉取指定的 Commit (避免全量克隆) - kernel/prebuilts/build-tools
# ---------------------------------------------------------------------------
echo ">>> [3/4] 正在拉取 kernel/prebuilts/build-tools 指定 Commit..."
mkdir -p kernel_platform/prebuilts/kernel-build-tools
cd kernel_platform/prebuilts/kernel-build-tools
git init
git remote add origin https://git.codelinaro.org/clo/la/kernel/prebuilts/build-tools.git
git fetch origin 10ab783184f77d3ea15bf666426a7138b0f62bfc --depth=1
git checkout FETCH_HEAD
cd - > /dev/null

# ---------------------------------------------------------------------------
# 4. 仅拉取指定的 Commit (避免全量克隆) - clang/host/linux-x86
# ---------------------------------------------------------------------------
echo ">>> [4/4] 正在拉取 clang host linux-x86 指定 Commit..."
mkdir -p kernel_platform/prebuilts-master/clang/host/linux-x86
cd kernel_platform/prebuilts-master/clang/host/linux-x86
git init
git remote add origin https://git.codelinaro.org/clo/la/kernelplatform/prebuilts-master/clang/host/linux-x86.git
git fetch origin 0fc3d01a780023469b7acc18c56a9cf5099a6d6c --depth=1
git checkout FETCH_HEAD
cd - > /dev/null

echo "=== 所有代码库同步及链接创建完成！ ==="
