package org.osflash.vanilla.reflection
{
	public class Ctor extends MetadataProvider
	{
		public static const EMPTY : Ctor = new Ctor(new Vector.<Parameter>(0, true), null);
		
		private var _parameters : Vector.<Parameter>;

		/**
		 * Describes a Class' Constructor.
		 */
		public function Ctor(parameters : Vector.<Parameter>, metadataTags : Vector.<MetadataTag>) 
		{
			super(metadataTags);
			_parameters = parameters;
		}

		/**
		 *  An ordered list of parameters that this constructor expects.
		 */
		public function get parameters() : Vector.<Parameter>
		{
			return _parameters;
		}
	}
}
