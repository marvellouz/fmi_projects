using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SomethingExceptional
{
    /// <summary>
    /// Demo contains 4 sections:
    /// 1.Exception Types examples
    /// 2.Exception Propagation examples
    /// 3.Exception Properties Example
    /// 4.Custom Exceptions example
    /// </summary>
    class Program
    {
        static void Main(string[] args)
        {
            //-------------------------------------------------------------
            //--------------------- Start:Exception Types-------------------------
            //-------------------------------------------------------------

            ExceptionExamples.DivideByZeroException();
            //ExceptionExamples.Null_ReferenceException();
            //ExceptionExamples.IndexOutOfRangeException();
            //ExceptionExamples.IndexOutOfRangeException_Fix1();
            //ExceptionExamples.IndexOutOfRangeException_Fix2();
            //ExceptionExamples.ArgumentException(new string[] { });
            //ExceptionExamples.InvalidCastException();
            //ExceptionExamples.InvalidCastException_Fix1();
            //ExceptionExamples.InvalidCastException_Fix2();
            //ExceptionExamples.StartStackOverflowException();
            Console.WriteLine("Everything is perfect");

            //-------------------------------------------------------------------
            //----------------------End:Exception Types-------------------------
            //-------------------------------------------------------------------

            //-------------------------------------------------------------------
            //---------------------Start:Exception Propagation-------------------------
            //-------------------------------------------------------------------
            
            //ExceptionHierarhies.ExceptionHierarchyExample();
            //ExceptionExamples.Finally_No_Catch();
            //ExceptionExamples.Finally_In_Exception_Method_Catch_In_Upper_Method();
            //ExceptionExamples.Finally_Catch_In_Same_Method();
            
            //-------------------------------------------------------------------
            //---------------------End:Exception Propagation-------------------------
            //-------------------------------------------------------------------

            //-------------------------------------------------------------------
            //---------------------Start:Exception Properties-------------------------
            //-------------------------------------------------------------------

           // ExceptionExamples.MultipleCatchBlocks_ExceptionProperties();

            //-------------------------------------------------------------------
            //----------------------End:Exception Properties-------------------------
            //-------------------------------------------------------------------

            //-------------------------------------------------------------------
            //---------------------Start:Custom Exceptions-------------------------
            //-------------------------------------------------------------------

            //CustomExceptionDemoHelper.UseOfCustomExceptions();
            
            //-------------------------------------------------------------------
            //----------------------End:Custom Exceptions-------------------------
            //-------------------------------------------------------------------
        }    
    }
}
