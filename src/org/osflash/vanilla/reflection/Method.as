package org.osflash.vanilla.reflection
{
	public class Method extends MetadataProvider
	{
		private var _name : String;
		private var _parameters : Vector.<Parameter>;

		/**
		 * Describes a visible method which can be used as an injection point.
		 */
		public function Method(name : String, parameters : Vector.<Parameter>, metadataTags : Vector.<MetadataTag>) 
		{
			super(metadataTags);
			_name = name;
			_parameters = parameters;
		}

		/**
		 * The name of the method, for example, in 'setFoo(value : Foo)' the name is 'setFoo'.
		 */
		public function get name() : String
		{
			return _name;
		}

		/**
		 * An ordered list of parameters that this method expects
		 */
		public function get parameters() : Vector.<Parameter>
		{
			return _parameters;
		}
	}
}
