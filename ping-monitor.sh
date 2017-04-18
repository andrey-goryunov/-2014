#!/bin/bash
#set -x
# показать ip  -  ifconfig|sed -n "/inet addr:.*255.255.255.255/{s/.*inet addr://; s/ .*//; p}"

## основные настройки ##
HOST="192.168.7.72 192.168.7.62 192.168.7.64 192.168.7.151 192.168.7.60 192.168.7.117 192.168.7.68 192.168.7.127 192.168.7.110 192.168.7.92 192.168.7.61 192.168.7.48" # ip адреса
USR="user"
SSH="/usr/bin/ssh"
PING="/bin/ping"
NOW="$(date +%Y-%m-%d_%H:%M:%S)"

LOAD_WARN=100.0

##  цвет пинг статуса и элементы верстки ##
GREEN='<font color="#00ff00">'
RED='<font color="#ff0000">'
FONT='</font>'
LSTART='<ul class="list-group"><li class="list-group-item">'
LEND='</li></ul>'


## разметка ##
writeHead(){
 echo '<HTML><HEAD><TITLE>ping-status</TITLE>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="assets/components/themebootstrap/css/bootstrap.css" rel="stylesheet">
	</HEAD>
	<BODY>'
 echo '<CENTER><H1>'
 echo "Сгенерировано $NOW"
 echo '</CENTER>'
}

writeFoot(){
 echo "</BODY></HTML>"
}
 
## main ##
writeHead
echo '<div class="container"> <div class="row">'

for host in $HOST
do
  echo '<div class="col-md-3"> 
			<div class="panel panel-primary">' 
			
			
  $PING -c 1 $host > /dev/null  
  if [ "$?" != "0" ] ; then
    rping="$RED Failed $FONT"
    echo "<p>$host</p>" 
    echo "<p>status: $rping</p>"
    echo "<p>Uptime NA</p>"  
  else
    _CMD="$SSH $USR@$host"
    rhostname="$($_CMD hostname)" 
    
    # uptime
    ruptime="$($_CMD uptime)"
    if $(echo $ruptime | grep -E "min|day" > /dev/null); then
	 x=$(echo $ruptime | awk '{ print $3 $4}')
    else
	 x=$(echo $ruptime | sed s/,//g| awk '{ print $3 " (hh:mm)"}')
    fi
    ruptime="$x"
    #
    
    rload="$($_CMD uptime |awk -F'average:' '{ print $2}')"
	x="$(echo $rload | sed s/,//g | awk '{ print $2}')"
	y="$(echo "$x >= $LOAD_WARN" | bc)"
	[ "$y" == "1" ] && rload="$RED $rload (High) $FONT" || rload="$GREEN $rload (Ok) $FONT"
    
    rusedram="$($_CMD free -mto | grep Mem: | awk '{ print $3 " MB" }')"
	rfreeram="$($_CMD free -mto | grep Mem: | awk '{ print $4 " MB" }')"
	rtotalram="$($_CMD free -mto | grep Mem: | awk '{ print $2 " MB" }')"
    rclock="$($_CMD date +"%r")"
    rtotalprocess="$($_CMD ps axue | grep -vE "^USER|grep|ps" | wc -l)"
    ripaddress="$($_CMD ip a | grep 192.168.7. | awk '{ print $2 }' | tail -n 1)"
    rmac="$($_CMD ip a | grep link/ether | awk '{print $2}' | tail -n 1)"
    rmyname="$($_CMD cat ~/.me )"
    rping="$GREEN Ok $FONT"
    rcpuinfo="$($_CMD cat /proc/cpuinfo | grep "model name" | tail -n 1 | cut -f 2 -d :)"
    
    echo "<div class="panel-heading"> $rhostname </div>"
    echo "<div class="panel-body"> <h4 class="list-group-item-text"> $rmyname </h4> <br>"    
    echo "<p class="list-group-item-text">ip: $ripaddress </p>"
    echo "<p class="list-group-item-text">mac: $rmac </p>"
   
    echo "<p class="list-group-item-text">локальное время: $rclock</p> </div>"
    
    echo "$LSTART <p class="list-group-item-text">cpu: $rcpuinfo </p>"
    echo "<p class="list-group-item-text"> LA: $rload </p>"
    echo "<p class="list-group-item-text">Процессов: $rtotalprocess </p></li>"
    echo "<li class="list-group-item"><p class="list-group-item-text">Used RAM: $rusedram</p>" 
    echo "<p class="list-group-item-text">Free RAM: $rfreeram</p>"
    echo "<p class="list-group-item-text">Total RAM: $rtotalram</p> $LEND"
    
    echo "<div class="panel-footer">uptime: $ruptime</div>"
    
    
#    echo "<p>status: $rping</p>"  
  fi
  
  echo "</div></div>"
done

echo "</div></div>"
writeFoot
