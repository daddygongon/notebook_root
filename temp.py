# Jacobi iterative method for solving Ax=b
import numpy as np

A=np.array([[5,1,1,1],[1,3,1,1],[1,-2,-9,1],[1,3,-2,5]])
b=np.array([-6,2,-7,3])
n=4
x0=np.zeros(n)
x1=np.zeros(n)

for iter in range(0, 20):
    for i in range(0, n):
        x1[i]=b[i]
        for j in range(0, n):
            x1[i]=x1[i]-A[i][j]*x0[j]
        x1[i]=x1[i]+A[i][i]*x0[i]
        x1[i]=x1[i]/A[i][i]
    for j in range(0, n):
        x0[j]=x1[j]
    print(x0)

