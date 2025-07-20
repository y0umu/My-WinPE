# My WinPE

There is also an [English version](README_en.md) of README

## 简介

这是我自己的 [Windows PE (WinPE)](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpe-intro) 镜像。它主要反映我个人的偏好。基本上这是一个“纯净版”的 WinPE，带有一个简单的 Blackbox 风格界面。咱并不打算与那些 Linux LiveCD 竞争，也不打算替代那些“功能齐全”的预构建 Windows PE 镜像，例如 [wepe](https://www.wepe.com.cn)、[老毛桃winpe](https://www.laomaotao.net) 或 [Hiren's BootCD](https://www.hirensbootcd.org)。

包含的一些工具包括：
* [bbLean](http://bb4win.sourceforge.net/bblean/)，提供了一个复古风格的用户界面；
* [busybox](https://frippery.org/busybox/)，带来了一些类 Unix 的体验；
* [Double Commander](https://doublecmd.sourceforge.io/)，用于替换 explorer.exe (WinPE 里面没有 explorer.exe)。这个强大的工具能够编辑文本文件、以十六进制格式读取二进制文件、查看图片等等；
* [TestDisk 和 PhotoRec](https://www.cgsecurity.org/)，用于磁盘和文件恢复；
* 离线 NT 密码与注册表编辑器（https://pogostick.net/~pnh/ntpasswd/，链接似乎已经失效了），以备你不知为何锁定了你那几千个虚拟机之中的某个 Windows 账户或忘记了它的密码。你当然需要一个 Windows 版本的 [chntpw](https://github.com/y0umu/chntpw_mingw64) 。

部分非自由软件（非 FOSS）应用已经不再包含。可以检查 `my-winpe.cmd` 中被注释掉的行查看是哪些软件。

## 截图
![screenshot_1_testdisk.png](screenshots/screenshot_1_testdisk.png)
![screenshot_2_chntpw.png](screenshots/screenshot_2_chntpw.png)

## 预构建镜像
请查看 [发布页面](https://github.com/y0umu/My-WinPE/releases/latest)。

注意，我将这些 ISO 镜像放在发布页面上，**仅是出于我个人的方便的目的**。通过下载这些 ISO 镜像，你即表示你愿意自行承担有关风险（无论是法律上还是技术上的风险）。

## 有用的技巧
### 解锁 BitLocker
假设你已经提前备份了 BitLocker 密钥/密码，可以通过以下命令解锁：
```cmd
manage-bde -unlock D: -rk E:\path\to\your\key
```
或者：
```cmd
manage-bde -unlock D: -rp YOUR-BITLOCKER-PASSWORD
```

### 更新 Intel 管理引擎（Intel ME）
你得自己去找主板厂商提供的驱动程序。 `update_me.cmd` 提供了一个更新 Intel ME 的示例。

### 重启 WinPE
由于 `winpeshl.exe` 的机制，你需要终止 `%SYSTEMROOT%\System32\winpeshl.ini` 中列出的最后一个运行进程才能重启。在我的镜像中，这个进程是 bbLean/Blackbox。你可以右键点击桌面，选择 Blackbox > Quit 来实现。你也可以运行 `wpeutil reboot`。

## 如何构建这个 WinPE 镜像

你大概需要一个合法的 Windows 副本来进行操作。大致步骤如下：
1. 安装 ADK **以及** ADK Windows PE 插件。参考 [ADK](https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install) 的文档。
2. 以管理员权限打开终端，运行 `C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\DandISetEnv.bat`。
3. 运行 `copype amd64 WinPE_amd64`。
4. 检查并修改 `my-winpe.cmd`。获取所需的工具后，运行 `my-winpe.cmd`。
5. （可选）在虚拟机中测试你的镜像。
6. 使用 `MakeWinPEMedia /ufd WinPE_amd64 J:` 将其写入U盘（假设你的U盘盘符为 J）。或者你也可以使用 [ventoy](https://www.ventoy.net)。

**注意**：如果用 `MakeWinPEMedia` 创建启动U盘，你的U盘的分区表必须为 MBR，否则 `MakeWinPEMedia /ufd` 会失败。更多信息可参考 [此链接](https://docs.microsoft.com/en-us/answers/questions/249767/makewinpemedia-fails-for-me.html)。

### 其他有用链接
Arch Wiki 上的 Windows PE 页面：https://wiki.archlinux.org/title/Windows_PE
