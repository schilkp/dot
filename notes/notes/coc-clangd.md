=== coc-clangd ===

Handles c/c++ CoC features.

Needs npm installed.

Based on the clangd language sever, which may need to be installed:
:CocCommand clangd.install (not available anymore?)

== Code Format ==

The clangd server looks for a .clang-format file in the project, on which the
auto-format will be based.

Standard formats (llvm, google, usw) can be dumped from clang-format:
> clang-format -style=llvm -dump-config > .clang-format

This won't change vim's settings, most importantly indent-style.
Use a .editorconfig file + editorconfig plugin to handle that.

== Compilation Information ==

To be useful, clangd needs to know how the source files are compiled.
This can be provided with either a compile_flags.txt or a compile_commands.json
file in the project directory.

=== compile_flags.txt ===

Place a compile_flags.txt at the root of the project. 
Each line is one flag passed to the compiler.

Only include flags that clang would recognize (i.e. no point
parsing arm-none-eabi-gcc's -mcpu=cortex-m4)

Example compile_flags.txt:
-g3
-ggdb
-DUSE_HAL_DRIVER
-DSTM32F303xC
-DDEBUG
-ICore/Inc
-IDrivers/STM32F3xx_HAL_Driver/Inc
-IDrivers/STM32F3xx_HAL_Driver/Inc/Legacy
-IDrivers/CMSIS/Device/ST/STM32F3xx/Include
-IDrivers/CMSIS/Include
-IDrivers/CMSIS/Include
-Wall
-Wextra
-Wpedantic
-xc
-std=c99

Even if the compile_commands.json file that bear generates is not used,
it can be a quick starting point to create the compile_flags.txt

IMPORTANT: Trailing spaces after an include will break it!

=== compile_commands.json ===

A json file that list the exact commands/flags that each file is compiled with.
Has not worked that well in stm32 projects, but may have been user error.

Use compile_flags.txt unless you really need per-file setup.

Can be generated using bear:
> make clean
> bear make
