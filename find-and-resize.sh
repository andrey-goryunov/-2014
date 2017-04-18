#!/bin/bash
set -x

find -type f -size +500k -name '*.JPG' | while read img; do

# получаем ширину изображения
width=$(identify ${img} | awk '{ print $3 }' | sed -r 's/x[[:digit:]].+//')

# если изображение больше 1920, то
if [ "$width" -gt "1920" ] ; then

# ресайзим по ширине и оптимизируем
convert "${img}" -resize 1920x -quality 90 -strip "${img}"

else

# если меньше 1920 - просто оптимизируем
convert "${img}" -quality 90 -strip ${img}
fi

done
