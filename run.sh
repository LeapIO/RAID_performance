#!/bin/bash

debug="no"

device="md0"
rw="read"
bs="1M"
iodepth=16
runtime=30

init () {
	device="md0"
	rw="read"
	bs="1M"
	iodepth=16
	if [[ -z $debug ]]; then
		runtime=30
	else
		runtime=900
	fi
}

iodepth_test () {
	init
	iodepth=1
	for i in {1..5}; do
		filename="$rw-$device-$bs-$iodepth-$runtime.txt"
		echo $filename
		rw=$rw device=$device runtime=$runtime bs=$bs iodepth=$iodepth fio config.fio > $filename
		let iodepth\*=2
	done
}

rw_test () {
	init
	rw_pool=('write' 'randread' 'randwrite' 'rw')
	for rw in "${rw_pool[@]}"; do
		filename="$rw-$device-$bs-$iodepth-$runtime.txt"
		echo $filename
		rw=$rw device=$device runtime=$runtime bs=$bs iodepth=$iodepth fio config.fio > $filename
	done
}

iodepth_test

rw_test

echo "bye"
