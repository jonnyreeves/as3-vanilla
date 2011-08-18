package org.osflash.vanilla.reflection
{
	public class MetadataTag
	{
		private var _tagName : String;
		private var _arguments : Vector.<MetadataArgument>;

		/**
		 * A Metadata tag whcih can contain mutliple arguments, for example: '[Marshall (field="foo")]'.
		 */
		public function MetadataTag(tagName : String, arguments : Vector.<MetadataArgument>) 
		{
			_tagName = tagName;
			_arguments = arguments;
		}

		/**
		 * The name of the Metadata tag, for example, given '[Marshall (field="foo")]', the tagName is 'Marshall'.  
		 * Note that tagNames are case sensitive.
		 */
		public function get tagName() : String
		{
			return _tagName;
		}

		/**
		 * An ordered list of arguments that are defined in this MetadataTag, for example, 
		 * '[Marshall (field="foo", type="Foo")]' there are two arguments defined (field and type).
		 */
		public function get arguments() : Vector.<MetadataArgument>
		{
			return _arguments;
		}
		
		public function toString() : String
		{
			return "[" + _tagName + "(" + _arguments + ")";
		}
	}
}
