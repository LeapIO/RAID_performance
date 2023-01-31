#!/bin/bash

#debug="no"

device="md1"

init () {
	rw="read"
	bs="1M"
	iodepth=16
	if [[ -z $debug ]]; then
		runtime=3
	else
		runtime=900
	fi
}

run_fio() {
	long_iodepth=$(printf "%03d" $iodepth)
	filename="$rw-$device-$bs-$long_iodepth-$runtime.txt"
	echo $filename
	rw=$rw device=$device runtime=$runtime bs=$bs iodepth=$iodepth fio config.fio > $filename
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
