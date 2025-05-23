# LEVEL0

We must log into the game using ssh.<br>
password: <b>bandit0</b>
```code
ssh bandit0@bandit.labs.overthewire.org -p 2220
```
Then you must do the next task, complete it , exit from the level<br>
and write the above code again and login with that level.

# LEVEL0 --> LEVEL1

We must see the readme file using the code 
```code
cat readme
```
And obtain the password from there
password: ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If

# LEVEL1 --> LEVEL2

We must open the file in directory to see the password.<br>
We can do that using :
```cat ./- ```

password:263JGJPfgU6LtdEvgfWU1XP5yac29mFx

# LEVEL2 --> LEVEL3

Same thing as above but use quotation marks
password:MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx

# LEVEL3 --> LEVEL4

Same thing but you have to go to inhere directory.<br>
You can use <br>
```cd inhere```
password:2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ

# LEVEL4 --> LEVEL5

You must enter the inhere directory and use this command:
```code
find . -type f | xargs file
```
To find the human readable file.<br>
password: 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw

# LEVEL5 --> LEVEL6

You must find the file with properties mentioned in the exercise.<br>
```code
find . -type f -size 1033c ! -executable 
```
Password: HWasnPhtq9AVKe0dmk45nxy20cvUa6EG

# LEVEL6 --> LEVEL7'
Find the file somewhere on the server:
```code
find / -type f -user bandit7 -group bandit6 -size 33c
```
password:morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj

# LEVEL7 --> LEVEL8

We must find the password in the file name,
<br>
This file has a lot of content
```code
strings data.txt | grep "millionth"
```
password:dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc

# LEVEL8 --> LEVEL9

We must find the password which is the only unique string in data.txt
```code
sort data.txt | uniq -c
```
This gives us the count of these strings in that file

password: 4CKMh1JI91bUIZZPXDqGanal4xvAg0JM

# LEVEL9 --> LEVEL10

It is stored in one of the few human readable strings , preceded by "="
```code
strings data.txt | grep "="
```
password:FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey

# LEVEL10 --> LEVEL11

First we must see the commands of base64 using:
```man base64```
Then decode it using
```code
base64 -d data.txt
```
password:dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr

# LEVEL11 --> LEVEL12

You must rotate the lowercase and uppercase alphabets by 13 places:
Go to CyberChef and select ```ROT13```

password:7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4

# LEVEL12 --> LEVEL13

The file is a hexdump of a file that has been compressed several times.
We must use
<br>```xxd```<br>
Command To reverse or make a hexdump.
```code
xxd -r data.txt > data
```

```mv oldfile newfilename```  To change the filename<br>

```"filename" file``` to check the file type 

```code
gzip -d file.gz
```

```code
bzip -d file.gz
```

```code
tar xf file.tar
```
Make sure to always rename the file with the correct extension.
Continue this process to finally obtain the password,

# LEVEL13 --> LEVEL14

You must get password using the ssh private key from the bandit14
```code
ssh -i sshkey.private -p 2220 bandit14@localhost
```
Then you go to a file to get the password:

# LEVEL14 --> LEVEL15

You must enter through localhost 30000 and paste the previous password to get this one 

# LEVEL15 --> LEVEL16
You must use an SSL encryption on localhost port 30001

```code 
man ncat | grep ssl
```
