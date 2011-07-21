package org.osflash.automashaller.testdata
{
	/**
	 * @author Jonny
	 */
	public class PersonContructor
	{
		private var _name : String;
		private var _age : uint;
		private var _artists : Array;
		
		public function PersonContructor(name : String, age : uint, artists : Array) 
		{
			_name = name;
			_age = age;
			_artists = artists;
		}

		public function get name() : String
		{
			return _name;
		}

		public function get age() : uint
		{
			return _age;
		}

		public function get artists() : Array
		{
			return _artists;
		}
	}
}
