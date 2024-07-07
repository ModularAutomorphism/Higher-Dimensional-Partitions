# This is a Cython implementation for computing number of incoming edges at some depth of a partition graph
# The depth level and dimensionality of partition can be arbitrary and the function Tot(n,dim) takes them as arguments
# Author: Avinandan Mondal, Dept. of Physics, IIT Madras
# Date: 4 September 2023


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


cpdef int iscorner(part,node,int dim):
    cdef int i
    for i in range(dim+1):
        node_copy = node[:]
        node_copy[i] += 1
        if node_copy in part:
            return(0)
    return(1)

cpdef int incoming_edges(part,int dim):
    cdef int A = 0
    for node in part:
        if iscorner(part,node,dim) == 1:
            A += 1
    return(A)

cpdef void tot_cal_part_adder(possible,part,int initial,int final,int n,M,int dim):
    cdef int size, i
    size = len(part)
    M[size-1] += incoming_edges(part,dim)
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
            tot_cal_part_adder(possible1,part_copy,i+1,final+len(lst),n,M,dim)
            
cpdef Tot(int n, int dim):
    M = [0 for i in range(n)]
    P = [[0 for i in range(dim+1)]]
    possible = new_node_finder(P, dim)
    tot_cal_part_adder(possible,P,0,len(possible)-1,n,M,dim)
    return(M)

