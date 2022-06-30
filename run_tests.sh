#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Error: There cant be more then 1 parameter"
    exit 0;
fi

pass=0
fail=0
array=()

function_remove() {
    x=`find . -name testname.log`
    local array+=( "$x" )
    for f in ${array[@]}; do
        rm $f
    done
    echo "Done: Removed all testname.log files"
}

log_array=()
if [[ "$1" == "-r" ]]; then
    function_remove
    x=`find . -name run.sh`
    array+=( "$x" )
    for f in ${array[@]}; do
        file_name="${f%/*}/testname.log"
        while IFS= read -r line
        do
            $line >> $file_name 2>&1
            if [[ "$?" -eq "0" ]]; then
                ((pass++))
            else
                ((fail++))
            fi
        done < $f
    done
elif [[ "$1" == "-c" ]]; then
    function_remove
    exit 0;
elif [[ "$1" == "-d" ]]; then
    rm -r "./tests"
else
    echo "Error: Uncknown parameter"
    exit 0;
fi

echo "All count of runs is $(($pass + $fail))"
echo "Passed: $pass"
echo "Faild: $fail"