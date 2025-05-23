
## Level 0 -> 1
Password for Level 1: ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If
```
cat readme

```
## Level 1 -> 2
Password for Level 2: 263JGJPfgU6LtdEvgfWU1XP5yac29mFx
```
cat ./-

```


## Level 2 -> 3
Password for Level 3: MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx
```

```
## Level 3 -> 4

Password for Level 4: 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
```
cat ...Hiding-From-You

```

## Level 4 -> 5
Password for Level 5: 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw

```
for f in $(ls | sed 's/^/.\//'); do cat $f; echo; done

```
then select the correct looking password

## Level 5 -> 6

Password for Level 6: HWasnPhtq9AVKe0dmk45nxy20cvUa6EG

```
find ./ -size 1033c

```

## Level 6 -> 7

Password for Level 7: morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj

```
find . -group bandit6 -user bandit7 -size 33c 2>/dev/null

```

We use 2>/dev/null to send the error output to /dev/null and not display it.
## Level 7 -> 8

Password for Level 8: dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc
```
cat data.txt |grep "millionth"

```

## Level 8 -> 9

Password for Level 9:4CKMh1JI91bUIZZPXDqGanal4xvAg0JM
```
sort data.txt | uniq -u

```
## Level 9 -> 10

Password for Level 10:FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey
```
 strings data.txt | grep "=="

```

## Level 10 -> 11

Password for Level 11: dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr
```
base64 -d data.txt

```
## Level 11 -> 12

Password for Level 12: 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4
```
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'

```

## Level 12 -> 13

Password for Level 13:FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn
I am just pasting my history.

```
place=$(mktemp -d);
cp data.txt $place;
cd $place;
xxd -r data.txt >test
ls
file test
man gzip
gzip -d test
ls
gzip -d test
man gzip
gunzip -d test
mv test test.gz
gunzip -d test.gz
ls
file test
man bzip
man bzip2
mv test test.bz2
bzip2 -d test.bz2
ls
file test
mv test test.gz
gunzip -d test.gz
ls
file test
cat test
mv test test.tar
tar -xf test.tar
ls
file test.tar
tar -xvf test.tar
ls
file data
file data5.bin
tar -xvf test.tar data5.bin
ls
file data5.bin
rm test.tar
mv data5.bin test.tar
tar -xvf test.tar
mv data6.bin test.tar
ls
tar -xvf test.tar
mv data8.bin test.tar
tar -xvf test.tar
ls
tar -xvf test.tar
ls
file test.tar
mv test.tar test.gz
gunzip -d test.gz
ls
file test
cat test
```
## Level 13 -> 14

Password for Level 14:MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS
```
 rsync -e "ssh -p 2220" bandit13@bandit.labs.overthewire.org:sshkey.private .;
 sudo chmod 600 ./sshkey.private;
 sudo ssh -i ./sshkey.private bandit14@bandit.labs.overthewire.org -p 2220

```

## Level 14 -> 15

Password for Level 15:8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo

```
nc localhost:30000

```
Note this command has to run on the bandit server as we are using the localhost
## Level 15 -> 16

Password for Level 16: kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx

```
openssl s_client localhost:30001

```

## Level 16 -> 17

Password for Level 17: I forgot to write it.
First, we do an aggressive scan of all the ports 
```
nmap -A localhost -p 31000-32000
```
select the port which has the wrong password error and use 
```
ncat --ssl localhost <port> 
```
We get a private key here and we have to store it on the bandit localhost only, to get to the next level

```
place=$(mktemp -d);
cd $place
```

create a file private.key and store the private key there
```
ssh -i private.key bandit17@<the URL>
```


## Level 17 -> 18

Password for Level 18: 

```
diff password.new password.old

```
## Level 18 -> 19

Password for Level 19:x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
```
ssh bandit18@bandit.labs.overthewire.org -p 2220 -t "/bin/sh"
```
then just cat the file.
Password for Level 20:cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8
