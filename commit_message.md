# Commit Message

按照以下内容，统一 Commit Message。采用的是 Angular 规范，也是目前使用最广的规范。

## Commit Message 格式

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

注意，那个 ":" 后面有个**空格**。

上述格式简单来说只有三个部分。

- Header（必需）
    - 包含以下三个部分，type（必需）、scope（可选）和 subject（必需）
    - type：说明 commit 类型，只允许以下 7 个类型，由于本仓库放置的只有文档，所以基本上只会使用 docs 这一个 type
        - feat：新功能（feature）
        - fix：修补 bug
        - docs：文档（documentation）
        - style： 格式（不影响代码运行的变动）
        - refactor：重构（即不是新增功能，也不是修改 bug 的代码变动）
        - test：增加测试
        - chore：构建过程或辅助工具的变动
    - scope：说明本次 commit 影响范围
    - subject：本次 commit 简单描述

**注：1. 以动词开头，使用第一人称现在时，比如 change，而不是 changed 或 changes。 2. 第一个字母小写。3. 结尾不加句号**

- Body
    - Body 部分是对本次 commit 的详细描述，可以分成多行。

- Footer
    - Footer 部分只用于两种情况，1. 不兼容变动，如果当前代码与上一个版本不兼容，则 Footer 部分以 BREAKING CHANGE 开头，后面是对变动的描述、以及变动理由和迁移方法。2. 如果当前 commit 针对某个issue，那么可以在 Footer 部分关闭这个 issue。


参考：
    [Commit message 和 Change log 编写指南](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)