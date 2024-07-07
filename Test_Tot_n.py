import Tot_n as master_tot
import time 

n = int(input("Enter n: "))
dim = int(input("Enter dimension: "))

start = time.time()
print(master_tot.Tot(n,dim))
end = time.time()
print("Execution time (in seconds): ", end-start)