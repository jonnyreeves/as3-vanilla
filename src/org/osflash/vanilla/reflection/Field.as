package org.osflash.vanilla.reflection
{
	public class Field extends Parameter
	{
		private var _name : String;
		private var _metadata : MetadataProvider;

		public function Field(name : String, type : Class, metadataTags : Vector.<MetadataTag>, vectorType : Class = null)
		{
			super(type, vectorType);
			_name = name;
			_metadata = new MetadataProvider(metadataTags);
		}
		
		public function getMetadataArguments(tagName : String) : Vector.<MetadataArgument> 
		{
			return _metadata.getMetadataArguments(tagName);
		}
		
		public function get name() : String 
		{
			return _name; 
		}
		
		public function toString() : String
		{
			return name + ":" + type;
		}
	}
}