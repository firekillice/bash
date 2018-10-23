#get the monster renovator's err log

outputname=reg_account.log
zoneidfile=zoneid.list
summonfile=summon.list

zoneiddir=zoneidinfo
if [ -f $outputname ]
then
    rm $outputname
fi

if [ -f $zoneidfile ]
then
    rm $zoneidfile
fi

if [ ! -d $zoneiddir ]
then
    mkdir $zoneiddir
    echo mkaid $zoneiddir
fi

if [ -d $zoneiddir ]
then
    rm $zoneiddir/*
fi

for filename in `cat filename.list`
do
    echo $filename
    cat $filename | awk '{print "'$filename'",$1,$2,$3,$4,$5}' >> $outputname
done
