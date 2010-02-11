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
  STEP = 0.05
  EPS = 0.05
  PREC = 3

  def __init__(self, left, peak, right):
    self.peak = peak
    self.left = left
    self.right = right
    self.all=[self.left, self.peak, self.right]

  def membership(self, x):
    if self.left<=x<=self.peak:
      return 1.0*(x-self.left)/(self.peak - self.left)
    elif self.peak<x<=self.right:
      return 1-(1.0*(x-self.peak)/(self.right - self.peak))
    else:
      return 0

#  @staticmethod
#  def extend(z, fn1, fn2):
#    C_z=[]
#    for x in frange(fn1.left, fn1.right, FuzzyNumber.STEP):
#      for y in frange(fn2.left, fn2.right, FuzzyNumber.STEP):
#        if abs(z-x*y)<FuzzyNumber.EPS:
#          C_z+=[min(fn1.membership(x), fn2.membership(y))]
#    if not C_z:
#      return 0
#    else:
#      return max(C_z)

  def __mul__(self, other):
    CC_z = {}
    for x in frange(self.left,self.right,FuzzyNumber.STEP):
      for y in frange(other.left,other.right,FuzzyNumber.STEP):
        z = round(x*y, FuzzyNumber.PREC)
        c = min(self.membership(x), other.membership(y))
        if z not in CC_z or CC_z[z]<c:
          CC_z[z] = c

    left_z,right_z,peak_z,peak_c = None,None,None,0

    for z in CC_z:
      c = CC_z[z]
      if(c>0):
        if(left_z == None or z<left_z):
            left_z=z
        if(right_z == None or z>right_z):
            right_z=z
        if(c>peak_c):
            peak_c=c
            peak_z=z

    return FuzzyNumber(left_z, peak_z, right_z)

#    for x in frange(self.left,self.right,FuzzyNumber.STEP):
#      for y in frange(other.left,other.right,FuzzyNumber.STEP):
#        z = round(x*y, FuzzyNumber.PREC)
#
#
#
#    all_z = []
#    for x in frange(self.left,self.right,FuzzyNumber.STEP):
#      for y in frange(other.left,other.right,FuzzyNumber.STEP):
#        all_z+=[x*y]
#    print len(all_z)
#
#
#    #all_z = [x*y for x, y in zip(frange(self.left, self.right, FuzzyNumber.STEP), frange(other.left, other.right, FuzzyNumber.STEP))]
#    min_z = min(all_z)
#    max_z = max(all_z)
#    C_z = [(FuzzyNumber.extend(z, self, other),z) for z in sorted(all_z)] #frange(min_z, max_z, FuzzyNumber.STEP)]
#
#    left,right,peak = None,None,None
#    for (c,z) in C_z:
#      if c>0:
#        left=z-FuzzyNumber.STEP
#        break
#    assert(left)
#
#    for (c,z) in reversed(C_z):
#      if c>0:
#        right = z+FuzzyNumber.STEP
#        break
#    assert(right)
#
#    z_peak = None
#    c_peak = 0
#    for (c,z) in C_z:
#      if c > c_peak:
#        z_peak = z
#        c_peak = c
#        print c
#    peak = z_peak
#    assert(peak)
#
#    return FuzzyNumber(left, peak, right)



#  def __add__(self, other):
#    a = self.left + other.left
#    b = self.peak + other.peak
#    c = self.right + other.right
#    return FuzzyNumber(a, b, c)
#
#  def __sub__(self, other):
#    a = self.left - other.left
#    b = self.peak - other.peak
#    c = self.right - other.right
#    return FuzzyNumber(a, b, c)
#
#  def __mul__(self, other):
#    a = min(self.left * other.left, self.left * other.right, self.right * other.left, self.right * other.right)
#    b = self.peak * other.peak
#    c = max(self.left * other.left, self.left * other.right, self.right * other.left, self.right * other.right)
#    return FuzzyNumber(a, b, c)
#
#  def __div__(self, other):
#    if (other.left != 0 and other.peak != 0 and other.right != 0):
#      a = min(self.left / other.left, self.left / other.right, self.right / other.left, self.right / other.right)
#      b = self.peak / other.peak
#      c = max(self.left / other.left, self.left / other.right, self.right / other.left, self.right / other.right)
#      return FuzzyNumber(a, b, c)
#
  def tuple(self):
     return tuple(self.all)

  def __str__(self):
    return 'FuzzyNumber(' + str(self.left) + ', ' + str(self.peak) + ', ' + str(self.right) + ')'

  __repr__ = __str__

a = FuzzyNumber(1,2,4)
b = FuzzyNumber(2,4,6)
c = FuzzyNumber(2,5,7)
d = FuzzyNumber(12,15,17)

#plotting

def add_number(r, fig, ax):
  n = r.tuple()
  DATA = ((0, n[0]),
      (1, n[1]),
      (0, n[2]))

  (y,x) = zip(*DATA)

  ax.plot(x, y, marker='o')
  for i in xrange(len(DATA)):
    (x,y) = DATA[i]

if(__name__=='__main__'):
  fig = pylab.figure()
  ax = fig.add_subplot(111)
  for n in [a,b,a*b]: #, a-b, a*b, a/b]:
    add_number(n,fig,ax)
  print (a * b)
  pylab.show()
