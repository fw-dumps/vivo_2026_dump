#!/vendor/bin/sh

zRamSizeBytes=0
backingDevSizeM=0

function zram_writeback_config(){
	zram_writeback_trigger=`getprop persist.vendor.vivo.zramwb.enable`
	if [ "$zram_writeback_trigger" == "" ]; then
		zram_writeback_trigger=1
	fi
	if [ -f /sys/block/zram0/backing_dev ]; then
		life_time_a=`cat /sys/ufs/life_time_a`
		life_time_b=`cat /sys/ufs/life_time_b`
		if [ "$life_time_a" != "0x01" ] && [ "$life_time_a" != "0x02" ] && [ "$life_time_a" != "0x03" ] && [ "$life_time_a" != "0x04" ] && [ "$life_time_a" != "0x05" ]; then
			zram_writeback_trigger=0
		fi
		if [ "$life_time_b" != "0x01" ] && [ "$life_time_b" != "0x02" ] && [ "$life_time_b" != "0x03" ] && [ "$life_time_b" != "0x04" ] && [ "$life_time_b" != "0x05" ]; then
			zram_writeback_trigger=0
		fi
	else
		zram_writeback_trigger=0
	fi

	# for 4G zram, backing devie is 1.5G
	# for <4G zram, backing device is 1/4 of all
	if [ $zRamSizeBytes -ge 4294967296 ]; then
		backingDevSizeM=1536
		bdSizeShow=3072
	elif [ $zRamSizeBytes -ge 3221225472 ]; then
		backingDevSizeM=1024
		bdSizeShow=1024
	elif [ $zRamSizeBytes -ge 1610612736 ]; then
		backingDevSizeM=512
		bdSizeShow=512
	else
		backingDevSizeM=`expr $zRamSizeBytes / 3 / 1048576`
		bdSizeShow=$backingDevSizeM
	fi
	setprop persist.vendor.vivo.zramwb.size $bdSizeShow

	# bug fix, should re-create once
	created=`getprop persist.vendor.vivo.zramwb.created`
	if [ "$created" == "" ]; then
		rm /data/vendor/swap/zram
		setprop persist.vendor.vivo.zramwb.created 1
	fi

	# create file
	if [ "$zram_writeback_trigger" == "1" ] && [ ! -f /data/vendor/swap/zram ]; then
		# remaining space should bigger than the file to create.
		dataSpace=`df -k | grep /data$ | awk '{print $4}'`
		dataSpace=`expr $dataSpace / 1024`
		if [ $dataSpace -lt $bdSizeShow ]; then
			zram_writeback_trigger=0
		else
			#dd if=/dev/zero of=/data/vendor/swap/zram bs=1m count=$bdSizeShow
			bdSizeShow=`expr $bdSizeShow \* 1048576`
			touch /data/vendor/swap/zram
			f2fs_io pinfile set /data/vendor/swap/zram
			f2fs_io fallocate 0 0 $bdSizeShow /data/vendor/swap/zram
			if [ $? -ne 0 ]; then
				zram_writeback_trigger=0
			fi

			fileSize=`ls -la /data/vendor/swap/zram | awk '{print $5}'`
			# overflow, cannot use lt or gt, use equal
			if [ $fileSize -ne $bdSizeShow ]; then
				zram_writeback_trigger=0
			fi
		fi
	fi

	if [ "$zram_writeback_trigger" == "1" ]; then
		zRamSizeBytes=`expr $backingDevSizeM \* 1048576 + $zRamSizeBytes`
		echo /data/vendor/swap/zram > /sys/block/zram0/backing_dev
	else
		rm /data/vendor/swap/zram
	fi
}

function zram_writeback_parameter_config(){
	backingDevSizeLimit=`expr $backingDevSizeM \* 256`
	echo $backingDevSizeLimit > /sys/block/zram0/zram_wb/bd_size_limit
}

zramsize_reconfig(){
	swapoff /dev/block/zram0
	echo 1 > /sys/block/zram0/reset

	if [ -f /sys/block/zram0/backing_dev ]; then
		zram_writeback_config
	fi

	echo $zRamSizeBytes > /sys/block/zram0/disksize

	if [ -f /sys/block/zram0/zram_wb/bd_size_limit ]; then
		zram_writeback_parameter_config
	fi

	mkswap /dev/block/zram0
	swapon /dev/block/zram0

	echo 60 > /proc/sys/vm/swappiness
	echo 120 > /proc/sys/vm/rsc_swappiness
}

if [ ! -d /sys/block/zram0 ];then
	exit
fi

mem_size=`cat /proc/meminfo | awk '/MemTotal/ {print $2}'`

if [ "$mem_size" -lt "4194304" ];then
	zRamSizeBytes=2147483648
elif [ "$mem_size" -lt "6291456" ];then
	zRamSizeBytes=3221225472
else
	zRamSizeBytes=4294967296
fi
zramsize_reconfig
