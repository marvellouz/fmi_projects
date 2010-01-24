import unittest
import p1

class P1Tester(unittest.TestCase):
	def test_fizzbuzz(self):
		fizzbuzzes = [1, 2, 'Fizz', 4, 'Buzz', 'Fizz', 7, 8, 'Fizz', 'Buzz', 11, 'Fizz', 13, 14, 'FizzBuzz']
		self.assertEqual(fizzbuzzes, p1.fizzbuzz(15))	
	def test_minmaxmean(self):
		ages = {'Fry': 4, 'Zoidberg': 33, 'Bender': 2, 'Farnsworth': 160}
		minmaxmeans = ('Bender', 'Farnsworth', 'Zoidberg')
		self.assertEqual(minmaxmeans, p1.minmaxmean(ages))
	def test_anagrams(self):
		words = ['army', 'mary', 'ramy', 'astronomer', 'moonstarer', 'debit card', 'bad credit', 'bau']
		anagrams = [['army', 'mary', 'ramy'], ['bad credit', 'debit card'], ['astronomer', 'moonstarer']]
		self.assertEqual(set(map(frozenset, anagrams)), set(map(frozenset, p1.anagrams(words))))


if __name__ == "__main__":
	unittest.main()
