#get the monster renovator's err log

outputname=monster_location_err.log
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
    cat $filename  | grep ERROR:_check:actor |   grep "check zone" | awk '{print $6,$8,$11,$14}' >> $outputname
done

cat $outputname | awk '{print $3}' | sort | uniq > $zoneidfile
cat $outputname | awk '{if ($1 == "[3]") print $2}' | sort | uniq > $summonfile


for zoneid in `cat $zoneidfile`
do  
    linenum=`cat $outputname | grep $zoneid | awk '{if ('$zoneid' == $3 && $1=="[3]")print $1,$2,$4}' | wc -l`
    if [ $linenum -gt 0 ]
    then
        cat $outputname | grep $zoneid | awk '{if ('$zoneid' == $3 && $1=="[3]")print $1,$2,$4}' > $zoneiddir/$zoneid.list
    fi
done


