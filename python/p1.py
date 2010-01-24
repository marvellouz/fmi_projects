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

def minmaxmean(ages):
        if ages=={}: return None
        sorted=[(q,p) for p,q in ages.items()]
        sorted.sort()
        mean=(sum(ages.values()))*1.0/len(ages)
        sorted1=sorted[:]
        nearest=[(abs(q-mean),p)for q,p in sorted1]
        nearest.sort()
        answer = (sorted[0][1], sorted[len(sorted)-1][1], nearest[0][1])
        return answer

def anagrams(words):
        ans=[list(filter(lambda a: sorted(a)==sorted(b),set(words)))for b in set(words)]
        anagram=[]
        for i in ans:
                if i not in anagram and len(i)>1:
                        anagram+=[i]
        return anagram




print(fizzbuzz(15))

print(minmaxmean({'Fry': 4, 'Zoidberg': 33, 'Bender': 2, 'Farnsworth': 160}))

print(anagrams(['army', 'mary', 'ramy', 'astronomer', 'moonstarer', 'debit card', 'bad credit', 'bau']))
