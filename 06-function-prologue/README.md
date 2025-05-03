# 函数序言(function prologue)和函数尾声
函数序言是函数在启动的时候运行的一系列指令
## 内容
其汇编指令大致如下
```asm
push rbp
mov rbp rsp
sub rsp x
```
## 功能
1. 在栈里面保存rbp的内容
2. 将rsp复制到rbp中
3. 修改栈，以便为函数的局部变量申请存储空间
## 退出
```asm
mov rsp rbp
pop rbp
ret 0
```
