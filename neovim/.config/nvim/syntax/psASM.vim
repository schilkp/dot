" VIM syntax file
" Language: psASM

if exists("b:current_syntax")
    finish
endif

" Instructions related to execution-flow
syn keyword psASM_Inst_Flow NOP HALT JMP CALL IFS IFR IFSF IFRF RTRN RTRNI

" Instructions related to data manipulation
syn keyword psASM_Inst_Data AND ANDL OR ORL XOR XORL SHFTR SHFTRL SHFTL SHFTLL COMPB COMPBC ADD ADDC ADDLA ADDLAC ADDLB ADDLBC NOTA SUB SUBC SUBL SUBLC LITA LITB CPY

" Instructions related to memory/stack access
syn keyword psASM_Inst_Mem SVA SVAF SVB SVBF LDA LDAF LDB LDBF SVO SVOF LDO LDOF POPA PUSHA POPB PUSHB GROW SHRINK STSA STSB STLA STLB


" Preprocessor statemnts:
syn match psASM_PreProc_operation "@define"
syn match psASM_PreProc_operation "@include"
syn match psASM_PreProc_operation "@include_once"
syn match psASM_PreProc_operation "@print"
syn match psASM_PreProc_operation "@error"

syn match psASM_PreProc_block "@if"
syn match psASM_PreProc_block "@ifdef"
syn match psASM_PreProc_block "@ifndef"
syn match psASM_PreProc_block "@elif"
syn match psASM_PreProc_block "@else"
syn match psASM_PreProc_block "@for"
syn match psASM_PreProc_block "@macro"
syn match psASM_PreProc_block "@end"

" Comments
syn match psASM_Comment '#.*$'

" Line Labels
syn match psASM_Labels '^\s*\(,\?\s*[\._\$]\?[a-zA-Z0-9_]\+\s*\)\+\s*:'

" " Decimal literals
" syn match psASM_Literal '\d\+' 
" syn match psASM_Literal '(+|-)\d\+'
" 
" " Hex literals
" syn match psASM_Literal '0x[\dabcdefABCDEF]\+'
" 
" " Binary literals
" syn match psASM_Literal '0b[01]\+'

" Highlighting
let b:current_syntax = "cel"

hi def link psASM_Inst_Flow Operator
hi def link psASM_Inst_Data Operator
hi def link psASM_Inst_Mem  Operator

hi def link psASM_Comment Comment
hi def link psASM_PreProc_block PreProc
hi def link psASM_PreProc_operation Debug
hi def link psASM_Labels Tag 

" hi def link psASM_Literal Constant

