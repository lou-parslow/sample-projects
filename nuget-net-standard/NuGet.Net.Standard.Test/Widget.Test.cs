using NUnit.Framework;

namespace NuGet.Net.Standard
{
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