#!/bin/bash

# Compile and run STCBEX02

# static parms
SYSLIB="../cpy"

# Program parms
PGM=STCBEX02
export DD_CUSTTXT="../data/customer.dat.txt"
export DD_CUSTTXT2="../data/stcbex02-out.txt"

# clean up
rm ../bin/$PGM
rm $DD_CUSTTXT2

cobc -x ../cbl/$PGM.cbl -I $SYSLIB -o ../bin/$PGM

if [ "$?" -eq 0 ]; then
    ../bin/$PGM
else
    echo "Complier Return code not ZERO."
fi
