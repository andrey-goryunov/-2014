#!/bin/bash
#set -x

## настройки ##
HOST="10.1.1.1 10.1.1.2" # ip адреса
USR="user"
SSH="/usr/bin/ssh"
PING="/bin/ping"
 
##  цвет пинг статуса и элементы верстки ##
GREEN='<font color="#00ff00">'
RED='<font color="#ff0000">'
FONT='</font>'
LSTART='<ul><li>'
LEND='</li></ul>'

## разметка ##
writeHead(){
 echo '<HTML><HEAD><TITLE>ping-status</TITLE></HEAD>
 <BODY>'
}

writeFoot(){
 echo "</BODY></HTML>"
}
 
## main ##
writeHead

echo '<table WIDTH=100% FRAME=HSIDES RULES=NONE" >'
echo '<tr VALIGN=TOP>'

for host in $HOST
do
  echo '<td>' 
  $PING -c 1 $host > /dev/null  
  if [ "$?" != "0" ] ; then
    rping="$RED Failed $FONT"
    echo "<b>$host</b> <br>" 
    echo "status: $rping <br>"
    echo "Uptime NA <br>"  
  else
    _CMD="$SSH $USR@$host"
    rhostname="$($_CMD hostname)" 
    
    # получаем uptime
    ruptime="$($_CMD uptime)"
    if $(echo $ruptime | grep -E "min|day" > /dev/null); then
	 x=$(echo $ruptime | awk '{ print $3 $4}')
    else
	 x=$(echo $ruptime | sed s/,//g| awk '{ print $3 " (hh:mm)"}')
    fi
    ruptime="$x"
    # получили uptime, вывод результатов
    
    rping="$GREEN Ok $FONT"
    echo "<b>$rhostname</b> <br>" 
    echo "status: $rping <br>"
    echo "Uptime $ruptime <br>"
  fi
  
  echo "</td>"
done

echo "</tr></table>"
writeFoot
