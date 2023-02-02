#!/bin/bash

output_dir=$1

if [ -z $output_dir ]; then
	output_dir='.'
fi

python3 fio-parser/fio-parser.py --directory $output_dir
