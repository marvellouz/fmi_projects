def reduce(dyad, seq, init = None):
	if seq==[]:
		return init
	if init==None:
		current=dyad(seq[0], seq[1])
		index=2
	if init != None:
		current=dyad(init, seq[0])
		index=1
	for i in range(index,len(seq)):
		current=dyad(current, seq[i])
	return current


def groupby(function, seq):
	tmp={}
	for i in seq:
		tmp[function(i)]=[]
	for i in seq:
		tmp[function(i)]+=[i]
	return tmp


def construct(functions, *args):
	l=[]
	for function in functions:
		l+=[function(*args)]
	return l



def curry(function, *args, **kwargs):
	def func(*args1, **kwargs1):
		kwargs.update(**kwargs1)
		return function(*(args+args1), **kwargs)
	return func



def compose(func, *functions):
	def f(*args,**kwargs):
		a=func(*args,**kwargs)
		if functions:
			for i in functions:
				a=i(a)
		return a
	return f
