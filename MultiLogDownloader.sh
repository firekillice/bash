#############################################################
declare -a GAME_AREA_IP_ADDR
GAME_AREA_IP_ADDR[1]='203.195.192.243'
GAME_AREA_IP_ADDR[2]='203.195.180.223'
GAME_AREA_IP_ADDR[3]='203.195.162.169'
GAME_AREA_IP_ADDR[4]='182.254.179.191'
GAME_AREA_IP_ADDR[5]='182.254.179.33'
GAME_AREA_IP_ADDR[6]='203.195.232.171'
GAME_AREA_IP_ADDR[7]='203.195.150.155'
GAME_AREA_IP_ADDR[8]='182.254.189.233'
GAME_AREA_IP_ADDR[9]='182.254.190.36'
GAME_AREA_IP_ADDR[10]='182.254.198.109'
GAME_AREA_IP_ADDR[11]='182.254.198.92'
GAME_AREA_IP_ADDR[12]='182.254.197.71'
GAME_AREA_IP_ADDR[13]='182.254.203.140'
GAME_AREA_IP_ADDR[14]='182.254.204.115'
GAME_AREA_IP_ADDR[15]='203.195.233.192'
GAME_AREA_IP_ADDR[16]='203.195.177.226'
GAME_AREA_IP_ADDR[17]='203.195.178.74'
#############################################################
date=20141102
#filename=game_money_consume.csv
filename=err.log
filenamelist=filename.list
logpath=/data/gamelogs/server1/ZoneServer/logs
#############################################################

if [ -f $filenamelist ]
then
    rm $filenamelist
fi

echo Please input rsa key phase...
read -s keyphase

#for ipaddr in `echo ${GAME_AREA_IP_ADDR[@]}`
for areaID in ${!GAME_AREA_IP_ADDR[@]}
do
    ipaddr=${GAME_AREA_IP_ADDR[$areaID]}
    echo downloading $areaID  $ipaddr

    dirname=area_$areaID
    if [ ! -d $dirname ]
    then
        mkdir $dirname
    fi
    if [ ! -d $dirname/$date ]
    then
        mkdir $dirname/$date
    fi
    
   # scp -P 36000 -i ~/.ssh/key.file linghegu@$ipaddr:/data/gamelogs/server1/ZoneServer/logs/$date/$filename ./$dirname/$date
   ./expectfile.sh $ipaddr 36000 linghegu  ~/.ssh/key.file $keyphase $logpath/$date/$filename ./$dirname/$date

   echo ./$dirname/$date/$filename >> $filenamelist
done
