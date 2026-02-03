#!/bin/bash

awk '
    /^\| \[/ && match($0, /\]\(/) {
        prefix = substr($0, 1, RSTART-1)
        suffix = substr($0, RSTART)
        gsub(/_/, "\\_", prefix)
        $0 = prefix suffix
    }
    {print}
' README.md > README.new

diff README.old README.new
[ $? -ne 0 ] && mv README.new README.md
exit 0
