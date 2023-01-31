#!/bin/bash

mkdir -p trash
if [ `ls -1 *.txt 2>/dev/null | wc -l ` -gt 0 ];
then
	mv -f *.txt trash
fi
