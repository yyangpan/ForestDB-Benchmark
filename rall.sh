rows=$1
logdir=$2
dbdir=$3
cachemb=$4
writebufmb=$5
nthr=$6
warm=$7
run=$8
writerate=$9
doload=${10}
engine=${11}

compression=true

logpath=$logdir/log.$engine
dbpath=$dbdir/db.$engine

killall iostat
killall vmstat

bash gen_config.sh $rows $logpath $dbpath $cachemb $writebufmb $compression $nthr $nthr $nthr $warm $run $writerate

rm -f o.res
rm -f ${logpath}_*

if  [[ $doload -eq 1 ]]; then
echo Load at $( date )

( iostat -kx 2 >& o.$engine.io.load & )
( vmstat 2 >& o.$engine.vm.load & )

./${engine}_bench bench_config.ini.load > o.${engine}.load 2> o.${engine}.err.load
mv ${logpath}_* o.${engine}.log.load
du -hs ${dbpath}* > o.$engine.sz.load

grep elapsed o.$engine.load | head -3
grep elapsed o.$engine.load | head -3 > o.res

killall iostat
killall vmstat

fi

for t in owa ows pqw rqw pq rq ; do
for p in 1 n ; do

( iostat -kx 2 >& o.$engine.io.$t.$p & )
( vmstat 2 >& o.$engine.vm.$t.$p & )

./${engine}_bench bench_config.ini.$t.$p > o.${engine}.$t.$p 2> o.${engine}.err.$t.$p
mv ${logpath}_* o.${engine}.log.$t.$p
du -hs ${dbpath}* > o.$engine.sz.$t.$p

echo $t $p $( grep ops\/sec\,  o.$engine.$t.$p | grep -v total ) 

killall iostat
killall vmstat

done
done

for t in owa ows pqw rqw pq rq ; do
for p in 1 n ; do
echo $t $p $( grep ops\/sec\,  o.$engine.$t.$p | grep -v total ) >> o.res
done 
done 

