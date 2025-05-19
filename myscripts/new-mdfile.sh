#!/bin/bash

touch $1.md
echo "\`\`\`" > $1.md
echo "\`\`\`" >> $1.md
echo "" >> $1.md
echo "password for the next level -> " >> $1.md
echo "new markdown file created : $1.md"
sleep 0.5s

code $1.md