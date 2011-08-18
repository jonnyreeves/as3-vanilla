package org.osflash.vanilla.reflection
{
	public class ReflectionMap
	{
		private var _ctor : Ctor;
		private var _fields : Vector.<Field>;
		private var _methods : Vector.<Method>;
		
		/**
		 * Describes a Classes fields, methods and constructor properties and any metadata that those injection
		 * points may contain.  This information will then be used by Vanilla to inject data into a new instance of 
		 * the object being described.
		 */
		public function ReflectionMap(fields : Vector.<Field>, methods : Vector.<Method>, ctor : Ctor = null) 
		{
			_fields = fields;
			_methods = methods;
			_ctor = ctor;
		}
		
		/**
		 * Metadata and arguments for this classes' Constructor.
		 */
		public function get ctor() : Ctor
		{
			return _ctor;
		}

		/**
		 * A description of the fields that this class exposes.
		 */
		public function get fields() : Vector.<Field>
		{
			return _fields;
		}

		/**
		 * A description of the methods that this class exposes.
		 */
		public function get methods() : Vector.<Method>
		{
			return _methods;
		}
	}
}
