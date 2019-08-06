#!/bin/sh
set -e

echo "*** Test all exercises:"
echo

cd /repo/exercises
for exercise in *; do
    echo " - $exercise:"
    cd "$exercise"
    cp example.tcl "$exercise.tcl"
    tclsh "test.tcl"
    echo
    git checkout "$exercise.tcl"
    cd ..
done
