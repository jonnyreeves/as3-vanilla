package org.osflash.vanilla.testdata
{
	[Marshall(field="name", field="address")]
	public class PersonWithAddressConstructor
	{
		private var _name : String;
		private var _address : Address;
		
		public function PersonWithAddressConstructor(name : String, address : Address) {
			_name = name;
			_address = address;
		}

		public function get name() : String {
			return _name;
		}

		public function get address() : Address {
			return _address;
		}
	}
}
