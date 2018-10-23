
filename=huanjingerr_$1_area.log
if [ -f $filename ]
then
    rm $filename
fi

for logfilename in `cat filename.list`
do
    if [ ! -f $logfilename ]
    then
        echo can not file $logfilename
        break
    fi
    echo '文件:'$logfilename >> $filename
    echo operating get_item_obtain_num $filename $logfilename
    ./get_item_obtain_num.sh $logfilename >> $filename
    echo '分割线' >> $filename
    echo operating get_item_box_consume $filename $logfilename
    ./get_item_box_consume.sh $logfilename >> $filename
done
