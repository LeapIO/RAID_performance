#!/bin/bash

counter=0

debug=0
device="md1"
bs="1M"
runtime=900

while [[ "$#" -gt 0 ]]; do
	case $1 in
		-t|--test) debug=1 ;;
		-d|--device) device="$2"; shift ;;
		-b|--block) bs="$2"; shift ;;
		*) ;;
	esac
	shift
done

dirname="$device-$bs-$runtime"
mkdir $dirname

init () {
	rw="read"
	iodepth=16
}

run_fio() {
	let counter+=1
	long_iodepth=$(printf "%03d" $iodepth)
	filename="$rw-$device-$bs-$long_iodepth-$runtime.txt"
	if [[ $debug -eq 0 ]]; then
		rw=$rw device=$device runtime=$runtime bs=$bs iodepth=$iodepth fio config.fio > "$dirname/$filename"
	else
		touch "$dirname/$filename"
	fi
	echo -e "$counter\t$filename"
}

iodepth_test () {
	init
	iodepth=1
	for i in {1..10}; do
		run_fio
		let iodepth\*=2
	done
}

rw_test () {
	init
	rw_pool=('write' 'randread' 'randwrite' 'rw')
	for i in {1..4}; do
		for rw in "${rw_pool[@]}"; do
			run_fio
		done
		let iodepth\*=2
	done
}

iodepth_test

rw_test

echo "bye"
