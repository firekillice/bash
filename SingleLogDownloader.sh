#############################################################
date=20141105
#filename=hurdle_play_log.csv
#filename=hurdle_over.csv
#filename=game_money_obtain.csv
#filename=sys.log
#filename=err.log
#filename=hurdle_enter.csv

FILENAME_LIST=(
 #   'hurdle_play_log.csv'
 #   'hurdle_over.csv'
    'game_money_obtain.csv'
 #   'hurdle_enter.csv'
 #   'sys.log'
 #   'err.log'
)
#ipaddr='182.254.179.191'
#areaID=4

ipaddr='203.195.192.243'
areaID=1
#############################################################
dirname=area_$areaID
if [ ! -d $dirname ]
then
    mkdir $dirname
fi
if [ ! -d $dirname/$date ]
then
    mkdir $dirname/$date
fi

for filename in `echo ${FILENAME_LIST[@]}`
do
    scp -P 36000 -i ~/.ssh/key.file linghegu@$ipaddr:/data/gamelogs/server1/ZoneServer/logs/$date/$filename ./$dirname/$date
done
