## remove RAID

```shell
sudo umount /dev/md0
sudo mdadm --stop /dev/md0
sudo mdadm --remove /dev/md0
```

## setup RAID

```shell
sudo mdadm --zero-superblock /dev/nvme2n1 /dev/nvme3n1 /dev/nvme4n1
sudo mdadm --create --verbose /dev/md1 --level=5 --raid-devices=3 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme4n1
```

## check RAID details

```shell
sudo mdadm -D /dev/md0
```

## run test

```shell
sudo nohup ./run.sh > done.txt &
```

## parse result

```
./parse
./parse /path/to/dest
```

