" Taken and adapted from https://github.com/mikelue/vim-maven-plugin/blob/master/compiler/maven.vim

if exists("current_compiler")
    finish
endif

let current_compiler = "maven"

CompilerSet makeprg=mvn

" The errorformat for recognize following errors
" 1. Error due to POM file
" 2. Compliation error
"     2.1. Ignore the lines after '[INFO] BUILD FAILURE' because the error message of
"         compiler has been perceived before it.
" 3. Warning
" 4. Errors for unit test
"
" Tested versions of Maven
"
" Maven Version: 3.0.X~
" http://maven.apache.org/
"
" Compiler Plugin Version: 3.0
" http://maven.apache.org/plugins/maven-compiler-plugin/
"
" Surefire Plugin Version: 2.14~
" http://maven.apache.org/plugins/maven-surefire-plugin/
CompilerSet errorformat=
    \%-G[ERROR]\ COMPILATION\ ERROR\ :%.%#,
    \%-A[INFO]\ BUILD\ FAILURE%.%#,%-C%.%#,%-Z%.%#,
    \%-A[ERROR]\ Failures:%.%#,%-C%.%#,%-Z%.%#,
    \%-G[INFO]\ %.%#,
    \%-G[debug]\ %.%#,
    \[%tRROR]%\\s%#Malformed\ POM\ %\\f%\\+:%m@\ %f\\,\ line\ %l\\,\ column\ %c%.%#,
    \[%tRROR]\ %f:[%l\\,%c]\ %m,
    \[%tARNING]\ %f:[%l\\,%c]\ %m,
    \[%tRROR]\ %m,
    \[%tARNING]\ %m

