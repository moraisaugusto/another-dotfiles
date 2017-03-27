#!/bin/bash

( \speaker-test --frequency $1 --test sine > /dev/null)&
pid=$! 
\sleep 0.${2}s
\kill -9 $pid
