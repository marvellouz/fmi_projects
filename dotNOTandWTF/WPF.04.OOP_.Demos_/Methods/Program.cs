using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Methods
{
    public struct Point
    {
        internal int x, y;

        public static void IncorrectMultiplyBy2(Point aPoint)
        {
            aPoint.x *= 2; aPoint.y *= 2;
        }

        public static void MultiplyBy2(ref Point aPoint)
        {
            aPoint.x *= 2; aPoint.y *= 2;
        }

        static void Main()
        {
            Point p = new Point();
            p.x = 5;
            p.y = -8;
            Console.WriteLine("p=({0},{1})", p.x, p.y); // 5,-8
        
            IncorrectMultiplyBy2(p);
            Console.WriteLine("p=({0},{1})", p.x, p.y); // 5,-8
            
            MultiplyBy2(ref p);
            Console.WriteLine("p=({0},{1})", p.x, p.y); // 10,-16
        }
    }
}
