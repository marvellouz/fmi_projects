from fractions import Fraction
from math import sqrt

def gcd(a,b):
    while b:
        a, b = b, a % b
    return a

def enumerate_fractions(start=Fraction(1,1)):
	i=start.numerator
	j=start.denominator
	n=i+j
	while 1:
		while (j<n and i>=1):
			if gcd(i,j)==1:
				if (i+j)%2!=0:
					yield(Fraction(i,j))
				else:
					yield(Fraction(j,i))
			i-=1
			j+=1
		n+=1
		i=n
		j=0




def enumerate_all_fractions(start=Fraction()):
	a=enumerate_fractions(start)
	if start<Fraction():
		yield(start)
		yield(-start)
		a=enumerate_fractions(-start)
		next(a)
	if start==Fraction():
		yield (start)
	while 1:
		b=next(a)
		yield(b)
		yield(-b)
		


def isint(x):
	y=int(x)
	return x==y


def pitagores(x=1, y=1):
	a=enumerate_fractions(Fraction(x,y))
	while 1:
		b=next(a)
		z=sqrt(b.numerator**2+b.denominator**2)
		if isint(z):
			yield(b.numerator,b.denominator,int(z))


def partition(n, predicate=None, part=None):
	if part==None:
		part=[]
	for i in range(1,n+1):
		next_part=part+[i]
		if sum(next_part)<n:
			for x in partition(n,predicate,next_part):
				yield x
		if sum(next_part)==n:
			if not predicate or all(map(predicate, next_part)):
				yield next_part


def permutations(l, output=None):
	if output==None:
		output=[]
	for element in l:
		if element in output: continue
		next_output=output+[element]
		if len(next_output)<len(l):
			for x in permutations(l, next_output):
				yield x
		if len(l)==len(next_output):
			yield next_output


