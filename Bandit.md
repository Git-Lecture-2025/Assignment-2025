# Wargames Writups

bandit.labs.overthewire.org

### Level 0


```sh
ssh -p <port_number> <username>@<hostname>
```

Estblish a secure connection to a remote machine.

### Level 0 -> Level 1
```sh
cat <filename>
```
List the contents of a specific file. 

<details>
  <summary>Password</summary>
  ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If
</details>

### Level 1 -> Level 2

```sh
cat > -
```

Since the file name is `-`

<details>
  <summary>Password</summary>
  263JGJPfgU6LtdEvgfWU1XP5yac29mFx
</details>

### Level 2 -> Level 3

```sh
cat "filename with spaces :D"
```

Since the required file name has spaces.

<details>
  <summary>Password</summary>
  MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx
</details>

### Level 3 -> Level 4

```sh
ls -a
```

To show hidden files too

<details>
  <summary>Password</summary>
  2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
</details>
