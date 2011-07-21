package org.osflash.automashaller.testdata
{
	/**
	 * @author Jonny
	 */
	public class PersonMetadata
	{
		private var _name : String;
		private var _age : uint;
		private var _artists : Array;
		
		[Marshall(field="name")]
		public function setName(value : String) : void { _name = value; }
		public function getName() : String { return _name; }
		
		[Marshall(field="age")]
		public function setAge(value : uint) : void { _age = value; }
		public function getAge() : uint { return _age; }
		
		[Marshall(field="artists")]
		public function setArtists(value : Array) : void { _artists = value; }
		public function getArtists() : Array { return _artists; }
	}
}
