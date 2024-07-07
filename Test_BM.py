import BM as bm_master

n = int(input("Enter n: "))
dim = int(input("Enter dimension: "))

from time import time
start = time()
print(bm_master.partitions(n,dim))
end = time()
print("Execution time (in seconds): ", end-start)