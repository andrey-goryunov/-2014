#!/bin/bash
#
# Скрипт сопоставляет данные из таблицы c файлами и выводит соответсвие
#
#
#~ unoconv -vvv -f csv -e FilterOptions="59,34,0,0" 11-matrix.ods

cat 11-matrix.csv | sed "1d"  | sed "1d" > 12-matrix.csv 

OLDIFS=$IFS
IFS=";"

echo "==Изображения товара, которых не хватает=="
while read line; do 
	array=( $line )
	art=${array[3]}
	filename=${art}.jpg
	fullfilename=main/original/${filename}
	if [ ! -f ${fullfilename} ];
	then
		echo ${art} "	не найден"
	fi
done < 12-matrix.csv



echo "==Интерьеры, которых не хватает=="
while read line; do 
	array=( $line )
	art=${array[3]}
	filename=${art}.jpg
	fullfilename=int/original/${filename}
	if [ ! -f ${fullfilename} ];
	then
		echo ${art} "	не найден"
	fi
done < 12-matrix.csv



IFS=$OLDIFS


