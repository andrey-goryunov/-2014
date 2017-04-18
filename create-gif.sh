#!/bin/bash
#set -x

PWD=`pwd`
mkdir ${PWD}/data
mkdir ${PWD}/result


for img in *.jpg ; do

convert -gravity NorthEast -chop x250 ${PWD}/data/${img} ${PWD}/result/${img}
# СПРАВКА
# -gravity SouthEast -chop 390x
# 			NorthEast
# -сверху справо -отрезать 390 пикселей справа и 0 сверху

done

convert -delay 30 -loop 2 ${PWD}/result/*.jpg ${PWD}/animate.gif

rm -v ${PWD}/result/*.jpg



