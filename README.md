# Ace2V-GKI-Actions

## 项目概述

本项目是一个专为一加 Ace 2V / Nord 3 的 AOSP 15 类原生系统（如 LineageOS 22）量身定制的高性能、精简型内核编译仓库。

⚠️ **警告**：本内核仅支持 Ace 2V / Nord 3 的 AOSP 15 类原生系统（如 LineageOS 22），绝对不支持官方 ColorOS / OxygenOS 系统！请在刷入前务必核对好您的系统环境，切勿在官方系统上盲目尝试！

## 获取与安装方法

### 1. 下载现成内核
您可以直接前往本仓库的 **[Releases](../../releases)** 页面下载打包好的 AnyKernel3 压缩包。

### 2. 自行构建内核
如果您希望自定义配置并自行编译：
1. **Fork 仓库**：请先点击页面右上角的 **Fork** 按钮，将本仓库复制到您自己的 GitHub 账号下。
2. **触发构建**：前往您 Fork 后的仓库 **[Actions](../../actions)** 页面手动触发编译工作流。
3. **获取产物**：待构建完成后，在对应的任务详情页面下载生成的 AnyKernel3 压缩包。

### 3. 刷入内核
下载好 AnyKernel3 压缩包后，您可以通过以下任意一种方式进行刷入：
- 使用 [KernelFlasher](https://github.com/fatalcoder524/KernelFlasher/releases) 在系统中直接刷入安装。
- 使用第三方 Recovery（如 **TWRP**、**CWM**、**OrangeFox** 等）刷入安装。

---

## 核心特性与架构：

- **内核安全加固**
- **BBR 拥塞控制**
- **TMPFS 扩展功能**
- **IPSet 增强**

---

## 内核特性与配置指南

### 1. 核心安全与系统防护

- **Ghostlock 补丁**：内核层强制集成与锁定，确保系统具备更高等级的安全防护。
- **Unicode 零宽漏洞内核级修复**：提供可选支持。按需开启；**注意：开启该功能后可能会导致小文件 I/O 性能下降**。相比传统的 LSPosed 模块修复方案，推荐在有需求时直接开启本仓库提供的内核级别修复。

### 2. 网络与存储性能配置

- **BBRv1 拥塞控制**：默认构建 BBRv1 支持。编译时开启仅代表内核层面对 BBR 的支持，并不会在开机时强行抢占默认拥塞控制算法。如需在日常使用中全面启用，请通过 Magisk 脚本（`service.sh`）开机自动配置，或使用 Termux 通过 `sysctl` 在运行时进行动态切换。
- **TMPFS 扩展功能**：
  - `CONFIG_TMPFS_XATTR=y`：启用 TMPFS 扩展属性支持，允许在内存文件系统中设置用户与安全扩展属性，通常用于容器化环境（如 Docker）或高级权限管理需求。
  - `CONFIG_TMPFS_POSIX_ACL=y`：启用 TMPFS 的 POSIX 访问控制列表支持，允许对内存文件系统进行更细粒度的权限控制。
- **IPSet 增强**（可选，通过工作流输入开启）：
  - 启用了大部分常用的内核 IPSet 核心框架、常见的 Hash 与 Bitmap 集合类型（如 IP、端口、MAC 及网段等）、Netfilter 匹配与目标动作（如 `CONFIG_NETFILTER_XT_SET` 等），以及 IPv6 NAT 及 TTL/HL 调整支持。用于支持复杂的防火墙规则、分流代理及网络策略路由优化。

---

## 作者碎碎念

欢迎大家提交 Issue 报告 Bug，也十分欢迎开发者提交 Pull Requests 共同维护！

本仓库专注于 LineageOS 22 / AOSP 15 类原生环境下的极致精简与流畅表现。请刷入前务必核对好您的系统环境（必须为类原生 AOSP 15），切勿在官方 ColorOS / OxygenOS 上盲目尝试！
