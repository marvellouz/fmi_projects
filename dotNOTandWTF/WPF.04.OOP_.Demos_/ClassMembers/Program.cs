using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ClassMembers
{
    class Car
    {
        public const int NUMBER_OF_WHEELS = 4;
        
        private readonly string model;

        public int power { get; set; }
        
        private static int carCount;
        public static int CarCount
        {
            get { return carCount;  }
            set { carCount = value; }
        }
        
        static Car()
        {
            Console.WriteLine("Static constructor executed.");
            CarCount = 5;
        }

        public Car()
        {
            carCount++; 
            Console.WriteLine("Default constructor executed.");
        }

        public Car(string model, int power)
        {
            carCount++; 
            this.model = model;
            this.power = power;
            Console.WriteLine("Constructor with parameters executed.");
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            Car car1 = new Car();
            Console.WriteLine(Car.CarCount);

            Car car2 = new Car("Ferrari", 300);
            Console.WriteLine(Car.CarCount);
        }
    }
}
