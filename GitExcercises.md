# Git Excercises


### Master

```sh
git commit
```

Used to create a commit.

```sh
git push
```

Used to push all commits made.

### Commit-One-File

```sh
git add <file>
```

Registers an untracked file.

### Commit-One-File-Staged

```sh
git restore --staged <file>
```

Unstages a file so it is not committed.

### Ignore-Them

A .gitignore file is a file that contains all files and directories to be ignored.

```sh
touch .gitignore
```

To create the file

```sh
nano .gitignore
```

To open the file in terminal for editing.

```sh
*.extension
```

Ignores all files with the specific extension (ReGex pattern matching)

```sh
directories/
```

Ignores the `directories` folder.

### Chase-Branch

```sh
git merge escaped
```

Since chase is a direct ancestor this works and nothing bad happens.

### Merge-Conflict

Manually fix the merge conflict and use `git merge` to merge the branch.
