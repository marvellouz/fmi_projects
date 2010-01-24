from p4 import enumerate_fractions, enumerate_all_fractions, pitagores, partition, permutations

from fractions import Fraction
from itertools import islice

import unittest

class Problem4Tests(unittest.TestCase):

    def test_enumerate_fractions(self):
        self.assertEquals([Fraction(1,1), Fraction(2,1), Fraction(1,2), Fraction(1,3), Fraction(3,1)],
                          list(islice(enumerate_fractions(), 5)))

    def test_enumerate_fractions_initial(self):
        self.assertEquals([Fraction(2,1), Fraction(1,2), Fraction(1,3), Fraction(3,1)],
                          list(islice(enumerate_fractions(Fraction(2,1)), 4)))

    def test_enumerate_all_fracftions(self):
        self.assertEquals([Fraction(0), Fraction(1,1), Fraction(-1,1), Fraction(2,1), Fraction(-2,1)],
                          list(islice(enumerate_all_fractions(), 5)))

    def test_pitagores(self):
        self.assertEquals((4,3,5), next(pitagores()))

    def test_partiotion(self):
        self.assertEquals([[1,1,1,1], [1,1,2], [1,2,1], [1,3], [2,1,1], [2,2], [3,1], [4]],
                          list(partition(4)))
    
    def test_partiotion_predicate(self):
        self.assertEquals([[1,1,1,1], [1,3], [3,1]],
                          list(partition(4, lambda x: x % 2)))

    def test_permutations(self):
        self.assertEquals([[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]],
                          list(permutations([1,2,3])))

if __name__ == '__main__':
    unittest.main()
