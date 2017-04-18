#!/bin/bash
#set -x

installpath=$(pwd)
mkdir -p ${installpath}/watermarked

for i in *jpg
do
if [ -s $i ] ; then
	width=$(identify -format %w "${i}")
	logo=Happybu.ru
	convert -background '#0008' -fill white -gravity center -size ${width}x40 caption:${logo} "${i}" +swap -gravity south -composite ${installpath}/watermarked/"${i}"
	echo "Выполнено"
fi
done

# альтернативная версия:
#!/bin/bash
#mkdir -p watermarked/
#for i in *jpg *jpeg *png *gif;
#do
#if [ -s $i ] ; then   
#width=$(identify -format %w $i)
#capt=OVKfotooboi.ru
#convert -background '#0008' -fill white -gravity center -size ${width}x40 caption:${capt} $i +swap -gravity south -composite w-$i
#mv w-$i watermarked/
#echo "Выполнено"
#fi
#done;

