# 代码如下
```asm
int main(){
    printf("a=%d,b=%d,c=%d,d=%d,e=%d,f=%d,g=%d,h=%d\n",1,2,3,4,5,6,7,8);
    return 0;
}
```
# 编译结果
```asm
main	PROC

	sub	rsp, 88					; 00000058H
	mov	DWORD PTR [rsp+64], 8
	mov	DWORD PTR [rsp+56], 7
	mov	DWORD PTR [rsp+48], 6
	mov	DWORD PTR [rsp+40], 5
	mov	DWORD PTR [rsp+32], 4
	mov	r9d, 3
	mov	r8d, 2
	mov	edx, 1
	lea	rcx, OFFSET FLAT:$SG7533
	call	printf

	xor	eax, eax
	add	rsp, 88					; 00000058H
	ret	0
main	ENDP
```
# 数据分配8个字节
数据存储空间不足64位，编译器还会给它分配8字节的存储空间
所以，64位系统为所有类型的数据都保留8字节空间
同理，32位系统也为所有类型的数据都保留4字节
# 传递参数
使用rcx、rdx、r8、r9
使用栈来传递其他的参数
# DWORD
`DWORD`=Double Word
在x86架构中，一个DWORD占用4字节（32位）
BYTE=1字节（8位）
WORD=2字节 （16位）
DWORD=4字节 （32位）
QWORD=8字节（64位）
`DWORD`本质上就是一个32位（4字节）的数据类型定义，
在汇编语言中用于明确指定要操作的数据大小。
`PTR` 是一个类型修饰符（type specifier），用于明确指定内存操作数的数据类型
# lea	rcx, OFFSET FLAT:$SG7533
- 将符号 `$SG7533`的地址加载到 rcx 寄存器
lea：load Effective Address
`lea`指令用于计算地址（而不是直接访问内存）
它常用于计算偏移地址，而不会真正访问内存数据
`OFFSET FLAT`：
	`OFFSET`:表示获取符号的偏移地址
	`FLAT`:表示在平坦内存模型（FlatMemoryModel）下计算地址（现代操作系统通常使用平坦内
存模型，所有段寄存器指向同一个地址空间）
组合起来：`OFFSET FLAT`：表示取`$SG7533`的绝对地址。
# PTR的作用
1. 指定内存访问的大小
- `DWORD PTR`表示要写一个32位的值
2. 强制类型转换
