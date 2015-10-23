warm=600
duration=3600
doc=50000000
#warm=60
#duration=50
#doc=5000000
bodylength=1024
cachesize=8096
buffersize=64
reader=4
writer=1

period=no
sync=sync
compression=true
index=0
threshold=50

echo "==========ssd${index}_test=========="
echo "FDB TEST"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold ssd${index} level $compression $sync $reader $writer
sudo rm -rf /data/nvme/*
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold  ssd${index} level $compression $sync $reader $writer
sudo rm -rf /data/nvme/* 


echo "==========hdd${index}_test=========="
echo "FDB TEST"
sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold hdd${index} level $compression $sync $reader $writer
sudo rm -rf data/*
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold hdd${index} level $compression $sync $reader $writer
sudo rm -rf data/*

index=0.0

threshold=75
echo "FDB TEST Threshold"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold ssd${index} level $compression $sync $reader $writer
sudo rm -rf /data/nvme/*

sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold hdd${index} level $compression $sync $reader $writer
sudo rm -rf data/*


echo "==========ssd${index}_test=========="
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold ssd${index} universal $compression $sync $reader $writer
sudo rm -rf /data/nvme/*


echo "==========hdd${index}_test=========="
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold hdd${index} universal $compression $sync $reader $writer
sudo rm -rf data/*

sync=sync
compression=false
index=1

threshold=50
echo "==========ssd${index}_test=========="
echo "FDB TEST"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold ssd${index} level $compression $sync $reader $writer
sudo rm -rf /data/nvme/*
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold  ssd${index} level $compression $sync $reader $writer
sudo rm -rf /data/nvme/*


echo "==========hdd${index}_test=========="
echo "FDB TEST"
sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold hdd${index} level $compression $sync $reader $writer
sudo rm -rf data/*
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold hdd${index} level $compression $sync $reader $writer
sudo rm -rf data/*

index=1.0
threshold=75
echo "FDB TEST Threshold"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold ssd${index} level $compression $sync $reader $writer
sudo rm -rf /data/nvme/*

sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold hdd${index} level $compression $sync $reader $writer
sudo rm -rf data/*

echo "==========ssd${index}_test=========="
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold ssd${index} universal $compression $sync $reader $writer
sudo rm -rf /data/nvme/*


echo "==========hdd${index}_test=========="
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold hdd${index} universal $compression $sync $reader $writer
sudo rm -rf data/*



sync=async
compression=true
index=2

threshold=50
echo "==========ssd${index}_test=========="
echo "FDB TEST"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold ssd${index} level $compression $sync $reader $writer
sudo rm -rf /data/nvme/*
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold  ssd${index} level $compression $sync $reader $writer
sudo rm -rf /data/nvme/*


echo "==========hdd${index}_test=========="
echo "FDB TEST"
sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold hdd${index} level $compression $sync $reader $writer
sudo rm -rf data/*
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold hdd${index} level $compression $sync $reader $writer
sudo rm -rf data/*

index=2.0

threshold=75
echo "FDB TEST Threshold"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold ssd${index} level $compression $sync $reader $writer
sudo rm -rf /data/nvme/*

sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold hdd${index} level $compression $sync $reader $writer
sudo rm -rf data/*
echo "==========ssd${index}_test=========="
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold ssd${index} universal $compression $sync $reader $writer
sudo rm -rf /data/nvme/*


echo "==========hdd${index}_test=========="
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold hdd${index} universal $compression $sync $reader $writer
sudo rm -rf data/*



sync=async
compression=false
index=3

threshold=50
echo "==========ssd${index}_test=========="
echo "FDB TEST"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold ssd${index} level $compression $sync $reader $writer
sudo rm -rf /data/nvme/*
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold  ssd${index} level $compression $sync $reader $writer
sudo rm -rf /data/nvme/*


echo "==========hdd${index}_test=========="
echo "FDB TEST"
sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold hdd${index} level $compression $sync $reader $writer
sudo rm -rf data/*
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold hdd${index} level $compression $sync $reader $writer
sudo rm -rf data/*

index=3.0

threshold=75
echo "FDB TEST Threshold"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold ssd${index} level $compression $sync $reader $writer
sudo rm -rf /data/nvme/*

sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 fdb 20 $period 64 0 8 $bodylength $threshold hdd${index} level $compression $sync $reader $writer
sudo rm -rf data/*
echo "==========ssd${index}_test=========="
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs /data/nvme $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold ssd${index} universal $compression $sync $reader $writer
sudo rm -rf /data/nvme/*


echo "==========hdd${index}_test=========="
echo "RocksDB TEST"
sudo ./rall.sh ${doc} logs data $cachesize $buffersize 1 $warm $duration 1000 1 rocksdb 20 $period 1 10 8 $bodylength $threshold hdd${index} universal $compression $sync $reader $writer
sudo rm -rf data/*


