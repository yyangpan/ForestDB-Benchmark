filename=$1

engine=$(echo $1 | cut -d'.' -f2)

if [ "$engine" != "fdb" ] && [ "$engine" != "rocksdb" ]

then 

	engine=$(echo $1 | cut -d'.' -f3)

fi


echo $1
doc=$2
if [ "$engine" = "fdb" ]
then
	grep "0.00 $doc" $1 | cut -d' ' -f1
	grep "0.00 $doc" $1 -A 3 | grep "ops/sec" | cut -d' ' -f1 
	grep "0.00 $doc" $1 -A 3 | grep 'proc IO' | cut -d'(' -f2 | cut -d' ' -f1
#	grep "0.00 $doc" $1 -A 3 | grep 'proc IO' | cut -d'(' -f2 | cut -d' ' -f1
	
        grep "us/read" $1 | cut -d'(' -f2 | cut -d' ' -f1	
        grep "us/write" $1 | cut -d'(' -f2 | cut -d' ' -f1	
        grep "us/read" $1 | cut -d'(' -f2 | cut -d' ' -f3	
        grep "us/write" $1 | cut -d'(' -f2 | cut -d' ' -f3
	grep "performed" $1 -A 5 | grep 'benchmark' | cut -d'(' -f2 | cut -d' ' -f1
	grep "performed" $1 -A 5 | grep 'throughput' | cut -d' ' -f5
	
	grep "performed" $1 -A 5 | grep 'proc IO' | cut -d'(' -f2 | cut -d' ' -f1
	
	grep "amplification" $1 | cut -d'(' -f2 | cut -d' ' -f1
	grep "amplification" $1 | cut -d' ' -f1
	
        #grep "us/write"  | grep writes | cut -d'(' -f2 | cut -d' ' -f3	
fi 
#grep 'proc IO' $1 | cut -d'(' -f1

if [ "$engine" = "rocksdb" ]
then
	grep "0.00 $doc" $1 | cut -d' ' -f1
	grep "0.00 $doc" $1 -A 3 | grep "ops/sec" | cut -d' ' -f1 
	grep "0.00 $doc" $1 -A 3 | grep 'proc IO' | cut -d'(' -f2 | cut -d' ' -f1
#	grep "background compaction" $1 -A 2 | grep 'proc IO' | cut -d'(' -f2 | cut -d' ' -f1
	
        grep "us/read" $1 | cut -d'(' -f2 | cut -d' ' -f1	
        grep "us/write" $1 | cut -d'(' -f2 | cut -d' ' -f1	
        grep "us/read" $1 | cut -d'(' -f2 | cut -d' ' -f3	
        grep "us/write" $1 | cut -d'(' -f2 | cut -d' ' -f3
	grep "performed" $1 -A 5 | grep 'benchmark' | cut -d'(' -f2 | cut -d' ' -f1
	grep "performed" $1 -A 5 | grep 'throughput' | cut -d' ' -f5
	
	grep "performed" $1 -A 5 | grep 'proc IO' | cut -d'(' -f2 | cut -d' ' -f1
	
	grep "amplification" $1 | cut -d'(' -f2 | cut -d' ' -f1
	
	grep "amplification" $1 | cut -d' ' -f1
        #grep "us/write"  | grep writes | cut -d'(' -f2 | cut -d' ' -f3	
fi


# get the physical size 
replace=sz

size=$(echo $1 | sed "s/log/$replace/")

cat $size | cut -d'G' -f1

# get the compaction log
compact=compactionvalue

compactionlog=$(echo $1 | sed "s/log/$compact/")

# analyze the compaction log and calculate the compaction time

awk '/initialize/ || /warming/ || /evaluation/ || $3~/^0.00/' $1 >$compactionlog

interval1=$(sed -n '/initialize/,/warming/ p' $compactionlog | wc -l)

let "interval1=interval1 - 2"

factor=0.1
t=$(echo $interval1*$factor | bc)
echo $t

interval1=$(sed -n '/warming/,/evaluation/ p' $compactionlog | wc -l)
let "interval1=interval1 - 2"
factor=0.1
t=$(echo $interval1*$factor | bc)
echo $t
interval1=$(sed -n '/evaluation/,// p' $compactionlog | wc -l)
let "interval1=interval1 - 1"
factor=0.1
t=$(echo $interval1*$factor | bc)
echo $t

