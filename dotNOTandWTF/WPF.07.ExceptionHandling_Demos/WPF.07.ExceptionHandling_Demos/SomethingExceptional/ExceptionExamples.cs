using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace SomethingExceptional
{
    public static class ExceptionExamples
    {
        #region Code from Slides

        public static void SimpleCatch()
        {
            try
            {
                int[] data = new int[10];
                data[12] = 17;

                //More code ...
            }
            catch(IndexOutOfRangeException ex)
            {
                Console.WriteLine("Error has occured" + ex.Message);
            }
        }

        // If you use catch all construction you will catch any exception
        public static void Catch_All()
        {
            int[] numer = { 4, 8, 16, 32, 64, 128, 256, 512 };
            int[] denom = { 2, 0, 4, 4, 0, 8 };

            for (int i = 0; i < numer.Length; i++)
            {
                try
                {
                    Console.WriteLine(numer[i] + " / " + 
                        denom[i] + " is " + 
                        numer[i] / denom[i]);
                }
                catch
                {
                    Console.WriteLine("Some exception occurred.");
                }
            }
        }

        public static void Exceptions_with_Finally()
        {
            FileStream f = new FileStream("data.txt", FileMode.Open);
            try
            {
                StreamReader t = new StreamReader(f);
                string line;
                while ((line = t.ReadLine()) != null)
                {
                    int count = Convert.ToInt32(line);
                    line = t.ReadLine();
                    int sum = Convert.ToInt32(line);
                    CalculateAverage(count, sum);
                }
            }
            // Allways will be executed
            finally
            {
                f.Close();
            }

        }

        public static void CalculateAverage(int count, int sum)
        {
            Console.WriteLine("I am calculating...");
        }

        #endregion

        #region Different Exception Types

        public static void DivideByZeroException()
        {
                int b = 0;
                int a = 5 / b;
        }

        public static void Null_ReferenceException()
        {
            string value = null;
            // <-- Causes exception. 
            //This is better: if ((value != null) && (value.Length == 0)) 
            if (value.Length == 0) 
            {
                Console.WriteLine(value); // <-- Never reached
            }
        }

        public static void IndexOutOfRangeException()
        {        
            //
            // This will raise an index out of range exception.
            //
            string example = "cat";
            for (int i = 0; i < 10; i++)
            {
                Console.WriteLine(example[i]);
            }
        }

        public static void IndexOutOfRangeException_Fix1()
        {
            string example = "cat";
            //
            // use try/catch
            //
            try
            {
                for (int i = 0; i < 10; i++)
                {
                    Console.WriteLine(example[i]);
                }
            }
            catch (IndexOutOfRangeException)
            {
                return;
            }

        }
        
        /// <summary>
        /// Better approach.Never use try-catch if you can avoid it. 
        /// </summary>
        public static void IndexOutOfRangeException_Fix2()
        {
            string example = "Proba";
            foreach (char c in example)
            {
                Console.WriteLine(c);
            }
        }

        public static void ArgumentException(string[] args)
        {
            // Проверка дали са подадени аргументи
            if (args.Length == 0)
            {
                throw new ArgumentException("Parameter is required.");
            }
            Console.WriteLine("{0} argument(s) provided", args.Length);
        }

        /// <summary>
        /// This nice function will throw InvalidCastException.Never cast without check
        /// </summary>
        public static void InvalidCastException()
        {
                string box = "cat";
                object general = box as object;
                
                // Bad approach:
                int a = (int)general;
        }

        /// <summary>
        /// This code shows you how to avoid the exception and only cast to
        /// int when you are sure the object is an int.
        /// </summary>
        public static void InvalidCastException_Fix1()
        {
            string box = "cat";
            object general = box as object;

            int result = 0;
            if (general is int)
            {
                result = (int)general;
                Console.WriteLine(result);
            }
        }

        /// <summary>
        /// This code shows you how to use int.TryParse(...) method
        /// </summary>
        public static void InvalidCastException_Fix2()
        {
            string box = "cat";
            object general = box as object;

            int result;
            if (int.TryParse(general.ToString(), out result))
            {
                Console.WriteLine(result);
            }
        }

        public static void StackOverflowException(int value)
        {
            Console.WriteLine(value);
            StackOverflowException(++value);
        }
            
        public static void StartStackOverflowException()
        {
            // Begin the infinite recursion.
            try
            {
                StackOverflowException(0);
            }
            catch(StackOverflowException ex)
            {
                Console.WriteLine("Don't kill me !");
            }
        }

        #endregion

        #region Finally

        /// <summary>
        /// Scenario: Exception is propagated but
        ///     1.no catch block is found
        ///     2.only finally
        /// Result:
        ///     1.Exceprion is cought by CLR 
        ///       This results in showing an exception message.
        ///     2.After that the finally block(s) is executed
        /// </summary>
        public static void Finally_No_Catch()
        {
            Console.WriteLine("Finally_No_Catch");
            DivideByZeroExceptionThrower();
        }

        /// <summary>
        /// Scenario: Exception is propagated 
        ///     1.catch block is found in upper method
        ///     2.finally block exist in the exception method
        /// Result:
        ///     The finally block of the exception method is executed
        ///     After that the catch block of the upper method is executed
        /// </summary>
        public static void Finally_In_Exception_Method_Catch_In_Upper_Method()
        {
            try
            {
                Console.WriteLine("Finally_In_Exception_Method_Catch_In_Upper_Method");
                DivideByZeroExceptionThrower();
            }
            catch (DivideByZeroException ex)
            {
                Console.WriteLine("DivideByZeroException is catched by Finally_In_Exception_Method_Catch_In_Upper_Method");
            }
        }

        /// <summary>
        /// Scenario: Exception is propagated 
        ///     1.catch block exist in the exception method
        ///     2.finally block exist in the exception method
        /// Result:
        ///     1.Catch block in the exception method is executed
        ///     2.Finally block in the exception method is executed
        /// </summary>
        public static void Finally_Catch_In_Same_Method()
        {
            try
            {
                Console.WriteLine("Finally_Catch_In_Same_Method");
                ExceptionExamples.DivideByZeroException();

                // Try the below code and the last line will never be executed
                //throw new Exception();
            }
            catch (DivideByZeroException ex)
            {
                Console.WriteLine("DivideByZeroException is catched by Finally_Catch_In_Same_Method");
            }
            finally
            {
                Console.WriteLine("Finally_Catch_In_Same_Method is in its final stage");
            }

            Console.WriteLine("If there is uncatched error I will never be executed");
        }

        public static void DivideByZeroExceptionThrower()
        {
            try
            {
                Console.WriteLine("FinallyExampleHelper was invoked");
                ExceptionExamples.DivideByZeroException();
            }
            finally
            {
                Console.WriteLine("FinallyExampleHelper is in its finally stage");
            }

            Console.WriteLine("If there is an error I will never be executed");
        }
        
        #endregion

        #region Exception Properties

        public static void MultipleCatchBlocks_ExceptionProperties()
        {
            try
            {
                int[] myArray = new int[2];
                Console.WriteLine("Attempting to access an invalid array element");
                myArray[2] = 1;
            }
            catch (DivideByZeroException e)
            {
                Console.WriteLine("Handling a System.DivideByZeroException object");
                Console.WriteLine("Message = " + e.Message);
                Console.WriteLine("StackTrace = " + e.StackTrace);
                Console.WriteLine("Source = " + e.Source);
            }
            catch (IndexOutOfRangeException e)
            {
                Console.WriteLine("Handling a System.IndexOutOfRangeException object");
                Console.WriteLine("Message = " + e.Message);
                Console.WriteLine("StackTrace = " + e.StackTrace);
                Console.WriteLine("Source = " + e.Source);
            }
            catch (Exception e)
            {
                Console.WriteLine("Handling a System.Exception object");
                Console.WriteLine("Message = " + e.Message);
                Console.WriteLine("StackTrace = " + e.StackTrace);
                Console.WriteLine("Source = " + e.Source);
            }
        }

        #endregion
    }
}
