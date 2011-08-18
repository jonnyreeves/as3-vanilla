package org.osflash.vanilla.reflection
{
	public class MetadataArgument
	{
		private var _key : String;
		private var _value : String;

		/**
		 * Describes a single argument in a MetadataTag.
		 */
		public function MetadataArgument(key : String, value : String)
		{
			_key = key;
			_value = value;
		}

		/**
		 * This arguments key, for example in '[Marshall (field="foo")]' the `key` is 'field'.
		 */
		public function get key() : String
		{
			return _key;
		}

		/**
		 * This arguments value, for example in '[Marshall (field="foo")]' the `value` is 'foo'.
		 */
		public function get value() : String
		{
			return _value;
		}
		
		public function toString() : String
		{
			return key + "='" + value + "'";
		}		
	}
}
