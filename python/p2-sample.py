import unittest
from p2 import reduce, groupby, construct, curry, compose

class Problem2Tests(unittest.TestCase):

    def test_reduce_simple(self):
        self.assertEquals(15, reduce(lambda x, y: x + y, [1, 2, 3, 4, 5]))

    def test_reduce_init(self):
        self.assertEquals(10, reduce(lambda x, y: x + y, [2, 3, 4], 1))

    def test_groupby_simple(self):
        self.assertEquals({4: ['spam', 'eggs'], 6: ['parrot', 'cheese'], 11: ['inquisition']},
                          groupby(len, ['spam', 'parrot', 'eggs', 'cheese', 'inquisition']))

    def test_groupby_even_odd(self):
        self.assertEquals({'even': [2, 4], 'odd': [1, 3]}, 
                          groupby(lambda x: 'odd' if x%2 else 'even', [1, 2, 3, 4]))

    def test_construct_simple(self):
        self.assertEquals([42, '*', '42', 'spam'], 
                          construct([abs, chr, str, lambda _: 'spam'], 42))

    def test_construct_multiple_parameters(self):
        self.assertEquals([3, -1], construct([lambda x, y: x + y, lambda x, y: x - y], 1, 2))

    def test_curry_simple(self):
        def add(x, y): return x + y
        add_one = curry(add, 1)
        self.assertEquals(2, add_one(1))
        
        power_of_2 = curry(map, lambda x: 2 ** x)

        self.assertEquals([1, 2, 4, 8, 16], list(power_of_2(range(5))))

    def test_curry_kwargs(self):
        def tuplify(a, b, c): return (a, b, c)
        
        self.assertEquals((1, 2, 3), curry(tuplify, 1, c = 3)(2))
        self.assertEquals((1, 2, 3), curry(tuplify, 1, c = 3)(b = 2))
        self.assertEquals((1, 2, 4), curry(tuplify, 1, c = 3)(2, c = 4))

    def test_compose_id(self):
        self.assertEquals(3, compose(max)([1, 2, 3]))

    def test_compose_simple(self):
        max_squared_inverted = compose(max, lambda x: x ** 2, lambda x: -x)
        self.assertEquals(-9, max_squared_inverted([1, 2, 3]))


if __name__ == '__main__':
    unittest.main()
