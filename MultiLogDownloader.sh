#############################################################
declare -a GAME_AREA_IP_ADDR
#GAME_AREA_IP_ADDR[1]='203.195.192.243'
#GAME_AREA_IP_ADDR[2]='203.195.180.223'
#GAME_AREA_IP_ADDR[3]='203.195.162.169'
#GAME_AREA_IP_ADDR[4]='182.254.179.191'
#GAME_AREA_IP_ADDR[5]='182.254.179.33'
#GAME_AREA_IP_ADDR[6]='203.195.232.171'
#GAME_AREA_IP_ADDR[7]='203.195.150.155'
#GAME_AREA_IP_ADDR[8]='182.254.189.233'
#GAME_AREA_IP_ADDR[9]='182.254.190.36'
#GAME_AREA_IP_ADDR[10]='182.254.198.109'
#GAME_AREA_IP_ADDR[11]='182.254.198.92'
#GAME_AREA_IP_ADDR[12]='182.254.197.71'
#GAME_AREA_IP_ADDR[13]='182.254.203.140'
#GAME_AREA_IP_ADDR[14]='182.254.204.115'
#GAME_AREA_IP_ADDR[15]='203.195.233.192'
#GAME_AREA_IP_ADDR[16]='203.195.177.226'
#GAME_AREA_IP_ADDR[17]='203.195.178.74'
GAME_AREA_IP_ADDR[18]='203.195.155.241'
GAME_AREA_IP_ADDR[19]='182.254.172.92'
GAME_AREA_IP_ADDR[20]='182.254.187.239'
GAME_AREA_IP_ADDR[21]='182.254.187.62'
GAME_AREA_IP_ADDR[22]='203.195.220.245'
GAME_AREA_IP_ADDR[23]='119.29.9.161'
GAME_AREA_IP_ADDR[24]='119.29.38.143'
GAME_AREA_IP_ADDR[25]='119.29.40.69'
#############################################################
date_array=(
20141102
20141103
20141104
20141105
20141106
20141107
20141108
20141109
20141110
20141111
20141112
20141113
20141114
20141115
20141116
20141117
20141118
20141119
20141120
20141121
20141122
20141123
20141124
20141125
20141126
20141127
20141128
20141129
20141130
20141201
20141202
20141203
20141204
20141205
20141206
20141207
20141208
20141209
20141210
20141211
20141212
20141213
20141214
20141215
20141216
20141217
20141218
)

#filename=game_money_consume.csv
filename=role_login.csv
filenamelist=filename.list
logpath=/data/gamelogs/server1/LoginServer/logs
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
    echo $areaID
    for date in `echo ${date_array[@]}`
    do
       echo $date
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
done
