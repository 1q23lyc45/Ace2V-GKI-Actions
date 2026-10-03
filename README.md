# Ace2V-GKI-Actions

## 项目概述

本项目是一个专为一加 Ace 2V / Nord 3 的 AOSP 15 类原生系统（如 LineageOS 22）量身定制的高性能、精简型内核编译仓库。

⚠️ **警告**：本内核仅支持 Ace 2V / Nord 3 的 AOSP 15 类原生系统（如 LineageOS 22），绝对不支持官方 ColorOS / OxygenOS 系统！请在刷入前务必核对好您的系统环境，切勿在官方系统上盲目尝试！

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
  - 核心框架及最大集合：`CONFIG_IP_SET=y`、`CONFIG_IP_SET_MAX=65534`。
  - 各种 Hash 与 Bitmap 集合类型：`CONFIG_IP_SET_BITMAP_IP=y`、`CONFIG_IP_SET_BITMAP_IPMAC=y`、`CONFIG_IP_SET_BITMAP_PORT=y`、`CONFIG_IP_SET_HASH_IP=y`、`CONFIG_IP_SET_HASH_IPMARK=y`、`CONFIG_IP_SET_HASH_IPPORT=y`、`CONFIG_IP_SET_HASH_IPPORTIP=y`、`CONFIG_IP_SET_HASH_IPPORTNET=y`、`CONFIG_IP_SET_HASH_IPMAC=y`、`CONFIG_IP_SET_HASH_MAC=y`、`CONFIG_IP_SET_HASH_NETPORTNET=y`、`CONFIG_IP_SET_HASH_NET=y`、`CONFIG_IP_SET_HASH_NETNET=y`、`CONFIG_IP_SET_HASH_NETPORT=y`、`CONFIG_IP_SET_HASH_NETIFACE=y`、`CONFIG_IP_SET_LIST_SET=y`。用于支持复杂的 IP、端口、MAC 及网段哈希/位图集合，常用于高级防火墙或分流代理。
  - Netfilter 匹配与目标动作：`CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y`、`CONFIG_NETFILTER_XT_SET=y`、`CONFIG_NETFILTER_XT_TARGET_LOG=y`、`CONFIG_NETFILTER_XT_MATCH_RECENT=y`、`CONFIG_NET_ACT_CONNMARK=y`。提供地址类型匹配、IPSet 动作关联、日志记录、Recent 报文匹配及连接标记等增强网络过滤功能。
  - IPv6 NAT 及 TTL/HL 调整：`CONFIG_IP6_NF_NAT=y`、`CONFIG_IP6_NF_TARGET_MASQUERADE=y`、`CONFIG_IP_NF_TARGET_TTL=y`、`CONFIG_IP6_NF_TARGET_HL=y`、`CONFIG_IP6_NF_MATCH_HL=y`。用于支持 IPv6 网络地址转换、伪装出口、IPv4 TTL 及 IPv6 跳数（Hop Limit）修改，适用于网络共享与策略路由优化。

---

## 作者碎碎念

欢迎大家提交 Issue 报告 Bug，也十分欢迎开发者提交 Pull Requests 共同维护！

本仓库专注于 LineageOS 22 / AOSP 15 类原生环境下的极致精简与流畅表现。请刷入前务必核对好您的系统环境（必须为类原生 AOSP 15），切勿在官方 ColorOS / OxygenOS 上盲目尝试！