# Level 5 to 6

1. We just need to add few extra flags in addition to the previous level
```find . -size 1033c ! -executable -exec file {} + | grep ASCII```
    - `-size 1033c` : c is used for bytes
    - `! -executable` : exclamation is used for negation, this flag filters non executable files
2. Retrieve the password using `cat`