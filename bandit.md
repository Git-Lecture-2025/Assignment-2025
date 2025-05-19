# Overthewire-Bandit Writeups


## Level 0 --> 1

`ssh bandit0@bandit.labs.overthewire.org -p 2220`

Using `ls` we see a file called `readme`
cat this file using `cat readme` to get the password for the next level


## Level 1 --> 2

The dashed filename '-' refers to either stdin/stdout so doing cat -    

`cat ./-`


## Level 2 --> 3

THe file we need to read is called "spaces in this filename". To read the contents of the file we need to run `cat "spaces in this filename"`
On reading the file we geet the password for the next level

## Level 3 --> 4

On running `ls` we see there is a directory called `inhere`. 
Run `cd inhere` to change the current working directory into `inhere`. Running `ls -a` inside the inhere direcotry reveals a hidden file called "...Hiding-From-You". cat this file for the password for the next stage.


## Level 4 --> 5

Again there is a directrory called in here which you need to cd into.The inhere directory consists of 10 files. Trying to run cat on some of the files, returns garbage which suggests they arent actually ASCII text files. 
run `file ./-file*` to see the file types of all the files in the directory. This reveals that only one of the files is an ASCII text file which is `-file07` . run `cat ./-file07` to get the password for the next stage.

## Level 5 --> 6

This time we are given 20 directories which have several files under them. We are also given that the file is 1033 bytes.
Thus we can use the find command to find it using the following command:

`find . -size 1033c`

We find that only 1 file meets this size contraint. cat that file to get the password for the next stage

`cat ./maybehere07/.file2`

## Level 6 --> 7

`find / -user bandit7 -group bandit6 -size 32c`
Searches through all the files in root that meet the criteria given by the challenge


## Level 7 --> 8

Use grep to look for the word millionth in data.txt. The password will be next to it.

`cat data.txt | grep -i "millionth"`

## Level 8 --> 9

Pipe the text of the file into sort. this will make sure that identical lines are adjacent and then use `uniq` utility that lets you filter data with identical adjacent lines. using `uniq` with the `-u` flag only prints the unique lines in the input(ie stdin)

`cat data.txt | sort | uniq -u`

## Level 9 --> 10

running `file data.txt` reveals that data.txt does not contain plain ASCII text. So running strings data.txt and piping that into grep lets us find the password

`strings data.txt | grep -i "="`

## Level 10 ---> 11

The challenge mentions that data.txt contains base64 encoded data. cat the file and pipe its output into base64 with the decode flag to get the password for the next stage.


`cat data.txt | base64 --decode`


## Level 11 --> 12

Opening the reading material that the bandit page links reveals a command to perform ROT13 encryption.

`tr 'A-Za-z' 'N-ZA-Mn-za-m'`

Note that ROT13 is its own encryption function meaning performing ROT13 twice on a piece of texts recovers the text to its original form.


Using the following command to decrypt the contents of the file using the above command:

`cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'`


This reveals the password for the next stage



## Level 12 --> 13

On reading the contents of data.txt using `cat` it is ibvious that it is a hexdump. To recover the orignal contents run 

```
xxd -r data.txt > /tmp/tmp.M2xynLV7ul/unhexed.txt
```
Running the `file` command on the output tells us that it is gzip compressed data. Rename the file to `unhexed.gz` and unzip it using:

```
gunzip unhexed.gz
```
The output is a file called `unhexed` which is bzip2 compressed data as revealed by the `file` command.

Unzip the contents by running `bunzip2 unhexed` . The output file is a file named `unhexed.out` which turns out to be a gzip compressed archive again. 
Repeat the same steps above to reveal a POSIX tar archive which can be uncompressed by running `tar -xf data5.bin`
This reveals `data6.bin` which is again bzip2 compressed data.
On decompressing `data6.bin` we reveal another gzip archive - `data8.bin`.

Finally on decompressing `data8.bin` we get an ASCII file `data8` which contains the password for the next stage.

## Level 13 --> 14

Using SSH login as badit 14 using the following command:

```
ssh bandit14@localhost -p 2220 -i sshkey.private 
```
Finally `cat /etc/bandit_pass/bandit14` to get the password for the next stage.


## Level 14 --> 15

netcat into port 30000 using the following command:

```
nc localhost 30000
```
Enter the current password to get the next password.


## Level 15 --> 16

Run the following command to connect to a service using openSSL

```
openssl s_client localhost:30001
```

Then enter the current password to get the password for the next stage

## Level 16 --> 17

First scan all ports from 31000 to 32000 using nmap:

```
nmap -p31000-32000 localhost
```
Now try connecting to all the ports using SSL using:

```
openssl s_client -quiet -connect locahost:<port>
```

One of them connects and prompts you for the current password. After entering the current password a SSH private key is returned. Make a temp directory and paste the private key in a file say `privkey.ssh`

```
mktemp -d 
cd /tmp/tmp.jhlSs5eZ6Y
touch privkey.ssh
cat > privkey.ssh
chmod 400 privkey.ssh
ssh bandit17@localhost -p 2220 -i privkey.ssh
```

## Level 17 --> 18

`diff passwords.new passwords.old`

Try both the lines as passwords for the next stage.

## Level 18 --> 19

We can change the pseudo-tty allocation on ssh using

`ssh bandit18@bandit.labs.overthewire.org -p 2220 -t "/bin/sh"`

This prevents bash from loading. Now cat readme to get the password for the next stage.


## Level 19 --> 20

CD into /etc/bandit_pass and run the following command

`~/bandit20-do cat bandit20` to get the password for the next stage.

