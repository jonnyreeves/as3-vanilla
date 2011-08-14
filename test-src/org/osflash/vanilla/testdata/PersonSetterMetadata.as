package org.osflash.vanilla.testdata
{
	/**
	 * This class uses Java style mutators; here we define the marshalling rule above each mutator as Metadata, listing
	 * the filed in the source object to read the value from when invoking the method.
	 */
	public class PersonSetterMetadata 
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
