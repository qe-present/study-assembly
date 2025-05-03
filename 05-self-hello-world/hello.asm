section .data
    msg     db  'hello world!', 0xD, 0xA  ; 消息字符串，CRLF换行
    len     equ $ - msg                    ; 消息长度

section .bss
    written resd 1                         ; 预留 4 字节（DWORD）用于存储写入字节数

section .text
    extern GetStdHandle                    ; 声明外部函数 GetStdHandle
    extern WriteConsoleA                   ; 声明外部函数 WriteConsoleA
    extern ExitProcess                     ; 声明外部函数 ExitProcess
    global main                          ; 声明入口点 _start
main:
    ; 获取标准输出句柄
    mov     rcx, -11                       ; STD_OUTPUT_HANDLE = -11
    call    GetStdHandle                   ; 调用 GetStdHandle
    mov     rbx, rax                       ; 保存句柄到 rbx

    ; 调用 WriteConsoleA
    mov     rcx, rbx                       ; 句柄
    lea     rdx, [rel msg]                 ; 使用 rip 相对寻址加载 msg 地址
    mov     r8, len                        ; 消息长度
    lea     r9, [rel written]              ; 使用 rip 相对寻址加载 written 地址
    push    0                              ; 第五个参数：保留，设置为 0
    sub     rsp, 32                        ; 分配 32 字节影子空间
    call    WriteConsoleA                  ; 调用 WriteConsoleA
    add     rsp, 40                        ; 清理栈（32 字节影子空间 + 8 字节 push）

    ; 退出程序
    xor     rcx, rcx                       ; 返回码 0
    call    ExitProcess                     ; 调用 ExitProcess

