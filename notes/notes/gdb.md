=== GDB ===

== Basic Usage ==

= Setup =
Launch:
    > gdb project.elf
    or
    > gdb
    > file project.elf


Pause execution using Ctrl-C

Reload program after recompile:
    > r

= Flow = 
Continue execution:
    > c

Add breakpoint:
    > b main
    > b main.c:95

List breakpoints:
    > info b
    
Remove breakpoints:
    BP 1:
    > delete 1 
    All:
    > delete  

Step, do not step into functions:
    > n

Step, do step into functions:
    > s

Skip functions, to not step into them (useful for myfunc(strlen())
    > skip strlen

Inspect variable:
    > p name_of_var

Set variable:
    > set name_of_var=22
    
Print current back-trace:
    > bt

Finish current function, show return value:
    > finish
    
= tui =  
Start tui:
    <C-x> a
    or
    > tui enable
    
In tui, change selected window:
    <C-x> o
    (Usefull to select terminal, and be able to use up/down)

In tui, go to 2-window layout:
    <C-x> 

