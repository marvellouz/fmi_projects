def fizzbuzz (n):
	a=list(range(1, n+1))
	for i in range(0,len(a)):
		if a[i]%3==0 and a[i]%5==0:
			a[i]='FizzBuzz'
		elif a[i]%3==0:
			a[i]='Fizz'
		elif a[i]%5==0:
			a[i]='Buzz'
		
	return a
		
#print(fizzbuzz(15))

def minmaxmean(ages):
	if ages=={}: return None
	sorted=[(q,p) for p,q in ages.items()]
	sorted.sort()
#	print (sorted)
	mean=(sum(ages.values()))*1.0/len(ages)
	sorted1=sorted[:]
	nearest=[(abs(q-mean),p)for q,p in sorted1]
	nearest.sort()
	answer = (sorted[0][1], sorted[len(sorted)-1][1], nearest[0][1])
	return answer
#minmaxmean({'Fry': 4, 'Zoidberg': 33, 'Bender': 2, 'Farnsworth': 160})



def anagrams(words):
	ans=[list(filter(lambda a: sorted(list(a))==sorted(list(b)),set(words)))for b in words]
	anagram=[]
	for i in ans:
		if i not in anagram and len(i)>1:
			anagram+=[i]
	return anagram
	



def anagrams(words):
	ans = [list(filter(lambda a: len(a)==len(b) and set(a)==set(b), set(words))) for b in set(words)]
	print (ans)
	for i in range(len(ans)):
		ans[i]=sorted(ans[i])
	print (ans)	
	anagram=[]
	for i in ans:
		if i not in anagram and len(i)>1:
			anagram+=[i]
	return anagram

print(anagrams(['army','army','army', 'mary', 'ramy', 'astronomer', 'moonstarer','bau', 'debit card', 'bad credit', 'bau']))

