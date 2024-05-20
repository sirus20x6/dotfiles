#!/bin/bash

# Path to the clang-format executable
CLANG_FORMAT="clang-format"

# Temporary file to store clang-format output
TEMP_FILE=$(mktemp)

# Function to format only changed lines
format_changed_lines() {
    local file=$1
    # Get only modified lines (not additions)
    local lines=$(git diff -U0 -- $file | grep -E "^\+" | grep -Ev "^(--- a/|\+\+\+ b/)" | cut -c2-)
    if [ -z "$lines" ]; then
        return
    fi

    # Format only those lines with clang-format
    echo "$lines" | $CLANG_FORMAT -style=file -assume-filename=$file > $TEMP_FILE

    # Replace the formatted lines in the original file
    awk 'NR==FNR{a[NR]=$0;next} /^+/{print a[++i];next}1' $TEMP_FILE $file > $file.formatted
    mv $file.formatted $file
}

# Get a list of files with unstaged changes
FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -E "\.(c|h)$")
for file in $FILES; do
    format_changed_lines $file
done

# Preview changes
git diff

# Prompt user to continue
read -p "Continue with commit? [Y/n]: " -n 1 -r
echo    # Move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    exit 0 # Proceed with commit
else
    exit 1 # Abort commit
fi

rm $TEMP_FILE
