using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SomethingExceptional
{
    public class TypeCException : Exception
    {
    }
    public class TypeBException : TypeCException
    {
    }
    public class TypeAException : TypeBException
    {
    }

    public class ExceptionHierarhies
    {

        public static void ExceptionHierarchyExample()
        {
            try
            {
                // Some code that could throw an exception.
                throw new TypeCException();
                //throw new TypeBException();
                //throw new TypeAException();
            }
            catch (TypeAException e)
            {
                // Code to do any processing needed.
                // Rethrow the exception

                //throw;
            }
            // For demo purposes
            catch (TypeBException e)
            {
                // Code to do any processing needed.

                // Wrap the current exception in a more relevant
                // outer exception and rethrow the new exception.
                throw new TypeCException();
            }
            catch (Exception ex)
            {
                // Code to do any processing needed.
            }
            finally
            {
                // Code that gets executed regardless of whether
                // an exception was thrown.
                Console.WriteLine("Finally block executed.");
            }
        }
    }
}
