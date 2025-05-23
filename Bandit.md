## Level 0 -> 1 
    pwd: ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If
    cat readme
## Level 1 -> 2 
    pwd: 263JGJPfgU6LtdEvgfWU1XP5yac29mFx
    cat ./-
## Level 2 -> 3 
    pwd: MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx
    ls 
    cat 'spaces in this filename'
## Level 3 -> 4
    pwd: 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
    cd inhere
    ls -a : Because the file is hidden
    cat ...Hiding-From-You
## Level 4 -> 5 
    pwd: 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw
    ls
    cd inhere
    ls
    cat ./-file00 ./-file01 ./-file02 ./-file03 ./-file04 ./-file05 ./-file06 ./-file07 ./-file08 ./-file09
## Level 5 -> 6
    pwd: HWasnPhtq9AVKe0dmk45nxy20cvUa6EG
    cd inhere
    ls
    find . -size 1033c
## Level 6 -> 7 
    pwd: morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj
    cd ..(x2 - To get to root directory)
    find . -user bandit7 -group bandit6 -size 33c
    cat ./var/lib/dpkg/info/bandit7.password
## Lesson 7 -> 8 
    pwd: dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc
    ls
    grep "millionth" data.txt
## Lesson 8 -> 9 
    pwd: 4CKMh1JI91bUIZZPXDqGanal4xvAg0JM
    ls
    sort data.txt | uniq -u
## Lesson 9 -> 10
    pwd: FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey
    ls
    grep --text "===" data.txt
## Lesson 10 -> 11 
    pwd: dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr
    ls 
    cat data.txt | base64 -d
    (Or else, we could just cat data.txt, copy the text and use it manually in base 64 "text")
## Lesson 11 -> 12 
    pwd: 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4
    ls
    cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
## Lesson 12 -> 13 
    pwd: FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn
    We will make a temp directory as we need to work with the file and modify it repeatedly
    mktemp -d
    cat data.txt | xxd -r > /tmp/tmp.OLQPzeERc9/data
    Then we will repeatedly identify the file type using file
    We will encounter three types of compressions which we will decompress
    When file output is
    1. gzip 
        gzip -d output
    2. bzip2
        bzip -d output
    3. tar
        tar -xf output
## Lesson 13 -> 14 
    pwd: MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS
    ls
    ssh -p 2220 -i sshkey.private bandit14@bandit.labs.overthewire.org
    To get pwd - cd /etc/bandit_pass
    cat bandit14
## Lesson 14 -> 15 
    pwd: 8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo
    nc localhost 30000
    We get the next pwd too
## Lesson 15 -> 16
    pwd: kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx
    We utilise openssl s_client
    ign_eof to keep connection on for reading the server o/p
    openssl s_client -connect localhost:30001 -ign_eof
    Then we enter the prev pwd when prompted
    We get the next pwd
## Lesson 16 -> 17
    pwd: No pwd yielded, used the key
    nmap localhost -p 31000-32000 | grep open
    List of 5 servers. Try them manually (couldn't find a better method)
    echo kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx | openssl s_client -connect localhost:31046 -ign_eof
    Works upon 31790
    Outputs RSA Key
    Go to tmp dir
    nano bandit.key
    Paste the RSA key in this
    Change the permissions
    chmod 600 bandit.key
    Now can be used
    ssh -i bandit.key bandit17@bandit.labs.overthewire.org -p 2220
## Lesson 17 -> 18
    pwd: x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
    Just spot the differences between them
    ls
    diff passwords.new passwords.old
    Get the pwd
## Lesson 18 -> 19
    pwd: cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8
    ssh -t bandit18@bandit.labs.overthewire.org -p 2220 bash --norc --noprofile
    This basically connects via ssh without running .bashrc
    ls
    cd bandit18
    ls - We find a readme
    cat readme
## Lesson 19 -> 20
    pwd: 0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO
    So, bandit20-do allows you to run files as if you were bandit20 and not bandit 19
    bandit_pass/bandit20 does not respond to cat, says permission denied
    We run
    ./bandit20-do cat /etc/bandit_pass/bandit20
    This way we are allowed permissions as we are working as bandit20 and not bandit19