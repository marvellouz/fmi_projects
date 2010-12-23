using System;

namespace Constructors
{
    class Car
    {
        private string name;

        public Car(string name)
        {
            this.name = name;
        }
    }

    class SportCar : Car
    {
        private int power;

        public SportCar()
            : this(300)
        {
        }

        public SportCar(int power)
            : base("Ferrari")
        {
            this.power = power;
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            //Car car;
            
            //SportCar sportCar = new SportCar();

            //SportCar sportCar = new SportCar(150);

            //Car car = new Car();
        }
    }
}
