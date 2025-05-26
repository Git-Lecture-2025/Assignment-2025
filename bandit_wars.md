# Level0
In this level I learnt how to use ssh command and its format is
```shell
$ ssh -p [port_number] [username]@[hostname]
```

Then it asks for password that is bandit0
Then you are in

# Level1
In this level we need to run the below commands
```shell
$ ls
```
So that we are able to check which files are present
```shell
$ cat readme
```
To print the text in the file readme
thus we get the password
> ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If
Now run the level 0 command once again after you quit the level 0 to enter the next level

# Level2
In this level as well
```shell
$ ls
```
So that we are able to check which files are present
```shell
$ cat ./-
```
To print the text in the file readme
As it is a special character so we need to write the cat in a different manner
thus we get the password
> 263JGJPfgU6LtdEvgfWU1XP5yac29mFx

Now run the level 0 command once again after you quit the level 0 to enter the next level

# Level3
In this level as well
```shell
$ ls
```
So that we are able to check which files are present
```shell
$ cat 'spaces in this filename'
```
To print the text in the file readme
As it has spaces so we need to write the cat in a different manner

thus we get the password
> MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx

# Level4
In this level as well
```shell
$ ls -al
```
So that we are able to check which files are present in this hidden directory
```shell
$ cd inhere
```
to get into the file
```shell
$ ls -al
```
To check the hidden files

```shell
$ cat ...Hiding-From-You
```
So that we are able to get the password

thus we get the password
> 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ

# Level 5
Here we need to check which file readable so we need to run the following command
```shell
$ file ./-file*
```
This command helps us to get the type of the file and the one with the ASCII code will be the one that will be human readable file

thus we get the password
> 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw

# Level6
In this level we need to check 3 conditions for a file which are 
>human-readable

>1033 bytes in size

>not executable

So now to check all these conditions at once without going inn each directory we will use the find command
```shell
$ find . -type f -size 1033c ! -executable -exec file '{}' \; | grep ASCII
```
<li> It has a flag for looking at file size in bytes -size <bytes>.</li>

<li> It also has the option to only look at files -type f (no directories/non-executables).</li>

<li> It has a -readable flag, but this means you have the permission to read the files, not that they are human-readable.</li>

<li>Instead, we could use the -exec <command> flag with '{}' as a path, meaning the chosen</li>
<br>

thus we get the password
> HWasnPhtq9AVKe0dmk45nxy20cvUa6EG

# Level 7
In this level we need to take care of the following things
<li>owned by user bandit7</li>
<li>owned by group bandit6</li>
<li>33 bytes in size</li>

So again we get an inclination that we might need to run the find command
```shell
$ find / -type f -user bandit7 -group bandit6 -size 33c 2> /dev/null
```
We are using / so that we are able to access all hidden files in the sever as well
The 2>/dev/null part suppresses error messages for files I do not have permission to access

thus we get the password
> morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj

# Level 8
Here we know that the password is stored next to the word **millionth** thus we can simply run the command
```shell
$ cat data.txt | grep millionth
```
which will return the word and the next word as well
thus we get the password
> dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc

# Level 9
In this level we are given that the pasword only comes once in the whole data.txt so we can run the command

```shell
$ cat data.txt | sort | uniq -u
```
In this command sort is sorting the file and counts the occurrence of each line. Then uniq -u command is used further to print out that line which occured only once

thus we get the password
> 4CKMh1JI91bUIZZPXDqGanal4xvAg0JM

# Level 10
As this file is a binary file so we need to use a special command similar to cat but for binary files whic is as below
```shell
$ strings data.txt | grep =======
```
So now we are also searching for seceral = as stated in the exercise to find the password 

thus we get the password
> FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey

# Level 11
Here it is given that the password is encoded in base 64 so simply run the command
```shell
$ cat data.txt
```
And then copy the text and use any base64 decoder online to get the password

thus we get the password
> dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr

# Level 12
Here it is given that the password is encoded in  ROT13 so simply run the command
```shell
$ cat data.txt
```
And then copy the text and use any ROT13 decoder online to get the password

thus we get the password
> 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4

