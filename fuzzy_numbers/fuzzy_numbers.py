#!/usr/bin/python
import pylab

def frange(start, end=None, inc=None):
    "A range function, that does accept float increments..."

    if end == None:
        end = start + 0.0
        start = 0.0

    if inc == None:
        inc = 1.0

    L = []
    while 1:
        next = start + len(L) * inc
        if inc > 0 and next >= end:
            break
        elif inc < 0 and next <= end:
            break
        L.append(next)
        
    return L

class FuzzyNumber:
  STEP = 0.01
  PREC = 3

  def __init__(self, left, peak, right):
    self.peak = peak
    self.left = left
    self.right = right

  def membership(self, x):
    if self.left<=x<=self.peak:
      result= 1.0*(x-self.left)/(self.peak-self.left)
    elif self.peak<x<=self.right:
      result= 1.0*(self.right-x)/(self.right-self.peak)
    else:
      result= 0
    return result


  def extend(self, other, op):
    C = {}
    for x in frange(self.left,self.right,FuzzyNumber.STEP):
      for y in frange(other.left,other.right,FuzzyNumber.STEP):
        z = op(x,y)
        c = min(self.membership(x), other.membership(y))
        if z not in C or C[z]<c:
          C[z] = c
    return  C

  def operation(self, other, op):
    left_z,right_z,peak_z,peak_c = None,None,None,0
    C_z = self.extend(other, op)
    for z in C_z:
      c = C_z[z]
      if(c>0):
        if(left_z == None or z<left_z):
            left_z=z
        if(right_z == None or z>right_z):
            right_z=z
        if(c>peak_c):
            peak_c=c
            peak_z=z
    return FuzzyNumber(left_z, peak_z, right_z)

  def __add__(self, other):
    return self.operation(other, lambda x, y: x+y)
  
  def __sub__(self, other):
    return self.operation(other, lambda x, y: x-y)

  def __div__(self, other):
    return self.operation(other, lambda x, y: 1.0*x/y)

  def __mul__(self, other):
    return self.operation(other, lambda x, y: x*y)


  def __str__(self):
    return 'FuzzyNumber(' + str(self.left) + ', ' + str(self.peak) + ', ' + str(self.right) + ')'

  __repr__ = __str__

a = FuzzyNumber(1,2,4)
b = FuzzyNumber(2,4,6)
c = FuzzyNumber(2,5,7)
d = FuzzyNumber(12,15,17)

#plotting

def add_number(r, fig, ax):
  n = (r.left, r.peak, r.right)
  DATA = ((0, n[0]),
      (1, n[1]),
      (0, n[2]))

  (y,x) = zip(*DATA)

  ax.plot(x, y, marker='o')
  for i in xrange(len(DATA)):
    (x,y) = DATA[i]

if(__name__=='__main__'):

  #  CC_z = a.extend(b, lambda p, q: p*q)
#  x = sorted(CC_z.keys())
#  y = [CC_z[z] for z in x]

  fig = pylab.figure()
  ax = fig.add_subplot(111)
  ax.plot(x, y)
  for n in [a,b,a/b]: #, a-b, a*b, a/b]:
    add_number(n,fig,ax)
  pylab.show()
