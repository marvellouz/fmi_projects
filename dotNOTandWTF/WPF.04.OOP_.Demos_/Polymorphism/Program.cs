using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Polymorphism
{
    public abstract class BaseVehicle
    {
        public abstract void ComfortDescription();
    }

    public class Jeep : BaseVehicle
    {
        public override void ComfortDescription()
        {
            Console.WriteLine("Driving is safe");
        }
    }

    public class SportsCar : BaseVehicle
    {
        public override void ComfortDescription()
        {
            Console.WriteLine("I can cause backache");
        }
    }

    public class Plane : BaseVehicle
    {
        public override void ComfortDescription()
        {
            Console.WriteLine("Don't compalin, you choose to use low costs");
        }
    }

    class Program
    {

        public static void DrivingComfort(Plane baseVehicle)
        {
            baseVehicle.ComfortDescription();
        }

        //public static void DrivingComfort(BaseVehicle baseVehicle)
        //{
        //    if (baseVehicle is Jeep)
        //    {
        //        Console.WriteLine("Driving is safe");
        //    }
        //    else if (baseVehicle is SportsCar)
        //    {
        //        Console.WriteLine("I can cause backache");
        //    }
        //    else if (baseVehicle is Plane)
        //    {
        //        baseVehicle.ComfortDescription();

        //    }
        //}

        static void Main(string[] args)
        {
            Plane baseVehicle = new Plane();
            DrivingComfort(baseVehicle);
        }
    }
}
