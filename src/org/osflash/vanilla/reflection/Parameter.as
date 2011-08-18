package org.osflash.vanilla.reflection
{
	public class Parameter
	{
		private var _type : Class;
		private var _vectorType : Class;

		/**
		 * Describes a parameter (argument).
		 */
		public function Parameter(type : Class, vectorType : Class = null)
		{
			_type = type;
			_vectorType = vectorType;
		}

		/**
		 * The datatype of this parameter, for example, in 'foo : Bar;' the `type` property would be `Bar`
		 */
		public function get type() : Class
		{
			return _type;
		}

		/**
		 * The datatype that a vector carries, for example in 'foo : Vector.<Number>', the `vectorType` property would
		 * be `Number`.  Note that this property will yeild null if the Parameter is not a Vector.
		 */
		public function get vectorType() : Class
		{
			return _vectorType;
		}
	}
}
