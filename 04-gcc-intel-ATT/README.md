- [gcc 编译器生成intel语体的汇编列表文件](#gcc-编译器生成intel语体的汇编列表文件)
- [gcc AT\&T语体](#gcc-att语体)
- [intel和AT\&T](#intel和att)
    - [1. **语法风格**](#1-语法风格)
    - [2. **操作数顺序**](#2-操作数顺序)
    - [3. **寄存器命名**](#3-寄存器命名)
    - [4. **立即数**](#4-立即数)
    - [5. **内存寻址**](#5-内存寻址)
    - [6. **指令后缀**](#6-指令后缀)
    - [7. **符号和注释**](#7-符号和注释)
    - [8. **工具和环境**](#8-工具和环境)
    - [9. **示例对比**](#9-示例对比)
    - [10. **优缺点**](#10-优缺点)
    - [11. **如何选择**](#11-如何选择)
    - [12. **转换工具**](#12-转换工具)
- [LC0标签](#lc0标签)
- [x86-64 Windows 调用约定（Microsoft x64 Calling Convention）](#x86-64-windows-调用约定microsoft-x64-calling-convention)
  - [参数传递优先级](#参数传递优先级)
  - [浮点参数](#浮点参数)





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
# intel和AT&T
Intel 汇编和 AT&T 汇编是两种主要的汇编语言语法格式，主要用于 x86 架构的处理器。它们在语法、寄存器命名、指令格式等方面有显著差异。以下是两者的详细对比：

---

### 1. **语法风格**
- **Intel 语法**：
  - 更直观，常用于 Windows 开发环境和 Intel 官方文档。
  - 语法接近于人类阅读习惯，指令格式为：`指令 目的操作数, 源操作数`。
  - 不需要过多符号修饰。
  - 示例：
    ```asm
    mov eax, ebx
    ```
  - 常用于 Microsoft 汇编器 (MASM) 和 NASM。

- **AT&T 语法**：
  - 更常见于 Unix/Linux 系统，尤其是 GNU 汇编器 (GAS)。
  - 语法更复杂，使用前缀符号（如 `%` 表示寄存器，`$` 表示立即数）。
  - 指令格式为：`指令 源操作数, 目的操作数`（与 Intel 相反）。
  - 示例：
    ```asm
    movl %ebx, %eax
    ```
  - 常用于 GCC 和 GDB。

---

### 2. **操作数顺序**
- **Intel**：目的操作数在前，源操作数在后。
  - 示例：`mov eax, 10`（将 10 移动到 eax）。
- **AT&T**：源操作数在前，目的操作数在后。
  - 示例：`movl $10, %eax`（将 10 移动到 eax）。

---

### 3. **寄存器命名**
- **Intel**：直接使用寄存器名称，如 `eax`, `ebx`, `ecx`。
  - 示例：`add eax, ebx`。
- **AT&T**：寄存器名前需加 `%` 前缀，如 `%eax`, `%ebx`。
  - 示例：`addl %ebx, %eax`。

---

### 4. **立即数**
- **Intel**：立即数直接写出，无需额外符号。
  - 示例：`mov eax, 100`。
- **AT&T**：立即数需加 `$` 前缀。
  - 示例：`movl $100, %eax`。

---

### 5. **内存寻址**
- **Intel**：使用方括号 `[]` 表示内存地址，偏移量和基址直接写出。
  - 示例：`mov eax, [ebx + 4]`（从 ebx+4 地址加载数据到 eax）。
- **AT&T**：使用圆括号 `()` 表示内存地址，格式为 `偏移量(基址, 索引, 比例)`。
  - 示例：`movl 4(%ebx), %eax`（从 ebx+4 地址加载数据到 eax）。

---

### 6. **指令后缀**
- **Intel**：通常不显式指定指令大小，依赖操作数推断。
  - 示例：`mov eax, ebx`（隐含 32 位操作）。
- **AT&T**：指令后通常加后缀表示操作数大小：
  - `b`（byte, 8 位）
  - `w`（word, 16 位）
  - `l`（long, 32 位）
  - `q`（quad, 64 位）
  - 示例：`movl %ebx, %eax`（32 位移动）。

---

### 7. **符号和注释**
- **Intel**：
  - 注释使用 `;`。
  - 符号（如标签）直接定义，无需额外前缀。
  - 示例：
    ```asm
    section .text
    global _start
    _start:
        mov eax, 1  ; 系统调用号
    ```
- **AT&T**：
  - 注释使用 `#` 或 `/* */`。
  - 全局符号需加 `.globl` 声明。
  - 示例：
    ```asm
    .text
    .globl _start
    _start:
        movl $1, %eax  # 系统调用号
    ```

---

### 8. **工具和环境**
- **Intel**：
  - 常见工具：NASM, MASM, TASM。
  - Windows 开发中更常见。
- **AT&T**：
  - 常见工具：GAS (GNU Assembler), 配合 GCC 使用。
  - Linux/Unix 系统中更常见。

---

### 9. **示例对比**
以下是一个简单的程序（将 42 移动到 eax 寄存器）在两种语法中的写法：

- **Intel 语法**：
  ```asm
  section .text
  global _start
  _start:
      mov eax, 42
  ```

- **AT&T 语法**：
  ```asm
  .text
  .globl _start
  _start:
      movl $42, %eax
  ```

---

### 10. **优缺点**
- **Intel 语法**：
  - **优点**：更简洁，易读，适合初学者。
  - **缺点**：在某些 Unix 工具中支持较少。
- **AT&T 语法**：
  - **优点**：与 GNU 工具链高度兼容，适合 Linux 开发。
  - **缺点**：语法复杂，符号多，学习曲线较陡。

---

### 11. **如何选择**
- **Windows 开发**：推荐 Intel 语法（NASM 或 MASM）。
- **Linux/Unix 开发**：推荐 AT&T 语法（GAS），或使用 NASM（支持 Intel 语法）并适配环境。
- **调试**：GDB 默认使用 AT&T 语法，但可以切换到 Intel 语法（使用 `set disassembly-flavor intel`）。

---

### 12. **转换工具**
- 如果需要在两种语法间转换，可以使用以下方法：
  - **手动转换**：根据上述规则修改代码。
  - **工具**：如 `objdump`（支持 `-M intel` 或 `-M att` 切换语法）。
  - **汇编器**：NASM（Intel 语法）和 GAS（AT&T 语法）可分别生成目标代码。

# LC0标签
```asm
.LC0:
    .ascii "Hello, World!\12\0"
```
- LC0这是定义了一个标签
- .ascii是一个汇编指令，用于在数据段中存储一个 ASCII 字符串。
- \12 是八进制转义字符，表示换行符（\n），在 ASCII 中对应值为 10
- \0 是字符串的终止符
# x86-64 Windows 调用约定（Microsoft x64 Calling Convention）
## 参数传递优先级
1. rcx
2. rdx
3. r8
4. r9
5. 第5个及以上的参数按顺序压入栈、栈上参数需要8字节对
## 浮点参数
1. xmm0
2. xmm1
3. xmm2
4. xmm3