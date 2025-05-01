# gcc生成exe文件
```shell
gcc hello.c -o hello
```
# ida逆向汇编代码
```asm
; Attributes: bp-based frame

; int __fastcall main(int argc, const char **argv, const char **envp)
public main
main proc near
push    rbp
mov     rbp, rsp
sub     rsp, 20h
call    __main
lea     rax, Format     ; "Hello, World!\n"
mov     rcx, rax        ; Format
call    printf
mov     eax, 0
add     rsp, 20h
pop     rbp
retn
main endp
```
# AI的解释
让我解释这段 x86-64 汇编代码：

1. 函数声明和属性：
```asm
; Attributes: bp-based frame
; int __fastcall main(int argc, const char **argv, const char **envp)
public main
main proc near
```
- `bp-based frame`：使用基址指针（rbp）作为栈帧基址
- `__fastcall`：快速调用约定，参数通过寄存器传递
- `public main`：声明 main 函数为公共符号

2. 栈帧设置：
```asm
push    rbp            ; 保存旧的基址指针
mov     rbp, rsp       ; 设置新的基址指针
sub     rsp, 20h       ; 分配32字节栈空间
```
- 保存旧的 rbp
- 设置新的栈帧基址
- 分配32字节栈空间（0x20 = 32）

3. 函数调用：
```asm
call    __main         ; 调用C运行时初始化
lea     rax, Format    ; 加载字符串地址
mov     rcx, rax       ; 将字符串地址作为参数
call    printf         ; 调用printf函数
```
- 调用 C 运行时初始化
- 准备 printf 的参数
- 调用 printf 函数

4. 返回处理：
```asm
mov     eax, 0         ; 设置返回值为0
add     rsp, 20h       ; 释放栈空间
pop     rbp            ; 恢复旧的基址指针
retn                   ; 函数返回
```
- 设置返回值
- 恢复栈空间
- 恢复基址指针
- 返回调用者

5. 主要特点：
- 使用 rbp 作为栈帧基址
- 分配32字节栈空间
- 通过 rcx 传递第一个参数
- 使用标准的函数序言和结语

这段代码展示了一个标准的 x86-64 函数框架，包括栈帧设置、参数传递和清理工作。
# 如下注释的意思
```
; Attributes: bp-based frame
``` 
; Attributes 是IDA自动生成的注释
`bp` 代表 Base Pointer（基址指针）——在64位中,bp就是rbp
`bp-based frame`（基址指针栈帧）
- 在函数开始时会保存和设置rbp
- 函数结束会恢复rbp
- 通过rbp相当寻找访问局部变量
# ; int __fastcall main(int argc, const char **argv, const char **envp)什么意思
- int 函数返回类似是整数
- __fastcall 调用约定，表示参数通过寄存器传递
- main 函数名
- argc 命令行参数个数
- argv 命令行参数数组
- envp 环境变量数组
- 前4个整数参数 rcx、rdx、r8、r9
- 前4个浮点数参数 xmm0、xmm1、xmm2、xmm3
# public main
- 生成main是public
# main proc near
- proc是procedure的缩写
- near表示进调用
# push rbp
- push是将数据压入栈中
- rbp是基址指针寄存器
- 合起来就是将rbp 的值保存到栈中
# mov rbp rsp
- mov是移动的意思
- rbp是基址指针
- rsp是栈指针
- rsp的值复制到rbp
-push rbp 。rbp不变，rsp变化， mov rbp rsp  让rsp复制到rbp ，说白了rsp和rbp一起指向
# sub rsp, 20h
- 初始化栈空间32字节
- 栈顶向下移动32字节
# lea rax, Format
- lea 加载有效地址Load Effective Address
- rax 目标寄存器
- Format 字符串"hello world\n" 的地址
# mov rcx, rax
- rcx 目标寄存器
- rax 源寄存器
- rax复制到rcx
# mov eax 0
- eax值设为0
- rax寄存器用于存储函数的返回值
- 设置rax为0，就是设置main函数的返回值为0
# add sub
- add 是加
- sub 是subtraction 减   
# add rsp 20h
- 栈顶向上移动32字节
- 释放栈
# pop rbp
- pop 是弹出
- rbp 是基址指针
- 弹出栈顶的值到rbp
# retn
- retn 是return near
- 函数返回
# main endp
- endp 是procedure的缩写
- 函数结束
# gcc 编译器生成intel语体的汇编列表文件
- `-S -masm=intel`
# gcc AT&T语体
比如
- pushq	%rbp
```assembly
	.file	"hello.c"
	.text
	.def	printf;	.scl	3;	.type	32;	.endef
	.seh_proc	printf
```
由小数点开头的就是宏
