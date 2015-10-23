rows=$1
logdir=$2
dbdir=$3
cachemb=$4
writebufmb=$5
iterator=$6
warm=$7
run=$8
writerate=$9
doload=${10}
engine=${11}
iterbatch=${12}
periodic=${13}
nfiles=${14}
#BLOOM_VALUE
bloom=${15}
#INITIAL_THREAD_VALUE
threadint=${16}
#BODY_VALUE
bodylength=${17}
#COMP_THRESHOLD_VALUE
compthreshold=${18}
#ssd or hdd
device=${19}
#compaction style
compstyle=${20}

compression=${21}

sync=${22}

reader=${23}
writer=${24}
logpath=$logdir/log.$engine
dbpath=$dbdir/

NUMA="/usr/local/bin/numactl --interleave=all"

killall iostat
killall vmstat

bash gen_config.sh $rows $logpath $dbpath $cachemb $writebufmb $compression $reader $iterator $writer $warm $run $writerate $iterbatch $periodic $nfiles $bloom $threadint $bodylength $compthreshold $device $compstyle $engine $sync

#rm -f ${device}.${engine}.read.${reader}.write.${writer}.res
rm -f ${logpath}_*

if  [[ $doload -eq 1 ]]; then
echo Load at $( date )
#
( iostat -kx 2 >& ${device}.$engine.read.${reader}.write.${writer}.io & )
( vmstat 2 >& ${device}.$engine.read.${reader}.write.${writer}.vm & )
#
#$NUMA sudo ./${engine}_bench -f ${device}.bench_config.ini.load > ${device}.${engine}.load 2> ${device}.${engine}.err.load
$NUMA sudo ./${engine}_bench -f ${device}.${engine}.bench_config.ini.read.${reader}.write.${writer}
sudo mv  ${logpath}_* ${device}.${engine}.read.${reader}.write.${writer}.log
sudo du -hs ${dbpath} > ${device}.$engine.read.${reader}.write.${writer}.sz

if [ "$engine" = "rocksdb" ]
then
	sudo mv ${dbpath}0.0/LOG ${device}.${engine}.read.${reader}.write.${writer}.LOG
        grep "Compaction Stats" -B 1 -A 25 ${device}.${engine}.read.${reader}.write.${writer}.LOG > ${device}.${engine}.read.${reader}.write.${writer}.compaction

fi

grep elapsed ${device}.$engine.read.${reader}.write.${writer}.log | head -4
grep elapsed ${device}.$engine.read.${reader}.write.${writer}.log | head -4 > ${device}.${engine}.read.${reader}.write.${writer}.res
#grep " 0\.00 " ${device}.$engine.read.${reader}.write.${writer}.log  > ${device}.${engine}.read.${reader}.write.${writer}.compaction

killall iostat
killall vmstat

fi
#
#for t in ows pqw rqw pq rq owa ; do
#for p in 1 n ; do
#
#( iostat -kx 2 >& o.$engine.io.$t.$p & )
#( vmstat 2 >& o.$engine.vm.$t.$p & )
#$NUMA ./${engine}_bench bench_config.ini.$t.$p > o.${engine}.$t.$p 2> o.${engine}.err.$t.$p
#cp ${logpath}_* o.${engine}.log.$t.$p
#du -hs ${dbpath}* > o.$engine.sz.$t.$p
#
#echo $t $p $( grep ops\/sec\,  o.$engine.$t.$p | grep -v total ) 
#
#killall iostat
#killall vmstat
#
#done
#done
#echo load >> ${device}.${engine}.read.${reader}.write.${writer}.res
#echo $(grep "0.00 ${rows}" ${device}.${engine}.read.${reader}.write.${writer}.log -A 7) >> ${device}.${engine}.read.${reader}.write.${writer}.res
sudo ./process.sh ${device}.${engine}.read.${reader}.write.${writer}.log $rows > ${device}.${engine}.read.${reader}.write.${writer}.res
#
#for t in ows owa pqw rqw pq rq ; do
#for p in 1 n ; do
#echo $t $p $( grep ops\/sec\,  o.$engine.$t.$p | grep -v total ) >> o.${engine}.res
##echo $(cat o.${engine}.log.$t.$p | grep "${run}.0" -A 5) >> o.${engine}.res
##echo $(cat o.${engine}.log.$t.$p | grep "${rows}" -A 7) >> o.${engine}.res
#echo $(grep "0.00 ${rows}" o.${engine}.log.$t.$p -A 7) >> o.${engine}.res
#echo $(grep "${run}.0 sec elapsed" o.${engine}.log.$t.$p -A 5) >> o.${engine}.res
#done 
#done 

