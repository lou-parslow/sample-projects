using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;
using NuGet.Net.Framework;

namespace Test
{
	[TestFixture]
    public class WidgetTest
    {
		[Test]
		public void Construction()
		{
			var w = new Widget();
			Assert.AreEqual(0, w.Code);
		}
	}
}
