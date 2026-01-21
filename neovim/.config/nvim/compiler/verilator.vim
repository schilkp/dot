" Verilator warnings always start with "%Error" or "%Warning", optionally directly
" followed by an error code. If a location is known, it may be given with or
" without column number. Examples of errors:
"
" "%Warning: ..msg.."
" "%Error-DECLFORMAT: myfile:1: ..msg.."
" "%Error-PINCONNECT: myfile:1:2: ..msg.."

" Display file but no error code:
CompilerSet errorformat=%%%t%*[a-zA-Z]-%*[^:]:\ %f:%l:%c:\ %m,
			\%%%t%*[a-zA-Z]-%*[^:]:\ %f:%l:\ %m,
			\%%%t%*[a-zA-Z]:\ %f:%l:%c:\ %m,
			\%%%t%*[a-zA-Z]:\ %f:%l:\ %m,

" Display error code but no file:
"CompilerSet errorformat=%%%t%*[a-zA-Z]-%o:\ %f:%l:%c:\ %m,
"			\%%%t%*[a-zA-Z]-%o:\ %f:%l:\ %m,
"			\%%%t%*[a-zA-Z]:\ %f:%l:%c:\ %m,
"			\%%%t%*[a-zA-Z]:\ %f:%l:\ %m,
