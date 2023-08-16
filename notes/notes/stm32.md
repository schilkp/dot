=== STM32 development ===

== Toolchain install / Project Setup ==

arm-none-eabi-gcc for compilation (apt install)
gbc-multiarch (apt install)

For my stm32 makefile, see the makefiles repo.

The easiest workflow for setting up that makefile is the following:
    - Create a *makefile* project using CubeMX
    - Adapt this makefile to reflect the project-specific settings from CubeMX's makefile, including:
        - Needed Source/ASM files
        - Include directories
        - MCU specific compilation flags
        - Optimization flags
        - Pre-processor defines 
        - Linker script name 

== Uploading/Debugging ==

= Setting up a GDB server =

A GDB server that talks to the debugger needs to be running.
There are a few options:
    - st-utils
    - ST's st-link server installed with CubeIDE under windows
    - openocd
    - A Blackmagic probe
    - ...

Under wsl:

    Since wsl does not offer USB pass through, the GDB server must run in windows directly. 
    GDB can still access it from the wsl vm.
    
    It is possible to start st-utils in windows and connect, but I have found
    it to be buggy and not work too well.
    
    ST's own st-link server installed with CubeIDE runs the smoothest. 
    It is located here:
    
    C:\ST\STM32CubeIDE_1.3.0\STM32CubeIDE\plugins\com.st.stm32cube.ide.mcu.externaltools.stlink-gdb-server.win32_1.3.0.202002181050\tools\bin\ST-LINK_gdbserver.exe 
    
    When launching it, it needs the following flags:
    -e -d -v -cp "path_to_cube_prog"
        
        -v : Verbose
        -e : Persistent mode, I don't want to have to relaunch it every time
        -d : SWD 
        -cp : path to cube prog
        
    Where cube_prog is located here:
    
    C:\ST\STM32CubeIDE_1.3.0\STM32CubeIDE\plugins\com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.win32_1.3.0.202002181050\tools\bin
    
    So it is probably best to create a bat file in the windows home directory:
    
    "C:\ST\STM32CubeIDE_1.3.0\STM32CubeIDE\plugins\com.st.stm32cube.ide.mcu.externaltools.stlink-gdb-server.win32_1.3.0.202002181050\tools\bin\ST-LINK_gdbserver.exe" -d -v -cp "C:\ST\STM32CubeIDE_1.3.0\STM32CubeIDE\plugins\com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.win32_1.3.0.202002181050\tools\bin"
    
    The paths probably vary depending on CubeIDE version.

= Starting gdb-multiarch & flashing =
   
Start gdb-multiarch and pass the .elf file (compiled with debug symbols):

    > gdb-multiarch /path/to/project.elf
    or:
    > gdb-multiarch
    > file /path/to/project.elf

Connect to the GDB server:
    
    > tar extended-remote :61234
    (port may vary, see gdb server console)

Load to program onto the chip:

    > load
    
Reset chip:
    
    > monitor reset halt

Continue execution if paused:
    
    > c

See [[gdb]] for generic gdb usage



