

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

