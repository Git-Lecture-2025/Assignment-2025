# LEVEL-00

We must log into the game using ssh.<br>
password: <b>bandit0</b>
```code
ssh bandit0@bandit.labs.overthewire.org -p 2220
```
Then you must do the next task, complete it , exit from the level<br>
and write the above code again and login with that level.

# LEVEL-01

We must see the readme file using the code 
```code
cat readme
```
And obtain the password from there
password: ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If

# LEVEL-02

We must open the file in directory to see the password.<br>
We can do that using :
```cat ./- ```

password:263JGJPfgU6LtdEvgfWU1XP5yac29mFx

# LEVEL-03

Same thing as above but use quotation marks
password:MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx

# LEVEL-04

Same thing but you have to go to inhere directory.<br>
You can use <br>
```cd inhere```
password:2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ

# LEVEL-05

You must enter the inhere directory and use this command:
```code
find . -type f | xargs file
```
To find the human readable file.<br>
password: 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw

# LEVEL-06

You must find the file with properties mentioned in the exercise.<br>
```code
find . -type f -size 1033c ! -executable 
```
Password: HWasnPhtq9AVKe0dmk45nxy20cvUa6EG

# LEVEL-07
Find the file somewhere on the server:
```code
find / -type f -user bandit7 -group bandit6 -size 33c
```
password:morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj

# LEVEL-08

We must find the password in the file name,
<br>
This file has a lot of content
```code
strings data.txt | grep "millionth"
```
password:dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc

# LEVEL-09

We must find the password which is the only unique string in data.txt
```code
sort data.txt | uniq -c
```
This gives us the count of these strings in that file

password: 4CKMh1JI91bUIZZPXDqGanal4xvAg0JM

# LEVEL-10

It is stored in one of the few human readable strings , preceded by "="
```code
strings data.txt | grep "="
```
password:FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey

# LEVEL-11

First we must see the commands of base64 using:
```man base64```
Then decode it using
```code
base64 -d data.txt
```
password:dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr

# LEVEL-12

You must rotate the lowercase and uppercase alphabets by 13 places:
Go to CyberChef and select ```ROT13```

password:7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4

# LEVEL-13

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
FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn

# LEVEL-14

You must get password using the ssh private key from the bandit14
```code
ssh -i sshkey.private -p 2220 bandit14@localhost
```
Then you go to a file to get the password:

# LEVEL-15

You must enter through localhost 30000 and paste the previous password to get this one
 

# LEVEL-16
You must use an SSL encryption on localhost port 30001
```code 
man ncat | grep ssl
```


# LEVEL-17

You must use nmap to find which ports have an active server
```code
nmap localhost -p 31000-32000
```
After this we must find which of these use SSL/TLS:
```code
ncat --ssl localhost 31790
```
And then use that key to login in bandit17

# LEVEL-18

Used diff command 
```code
diff passwords.new passwords.old
```


#  LEVEL-19
You get a Byebye when you try to login bandit18, You must open terminal allocation <br>
In order to fix this.
So I used the pseudo terminal where i can run commands:
```code
ssh bandit18@bandit.labs.overthewire.org -p 2220 -t "cat ~/readme"
```
Then I need to type the password to get the next level password

#  LEVEL-20

You must run the binary file while reading the /etc/bandit_pass directory
```code
./bandit20-do cat /etc/bandit_pass/bandit20
```
This will give you the password for the next level.
