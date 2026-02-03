#!/bin/bash

awk '
    /^\| \[/ && match($0, /\]\(/) {
        prefix = substr($0, 1, RSTART-1)
        suffix = substr($0, RSTART)
        gsub(/([^\\])_/, "\\1\\_")
        # gsub(/_/, "\\_", prefix)
        $0 = prefix suffix
    }
    {print}
' README.new > README.md

rm README.new
