#!/bin/bash
touch placeholder
python3 -u challenges/easy/test_lambda_function1.py 2> placeholder 
cat placeholder
case="$(cat placeholder | tail -n 1)"
rm placeholder
if [ -n `cat leaderboard | grep $1` ]; then
    last="`echo $case | sed -e 's/[^0-9]/ /g'`"
    if [[ "$last" =~ "[0-9]" ]]; then
        echo $last
        echo "$1 $2 10"
    else
        number=`echo $last | xargs`
        if [ `echo $number | wc -w` -eq 2 ]; then
            failures=`$number | cut -d " " -f 1`
            errors=`$number | cut -d " " -f 2`
            echo "$1 $2 $((10-$failures-$errors))" >> leaderboard
        else
            echo "$1 $2 $((10-$number))" >> leaderboard
        fi
    fi
fi