using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Task1;

namespace Task1Test
{
    [TestClass]
    public class ExpressionTest
    {
        [TestMethod]
        public void TestMethod1()
        {
            Expression e = new Expression();

            Assert.AreEqual((double)0, e.Eval());
        }
    }
}
