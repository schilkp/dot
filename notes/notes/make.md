=== GNU Make ===

= Overall =
    
[Target]: [Pre-regs] | [order-only pre-regs]
    [Commands to make target from pre-regs]

= Automatic Variables =

$@: The first target
$<: The first pre-reg
$^: All pre-regs
$?: All pre-regs newer than the target
$*: The contents of the wildcard (i.e. %.c)
$|: All order-only pre-regs

= Variable Assignment =
    
Assign:
Var1 = SomeVal

Assign, but don't overwrite:
Var2 ?= SomeVal
    
= Command Prefixes =
   
Do not echo command before execution:
@echo "No need to print this twice!"
    
Do not fail if a command fail:
-rm -rf build/
