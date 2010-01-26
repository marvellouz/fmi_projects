#!/usr/bin/python
import pylab



class FuzzyNumber:

  def __init__(self, left, peak, right):
    self.peak = peak
    self.left = left
    self.right = right
    self.all=[self.left, self.peak, self.right]

  def __add__(self, other):
    a = self.left + other.left
    b = self.peak + other.peak
    c = self.right + other.right
    return FuzzyNumber(a, b, c)

  def __sub__(self, other):
    a = self.left - other.left
    b = self.peak - other.peak
    c = self.peak - other.peak
    return FuzzyNumber(a, b, c)

  def __mul__(self, other):
    a = min(self.left * other.left, self.left * other.right, self.right * other.left, self.right * other.right)
    b = self.peak * other.peak
    c = max(self.left * other.left, self.left * other.right, self.right * other.left, self.right * other.right)
    return FuzzyNumber(a, b, c)

  def __div__(self, other):
    if (other.left != 0 and other.peak != 0 and other.right != 0):
      a = min(self.left / other.left, self.left / other.right, self.right / other.left, self.right / other.right)
      b = self.peak / other.peak
      c = max(self.left / other.left, self.left / other.right, self.right / other.left, self.right / other.right)
      return FuzzyNumber(a, b, c)

  def tuple(self):
     return tuple(self.all)

  def __str__(self):
    return 'FuzzyNumber(' + str(self.left) + ', ' + str(self.peak) + ', ' + str(self.right) + ')'

  __repr__ = __str__

a = FuzzyNumber(1,3,9)
b = FuzzyNumber(4,6,8)

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
  for n in [a,b, a+b]: #, a-b, a*b, a/b]:
    add_number(n,fig,ax)
  pylab.show()
