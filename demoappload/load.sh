#!/bin/bash

HOSTNAME=$1
if [ -z "$HOSTNAME" ]
then
    HOSTNAME=172.17.0.1
fi

SERVER_PORT=$2
if [ -z "$SERVER_PORT" ]
then
    SERVER_PORT=80
fi

NUM_LOOPS=$3
if [ -z "$NUM_LOOPS" ]
then
    NUM_LOOPS=1
fi

NUM_THREADS=$4
if [ -z "$NUM_THREADS" ]
then
    NUM_THREADS=1
fi

THINK_TIME=$5
if [ -z "$THINK_TIME" ]
then
    THINK_TIME=250
fi

TEST_SCRIPT=$6
if [ -z "$TEST_SCRIPT" ]
then
    TEST_SCRIPT="load.jmx"
fi

TEST_DEBUG=$7
if [ -z "$TEST_DEBUG" ]
then
    TEST_DEBUG=false
fi

echo "============================================================================"
echo "START Running Jmeter on `date`"
echo "HOSTNAME    : $HOSTNAME"
echo "SERVER_PORT : $SERVER_PORT"
echo "NUM_THREADS : $NUM_THREADS"
echo "NUM_LOOPS   : $NUM_LOOPS"
echo "THINK_TIME  : $THINK_TIME"
echo "TEST_SCRIPT : $TEST_SCRIPT"
echo "TEST_DEBUG  : $TEST_DEBUG"
echo "============================================================================"
#exit
if [ "$TEST_DEBUG" == "true" ]
then        
    jmeter -n -t $TEST_SCRIPT \
        -JHOSTNAME=$HOSTNAME \
        -JSERVER_PORT=$SERVER_PORT \
        -JNUM_THREADS=$NUM_THREADS \
        -JNUM_LOOPS=$NUM_LOOPS \
        -JTHINK_TIME=$THINK_TIME \
        -l out.log 
    cat jmeter.log
    cat out.log
else
    jmeter -n -t $TEST_SCRIPT \
        -JHOSTNAME=$HOSTNAME \
        -JSERVER_PORT=$SERVER_PORT \
        -JNUM_THREADS=$NUM_THREADS \
        -JNUM_LOOPS=$NUM_LOOPS \
        -JTHINK_TIME=$THINK_TIME
fi

echo "END Running Jmeter on `date`"     