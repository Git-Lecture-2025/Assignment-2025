# Level 9 to 10

1. Login and put password
```ssh bandit7@bandit.labs.overthewire.org -p 2220```
```strings data.txt | grep "===="```
    - `strings` : extracts human readable text from files
    - `grep "==="` : randomly took 3 equal to signs and manually took the password from multiple lines of output
2. Save the password for the next level