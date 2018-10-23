#itemid=27342
filename=$1

cat $filename | awk '{print $3}' | sort | uniq > account.log

itemid_array=(
27340
27341
27342
)

for itemid in `echo ${itemid_array[@]}`
do
    for i in `cat account.log`
    do
        line=`cat $filename | grep $i  | grep $itemid | awk '{if ($10=='$itemid') print $6,$8,$9}'  | wc -l`
        nickname=`cat $filename | grep $i | head -n 1 | awk '{print $4}'`
        if [ $line -gt 0 ]
        then
            echo $i $nickname   $itemid itemget $line
        fi
    done
done
