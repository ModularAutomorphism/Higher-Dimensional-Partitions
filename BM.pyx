# This is a Cython implementation of Bratley-McKay algorithm for computing partition function of any integer in any dimension
# Author: Avinandan Mondal, Dept. of Physics, IIT Madras
# Date: 4 September 2023
# Comments: Cythonize this file and then import it in the working .py file and use the function "partitions" 
# To cythonize the file, the easiest way is to import "easycython" and then typing out "easycython BM.pyx"

cpdef int ispossible(part, new, int dim):
    cdef int i
    for i in range(dim+1):
        copy_new = new[:]
        if copy_new[i] != 0:
            copy_new[i] = copy_new[i] - 1
            if copy_new not in part:
                return(0)
    return(1)


cpdef new_node_finder(part, int dim):
    cdef int i
    poss = []
    last_node = part[-1]
    for i in range(dim+1):
        new = last_node[:]
        new[i] += 1
        if ispossible(part, new, dim) == 1:
            poss.append(new)
    return(poss)

cpdef void part_adder(possible,part,int initial,int final,int n,M,int dim):
    cdef int size, i
    size = len(part)
    M[size-1] += 1
    if size == n:
        return
    else:
        for i in range(initial,final+1):
            part_copy = part[:]
            part_copy.append(possible[i])
            possible1 = possible[:]
            lst = new_node_finder(part_copy, dim)
            for j in lst:
                possible1.append(j)
            part_adder(possible1,part_copy,i+1,final+len(lst),n,M,dim)
            
cpdef partitions(int n, int dim): # Note that ordinary partition has dim = 1 and so on
    M = [0 for i in range(n)]
    P = [[0 for i in range(dim+1)]]
    possible = new_node_finder(P, dim)
    part_adder(possible,P,0,len(possible)-1,n,M,dim)
    return(M)
