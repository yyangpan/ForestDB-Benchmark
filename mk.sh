rm wt_bench fdb_bench rocksdb_bench leveldb_bench
make clean
 
rm -f CMakeCache.txt 
cmake -DCMAKE_INCLUDE_PATH=${1}/include -DCMAKE_LIBRARY_PATH=${1}/build ../
make fdb_bench

rm -f CMakeCache.txt 
cmake -DCMAKE_INCLUDE_PATH=${2} -DCMAKE_LIBRARY_PATH=${2}/.libs ../
make wt_bench

rm -f CMakeCache.txt 
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INCLUDE_PATH=${3}/include -DCMAKE_LIBRARY_PATH=${3} ../
make V=1 VERBOSE=1 rocksdb_bench >& o.rox

rm -f CMakeCache.txt 
cmake -DCMAKE_INCLUDE_PATH=${4}/include -DCMAKE_LIBRARY_PATH=${4} ../
make leveldb_bench 

ldd wt_bench 
ldd fdb_bench 
ldd rocksdb_bench
ldd leveldb_bench
