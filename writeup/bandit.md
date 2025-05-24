
## Level 0 -> 1
```
cat readme

```
Here we just cat the readme file to get the password.
## Level 1 -> 2
```
cat ./-

```
Here the catch is there is a special character which we need to make sure that it is not interpreted as a command.


## Level 2 -> 3
```
cat "spaces in this filename"
```
Here there are spaces in the file name so we wrap them in ""
## Level 3 -> 4

```
cat ...Hiding-From-You

```
Here the password is stored in a hidden file which we can see by using ```ls -a``` to show all.

## Level 4 -> 5

```
for f in $(ls | sed 's/^/.\//'); do cat $f; echo; done

```
Then select the correct looking password. 

Here we have a bunch of files with special characters at the beginning so we need a script that will cat all the files.
We use `sed` to append `./` before each file name which we get from the output of the ls command and run cat command on those filenames. 

## Level 5 -> 6

```
find ./ -size 1033c

```
Here we find the file that is of 1033 bytes size.

## Level 6 -> 7
```
find . -group bandit6 -user bandit7 -size 33c 2>/dev/null

```
Here we find the file that is of 33 bytes size and is owned by the user bandit7 and belongs to the group bandit6.

We use 2>/dev/null to send the error output to /dev/null and not display it.
## Level 7 -> 8

```
cat data.txt |grep "millionth"

```
Simple grep use.

## Level 8 -> 9

```
sort data.txt | uniq -u

```
Here we simply sort the data.txt and pipe the output in uniq with the u flag which gives the unique value.
## Level 9 -> 10

```
 strings data.txt | grep "=="

```

## Level 10 -> 11

```
base64 -d data.txt

```
Decode the base64 text.
## Level 11 -> 12

```
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'

```
Here we use the tr (*translate character*) command to shift the capital and small alphabets by 13 places.

## Level 12 -> 13

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
tar -xvf test.tar
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

```
 rsync -e "ssh -p 2220" bandit13@bandit.labs.overthewire.org:sshkey.private .;
 sudo chmod 600 ./sshkey.private;
 sudo ssh -i ./sshkey.private bandit14@bandit.labs.overthewire.org -p 2220

```
Here we import the private key using rsync on our machine and then use it to SSH in the next level.

## Level 14 -> 15

```
nc localhost:30000

```
Note this command has to run on the bandit server as we are using the localhost.
## Level 15 -> 16

```
openssl s_client localhost:30001

```

## Level 16 -> 17
First, we do an aggressive scan of all the ports: 
```
nmap -A localhost -p 31000-32000
```
Select the port which has the wrong password error and use: 
```
ncat --ssl localhost <port> 
```
We get a private key here and we have to store it on the bandit localhost only, to get to the next level.

```
place=$(mktemp -d);
cd $place
```
Create a file private.key and store the private key there:
```
ssh -i private.key bandit17@<the URL>
```

## Level 17 -> 18

```
diff password.new password.old

```
Simple use of the diff command.

## Level 18 -> 19

```
ssh bandit18@bandit.labs.overthewire.org -p 2220 -t "/bin/sh"
```
Then just cat the file.


