#!/bin/bash
userdata=$(zenity --forms --title="SRV RDP" --text="Авторизация" --add-entry="Логин:")
user="`echo $userdata|cut -d '|' -f 1`"


if [[ $user == user1 ]] ; then 
xfreerdp /u:d.user1  /d:NSIV /p:"password" /cert-ignore /w:1440 /h:810 /v:192.168.7.6 +fonts +clipboard  
fi

if [[ $user == user2 ]] ; then 
xfreerdp /u:e.user2  /d:NSIV /p:"password" /cert-ignore /w:1200 /h:780 /v:192.168.7.6 +fonts +clipboard
fi

if [[ $user == user3 ]] ; then 
xfreerdp /u:username3  /d:NSIV /p:"password" /cert-ignore /w:1440 /h:810 /v:192.168.7.6 +fonts +clipboard  
fi





