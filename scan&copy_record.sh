#!/bin/bash
# Author: renzituo
# Description: 用于复制话务系统中匹配到的音频文件，执行本脚本前须将要复制的音频文件整理为文档，名称为record.txt并放于/tmp/目录下。要去的匹配的目录根据实际的目录作修改。
# Version: 0.1

##创建目标目录，用以存放匹配到的音频文件。
destdir=/tmp/record_`date +%F`
##要去匹配音频文件的真实目录，根据实际情况修改。
sourcedir=/data/recording_2017-08-01
##要匹配的音频文件的列表文件。
sourcefile=/tmp/record.txt


if [[ ! -d $destdir ]]; then
	mkdir $destdir
fi

for record in `cat $sourcefile`; do
	for i in `ls $sourcedir`; do
		if [[ $record == $i ]]; then
			if [[ -f $destdir/$i ]]; then
				echo "$i already exists and does not need to be copied"
			else
				cp $sourcedir/$i $destdir/ && echo "copy $i to $destdir successfully"
			fi
		fi
	done
done

if [[ -f $destdir.zip ]]; then
	echo "$destdir.zip Already exists,no compression in needed"
else
	zip -r $destdir.zip $destdir/ &> /dev/null && echo "$destdir.zip Compression success" || echo "$desedir Compression failure"
fi
