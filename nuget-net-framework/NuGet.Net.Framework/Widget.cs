using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Security.Permissions;
using System.Text;
using System.Threading.Tasks;

namespace NuGet.Net.Framework
{
	public sealed class Widget : ISerializable
	{
		public Widget() { Code = 0; Message = string.Empty; }
		public Widget(int code, string message)
		{
			Code = code;
			Message = message;
		}

		private Widget(SerializationInfo info, StreamingContext context)
		{
			Code = info.GetInt32("code");
			Message = info.GetString("message");
		}

		[SecurityPermission(SecurityAction.Demand, SerializationFormatter = true)]
		public void GetObjectData(SerializationInfo info, StreamingContext context)
		{
			info.AddValue("code", Code);
			info.AddValue("message", Message);
		}

		public int Code { get; }
		public string Message { get; }
	}
}
