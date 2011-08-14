package org.osflash.vanilla.testdata
{
	/**
	 * Implicit setter can be used without additional mapping rules as long as the setter's name maps to the field 
	 * name in the source object.
	 */
	public class PersonImplicitFields 
	{
		private var _name : String;
		private var _age : uint;
		private var _artists : Array;
	
		public function get name() : String { return _name; }
		public function set name(name : String) : void { _name = name; }
	
		public function get age() : uint { return _age; }
		public function set age(age : uint) : void { _age = age; }
		
		public function get artists() : Array { return _artists; }
		public function set artists(value : Array) : void { _artists = value; }
	}
}
