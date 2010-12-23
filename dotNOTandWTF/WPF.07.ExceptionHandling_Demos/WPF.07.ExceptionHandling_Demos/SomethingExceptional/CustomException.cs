using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace SomethingExceptional
{
    //1. Allways implement the mentioned constructors for custom exceptions
    //2. Allways suffixed your custom exception classes with Exception
    //3. Do not create custom exception if you don't have to.
    //4. Check Exception Hierarchy to find out is there exception class that fits your needs.
    public class LoginFailedException : System.Exception    
    {
        public LoginFailedException()
        {
        }

        public LoginFailedException(string message)
            : base(message)
        {
        }

        public LoginFailedException(string message, Exception innerException)
            : base(message, innerException)
        {
        }
    }

    public class CustomExceptionDemoHelper
    {
        public static void UseOfCustomExceptions()
        {
            try
            {
                try
                {
                    string userName = null;
                    //string userName = "test";
                    Login(userName);
                }
                catch (NullReferenceException e)
                {
                    // Wrap the NullReferenceException and throw an LoginFailedException with the new information
                    throw new LoginFailedException("Login process failed. Username is empty.", e);
                }
            }
            catch (LoginFailedException e)
            {
                if (e.InnerException != null)
                {
                    Console.WriteLine(e.Message.ToString());
                    Console.WriteLine(e.InnerException.Message.ToString());
                    Console.WriteLine(e.StackTrace);
                }
                else
                {
                    Console.WriteLine(e.Message.ToString());
                }
            }
        }

        static void Login(string username)
        {
            if (username.Contains("user"))
            {
                Console.WriteLine("You are logged in.");
            }
            else
            {
                Console.WriteLine("You can't log in.");

                // Directly throw an LoginFailedException
                throw new LoginFailedException("Login process failed. Username is not correct.");
            }
        }
    }
}
