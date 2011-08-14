package org.osflash.vanilla.testdata
{
	/**
	 * This imultable model requires the fields to be set in the constructor, here we define Marshalling Metadata
	 * to define rules to map from the source object into constructor arguments.
	 */
	[Marshall(field="name", field="age", field="artists")]
	public class PersonConstructorMetadata
	{
		private var _name : String;
		private var _age : uint;
		private var _artists : Array;

		public function PersonConstructorMetadata(name : String, age : uint, artists : Array) {
			_name = name;
			_age = age;
			_artists = artists;
		}
		
		public function get name() : String { return _name; }
		public function get age() : uint { return _age; }
		public function get artists() : Array { return _artists; }
	}
}
