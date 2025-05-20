# Level 1 to 2 Solution

1. Login using:
```
ssh bandit1@bandit.labs.overthewire.org -p 2220
```
2. Put the password you got from the previous level.
3. As given in the question, the password for next level in a file called **_"-"_** which doesn't opens or cat directly, so use full path to open such (dashed) file as `cat ./-` in this case.

4. `./-` because `-` leads to terminal waiting for next command to come.