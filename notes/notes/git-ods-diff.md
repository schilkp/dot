# Diffing ODS files with git

 - Install odt2txt
 - mkdir ~/.config/vim/
 
 - In ~/.config/vim/attributes add:
*.ods diff=odf
*.odt diff=odf
*.odp diff=odf


 - In ~/.gitconfig add:

[diff "odf"]
    binary = true
    textconv odt2txt


