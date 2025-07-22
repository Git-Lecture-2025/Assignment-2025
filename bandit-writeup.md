# bandit0
```  
ssh bandit0@bandit.labs.overthewire.org -p 2220
```
We will use similar ssh command to access most of the other levels (*with their corresponding paaswords*)

# bandit0 -> bandit1
```
cat readme
```
Gives password to next level

# bandit1 -> bandit2
```
cat ./-
```
Gives password to next level

# bandit2 -> bandit3
```
cat spaces\ in\ this\ filename
```
Gives password to next level

# bandit3 -> bandit4
```
cd inhere/
ls -a
```
Lists all files (including hidden) in **inhere** directory
```
cat ...Hiding-From-You
```

# bandit4 -> bandit5
```
cd inhere/
find . -type f|xargs file
```
Prints all files in current directory, with their file types.  
Select the one with ASCII text
```
cat ./-file07
```

# bandit5 -> bandit6
```
cd inhere/
find . -size 1033c ! -executable -type f| xargs file
cat ./maybehere07/.file2
```
Finds a file of size 1033 bytes, which is not executable and lists all such files' file type (*only 1 file in our case*)

# bandit6 -> bandit7
```
find / -user bandit7 -group bandit6 -size 33c
```
Lists multiple files with *Permission denied* next to them, **except one**.  
The password to next level is found by opening this file.
```
cat /var/lib/dpkg/info/bandit7.password
```

# bandit7 -> bandit8
```
grep "millionth" data.txt
```
# bandit8 -> bandit9
```
sort data.txt| uniq -c
```
Select the line with single count.  
This is the new password

# bandit9 -> bandit10
```
strings data.txt |grep "="
```
Searches and prints all instances of **=** in *readable characters* of data.txt . The password is easily visible.

# bandit10 -> bandit11
```
base64 -d data.txt
```

# bandit11 -> bandit12
```
cat data.txt|tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

# bandit12 -> bandit13
```
mktemp -d
cp data.txt /tmp/tmp.lMITP5TRYf
cd /tmp/tmp.lMITP5TRYf
```
We make a temporary directory and copy **data.txt** in it. Then we navigate to that directory.
```
cat dat.txt
xxd -r data.txt temp.bin

file temp.bin
mv temp.bin temp.bin.gz
gzip -d temp.bin.gz

file temp.bin
mv temp.bin temp.bin.bz2
bzip2 -d temp.bin.bz2

file temp.bin
mv temp.bin temp.bin.gz
gzip -d temp.bin.gz

file temp.bin
mv temp.bin temp.bin.tar
tar -xvf temp.bin.tar

file data5.bin
mv data5.bin data5.bin.tar
tar -xvf data5.bin.tar

file data6.bin
mv data6.bin data6.bin.bz2
bzip2 -d data6.bin.bz2

file data6.bin
mv data6.bin data6.bin.tar
tar -xvf data6.bin.tar

file data8.bin
mv data8.bin data8.bin.gz
gzip -d data8.bin.gz

file data8.bin
cat data8.bin
```

We first reverse **data.txt** from hexdump to normal and store the normal in **temp.bin**
Then we find file type of current file, change its name to match its compression state, and decompress it. This process is repeated multiple times, until we get an `ASCII text` file.

# bandit13 -> bandit14
```
ls
ssh -i sshkey.private bandit14@localhost -p 2220
```
`ls` command shows that we have a **ssh private key**. We use it on ssh on localhost to get into next level.

# bandit14 -> bandit14
```
cat /etc/bandit_pass/bandit14
```
Gives password of current level.
```
ncat localhost 30000
```
We enter the password of current level, and password to next level.

# bandit15 -> bandit16
```
ncat --ssl localhost 30001
```
We submit password of current level to get password of next level.

# bandit16 -> bandit17
```
nmap -v localhost 31000-32000
```
Lists ports that are up and running. Check which of these ports speak ssl and enter current password there to get RSA private key for next level.
```
ncat --ssl localhost <port-number>
```
To get into next level, copy and save the RSA key in a file/vm. I used `nano temp` to make a new file and copied the key there.  
After that, you give chmod 600 access to temp, to make file restrictive (to behave as a private key). Use this to enter the next level.
```
chmod 600 temp
ssh -i temp  bandit17@bandit.labs.overthewire.org
-p 2220
```
  

>**Note:-**  
For `wsl`users like me, you might see that you are not able to get through, even after all the above steps.  
The reson for that might be your *current directory* and *wsl directory* are on different users.  
To get the code running, navigate to the directory which has wsl, and make temp file there. Then go though the above steps.

# bandit17 -> bandit18
```
diff passwwords.old passwords.new
```
The changed line in `passwords.new` is simply the next password.

# bandit18 -> bandit19
To log into bandit18, normal ssh command (as used previously), results in immediate exit from the program, with diplay of text **Byebye !**, due to modified **.bashrc**.  
To get around it we use following command:
```
ssh -T bandit18@bandit.labs.overthewire.org -p 2220
```
This disables the pseudo-terminal allocation, effectively stopping **.bashrc** from running.
```
cat readme
```

# bandit19 -> bandit20
```
./bandit20-do
./bandit20-do cat /etc/bandit_pass/bandit20
```
# bandit20 -> bandit21
```
./succonect
```
Open another **local terminal** on the machine.  
Enter bandit level 20 on it as well.  
On the new terminal, run 
```
ncat localhost -l 1234
```
to listen to port 1234 on localhost (*any port number above 1024 works*). Enter password to level 20 on it.  

On the old terminal, run
```
./suconnect 1234
```
(*or your preffered port number*). It would read the entered password on new terminal, and send the next password there.
