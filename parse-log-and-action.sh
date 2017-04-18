#!/bin/bash
#
# парсим syslog на наличие "linphone", если нашло выполняет скрипт linphone-tweak.sh

screen sudo -u user export DISPLAY=:0.0 && tail -f /var/log/syslog | perl -ne 'qx(/opt/scripts/linphone-tweak.sh) if /linphone/;'

# screen -r
# что бы свернуть: ctrl A затем D

# содержимое linphone-tweak.sh:
# logger "запустил-линфон" && sudo -u user linphone &