# Level 13
Here we are given a file that is multiple times compressed
So first we need to move to temp directory
```shell
$ cd ..
$ cd ..
$ cd tmp
$ mkdir datadecoding
$ cd ..
$ cd ..
$ cd home
$ cd bandit12
$ mv data.txt /tmp/datadecoding
$ cd ..
$ cd ..
$ cd tmp
$ cd datadecoing
$ mv data.txt data1.txt
```
To convert a hexdump file to a binary file we also need to run the command
```shell
xxd -r data1.txt data
```
This will give you a file where all the below tasks can be done repeatedly

This is how we are moving and copying the file from one directory to another directory

To check the method in which a file is last compressed we need to run the command
```shell
$ file data1.txt
```
This will give you whether the file is compressed in the form of
<li> gzip </li>
<li> bzip2 </li>
<li> tar </li>

Then once you get that you need to change the extension of the file to
<li> .gz </li>
<li> .bz2 </li>
<li> .tar </li>

So that now you can run the respective commands continuously till you get the ASCII file as your type
```shell
$ gzip -d data.gz
$ bzip2 -d data.bz2
$ tar xf data.tar
```

thus we get the password
> FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn

# Level 14
While we are inside the bandit 13 we need to access the bandit 14 which is possible because of the private ssh key provided in bandit 13 so the command required
```shell
$ ssh -i sshkey.private bandit14@localhost -p 2220
```
So this is the way we use the private key if given

now simply we need to run a cat command to get the password
```shell
$ cat /etc/bandit_pass/bandit14
```

thus we get the password
> MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS

# Level 15
Now when we are on bandit 14 to submit the password to the localhost at port number 30000 we need to run the following command
```shell
$ nc localhost 30000
```
thus we get the password
> 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo

# Level 16
Here similar to the previus level first we need to get the password for doing ncat or nc using the command
```shell
$ cat /etc/bandit_pass/bandit15
```
After that for ssl / tls encryption the command that we need to run is 
```shell
$  ncat -ssl localhost 30001
```
So and then we have to paste the password that we obtained from the cat message so that we are able to get the passord for the next level

thus we get the password
> kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx

# Level 17
So when I run the command
```shell
$ nc localhost -v 31000-32000
```
This gives me the info of each port which is active and by sending some input and recognising the output I am able to recognise the following output where a port is rejected if it is giving the same info as being entered

<li>31046 //reject</li>
<li>31518</li>
<li>31691//reject</li>
<li>31790</li>
<li>31960//reject</li>

Now we need to run the command
```shell
$ ncat --ssl localhost 31518
```
Which is not returning any result thus does not have a valid ssl protection

So the last port left is **31790**
Thus now when I run the command

```shell
$ ncat --ssl localhost 31790
```
and I enter the password then I get the following credentials

> -----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----

# Level 18
Here firstly we need to make a file of the ssh key that is given so simply you can do
```shell
$ nano sshkeygen.privatekey
```
and paste the private key there

but the file must not remain open otherwise it won't be acceptable by the bandit so make it not accessible using the command
```shell
$ chmod 400 sshkeygen.privatekey
```
Now use the command that we just learnt
```shell
ssh -i sshkeygen.privatekey bandit17@bandit.labs.overthewire.org -p 2220
```
Now to check the difference between the 2 files we need to run the command
```shell
$ diff passwords.new passwords.old
```
This will show that particular line that is different where we will focus on the line for the new one

thus we get the password
> x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO

# Level 19
Here someone has updated the bashrc file which is executed as soon as we run the command
```shell
$ ssh -p 2220 bandit19@bandit.labs.overthewire.org
```
So in such a case what we need to do is to write the command as well that we need to run if we were admitted as that command will then be run first even before bashrc is able to execute thus giving us the result required

```shell
$ ssh -p 2220 bandit19@bandit.labs.overthewire.org cat readme
```
Thus now when we put the password when required it will give us back the result that is inside the readme

thus we get the password
> cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8

# Level 20
In this level we are given a setuid file which is an executable file which cannot be run normally as we need some extra priveldges to run the file
so we need to run it using the command
```shell
$ ./bandit20-do do
```
This will help us to get to know who am I or even a better command will be
```shell
$ ./bandit20-do whoami
```
Which will give you who you currently are that is **bandit20**
Thus it seems so we are in bandit20 and so as given we can  simply run the command
```shell
$ ./bandit20-do cat /etc/bandit_pass/bandit20
```
This command will give me the password that will be
> 0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO