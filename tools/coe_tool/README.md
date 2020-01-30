# 使用说明

**前提**：在 Linux 环境（最好是 Ubuntu16.04）中安装有龙芯的 ls232 工具链，[安装指导](https://github.com/bit-mips/bitmips_experiments_doc/blob/master/others/cross_compiler.md)。

将 `coe_file.zip` 压缩包下载至本地，然后将其解压。修改 `inst_rom.S`文件，执行 `make` 命令即可编译 `inst_rom.S` 文件中的 MIPS 汇编代码，并生成相应的 coe 文件。