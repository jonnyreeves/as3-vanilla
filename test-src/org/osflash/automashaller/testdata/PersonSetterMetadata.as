package org.osflash.automashaller.testdata
{
	public class PersonExplicitFields 
	{
		private var _name : String;
		private var _age : uint;
		private var _artists : Array;
		
		public function setName(value : String) : void { _name = value; }
		public function getName() : String { return _name; }
		
		public function setAge(value : uint) : void { _age = value; }
		public function getAge() : uint { return _age; }
		
		public function setArtists(value : Array) : void { _artists = value; }
		public function getArtists() : Array { return _artists; }
		
	}
}
