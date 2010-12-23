using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Task1
{
    public class Expression
    {
        public string expression;
        
        public Expression()
        {
            this.expression = "";
        }
        
        public Expression(string expression)
        {
            this.expression = expression;
        }

        public double Eval()
        {
            this.expression = this.expression.Replace(".", ",");
            
            string[] plus = this.expression.Split('+');
            string[] minus = this.expression.Split('-');
            string[] mul = this.expression.Split('*');
            string[] div = this.expression.Split('/');


            if (minus.Length > 1)
            {
                if (minus.Length == 2 && (plus.Length > 1 || mul.Length > 1 || div.Length > 1))
                {
                }

                else if (minus[0] == "" && minus.Length > 1)
                {
                    return  0 - double.Parse(minus[1]) - double.Parse(minus[2]);
                   
                }
                else
                {
                    return minus[0] == "" ? 0 - double.Parse(minus[1]) : double.Parse(minus[0]) - double.Parse(minus[1]);
                    
                }
            }

            if (plus.Length > 1)
            {
                return double.Parse(plus[0]) + double.Parse(plus[1]);
            }

            if (mul.Length > 1)
            {
                return double.Parse(mul[0]) * double.Parse(mul[1]);
            }

            if (div.Length > 1)
            {
                return double.Parse(div[0]) / double.Parse(div[1]);
            }

            if (this.expression == "")
            {
                return 0;
            }


                return double.Parse(this.expression);

        }
        
        public double Eval(double x)
        {
            this.expression = this.expression.Replace("X", x.ToString());
            return Eval();
        }
    }
    
    class Program
    {
        static void Main(string[] args)
        {
            //Expression x = new Expression("X+10");
            //Console.WriteLine(x.Eval(-5));
            //Console.ReadLine();
        }
    }
}