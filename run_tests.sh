#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Error: There cant be more then 1 parameter"
    exit 0;
fi

pass=0
fail=0
array=()

if [[ "$1" == "-r" ]]; then
    x=`find . -name run.sh`
    array+=( "$x" )
    for f in ${array[@]}; do
        sh $f > "${f%/*}/testname.log"
        if [[ "$?" -eq 0 ]]; then
            ((pass++))
        else
            ((fail++))
        fi
    done
elif [[ "$1" == "-c" ]]; then
    x=`find . -name testname.log`
    array+=( "$x" )
    for f in ${array[@]}; do
        rm $f
    done
    echo "Done: Removed all testname.log files"
    exit 0;
else
    echo "Error: Uncknown parameter"
    exit 0;
fi

echo "All count of runs is $(($pass + $fail))"
echo "Passed: $pass"
echo "Faild: $fail"