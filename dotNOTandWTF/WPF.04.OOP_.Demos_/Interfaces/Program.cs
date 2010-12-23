using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Interfaces
{
    interface IVehicle
    {
        void Move();
    }

    //interface IVehicle2
    //{
    //    void Move();
    //}

    public class Car : IVehicle
    {
        public void Move()
        {
            Console.WriteLine("I am moving...");
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            //IVehicle vehicle = new IVehicle();

            Car car = new Car();
            car.Move();

            //IVehicle vehicle = car as IVehicle;
            //if (car != null)
            //{
            //    vehicle.Move();
            //}
        }
    }
}
