# 「能不能好好说话？」的 powershell 版本

基于 [@itorr][] 的项目「[能不能好好说话？][]」的 powershell 版本。

# 使用

|           文件            |  编码   |      适用版本      |
| :-----------------------: | :-----: | :----------------: |
|     [`nbnhhsh.ps1`][]     |  utf8   |  PowerShell v6.0+  |
| [`nbnhhsh-utf8bom.ps1`][] | utf8bom | Windows PowerShell |

> In Windows PowerShell, any Unicode encoding, except UTF7, always creates a BOM. PowerShell (v6 and higher) defaults to utf8NoBOM.

下载根目录下的 [`nbnhhsh.ps1`][] 或 [`nbnhhsh-utf8bom.ps1`][] 到本地，执行该脚本即可。

![demo](./img/nbnhhsh-powershell-demo.webp)

# 致谢

- [能不能好好说话？][]by [@itorr][]

[`nbnhhsh.ps1`]: ./nbnhhsh.ps1
[`nbnhhsh-utf8bom.ps1`]: ./nbnhhsh-utf8bom.ps1
[@itorr]: https://github.com/itorr
[能不能好好说话？]: https://github.com/itorr/nbnhhsh
