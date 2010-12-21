import unittest
from p3 import Quaternion

class Problem3Tests(unittest.TestCase):

    def test_creation(self):
        self.assertEquals((0, 0, 0, 0), Quaternion().tuple())
        self.assertEquals((3, 0, 0, 0), Quaternion(3).tuple())
        self.assertEquals((3.14, 0, 0, 0), Quaternion(3.14).tuple())
        self.assertEquals((1, 2, 3, 4), Quaternion(1, 2, 3, 4).tuple())
        
        self.assertEquals((1, 2, 3, 4), Quaternion(1+2j, 3+4j).tuple())
        
        self.assertEquals((1, 2, 3, 4), Quaternion((1, 2, 3, 4)).tuple())
        self.assertEquals((1, 2, 3, 4), Quaternion([1, 2, 3, 4]).tuple())

        self.assertEquals((1, 2, 3, 4), Quaternion((1+2j, 3+4j)).tuple())
        self.assertEquals((1, 2, 3, 4), Quaternion([1+2j, 3+4j]).tuple())
        
        self.assertEquals((1, 2, 3, 4), 
                          Quaternion(Quaternion(1, 2, 3, 4)).tuple())

    def test_str(self):
        e, i, j, k = str(Quaternion(1.1, 2, 3, 4)).split('+')
        self.assertTrue(1.1 == float(e))
        self.assertTrue(2 == float(i[:-1]) and i[-1] == 'i')
        self.assertTrue(3 == float(j[:-1]) and j[-1] == 'j')
        self.assertTrue(4 == float(k[:-1]) and k[-1] == 'k')

        e, i, j, k = str(Quaternion(1.1, -2, -3, -4)).split('-')
        self.assertTrue(1.1 == float(e))
        self.assertTrue(2 == float(i[:-1]) and i[-1] == 'i')
        self.assertTrue(3 == float(j[:-1]) and j[-1] == 'j')
        self.assertTrue(4 == float(k[:-1]) and k[-1] == 'k')

    def test_eq(self):
        self.assertEquals(Quaternion(1), Quaternion(1))
    
    def test_unit(self):
        self.assertEquals((0.5, 0.5, 0.5, 0.5), 
                          Quaternion(1, 1, 1, 1).unit().tuple())

    def test_add(self):
        self.assertEquals((3, 5, 7, 9), \
                (Quaternion(1, 2, 3, 4) + Quaternion(2, 3, 4, 5)).tuple())

    def test_mul(self):
        self.assertEquals(Quaternion.i * Quaternion.j * Quaternion.k, Quaternion(-1))
        self.assertEquals(Quaternion.i * Quaternion.i * -1, Quaternion(1))

    def test_accessors(self):
        q = Quaternion(1, 2, 3, 4)
        
        self.assertEquals(1, q.e)
        self.assertEquals(2, q.i)
        self.assertEquals(3, q.j)
        self.assertEquals(4, q.k)

        self.assertEquals([1, 2, 3, 4], list(map(q.__getitem__, range(4))))

        self.assertEquals(1, q.scalar)
        self.assertEquals((0, 2, 3, 4), q.vector.tuple())

    def test_hash(self):
        self.assertEquals(2, len({Quaternion(1, 1, 1, 1), 
                                  Quaternion(2, 1, 1, 1), 
                                  Quaternion(1, 1, 1, 1)}))


    def test_constants(self):
        self.assertEquals((1, 0, 0, 0), Quaternion.e.tuple())
        self.assertEquals((0, 1, 0, 0), Quaternion.i.tuple())
        self.assertEquals((0, 0, 1, 0), Quaternion.j.tuple())
        self.assertEquals((0, 0, 0, 1), Quaternion.k.tuple())


if __name__ == '__main__':
    unittest.main()
