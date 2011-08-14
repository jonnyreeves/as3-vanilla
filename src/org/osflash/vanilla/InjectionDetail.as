package org.osflash.vanilla
{
	/**
	 * @author Jonny
	 */
	internal class InjectionDetail
	{
		private var _fieldName : String;
		private var _type : Class;
		private var _required : Boolean;
		private var _arrayTypeHint : Class;
		
		public function InjectionDetail(fieldName : String, type : Class, required : Boolean, arrayTypeHint : Class) {
			_fieldName = fieldName;
			_type = type;
			_required = required;
			_arrayTypeHint = arrayTypeHint;
		}
		
		public function get name() : String {
			return _fieldName;
		}

		public function get type() : Class
		{
			return _type;
		}
		
		public function get isRequired() : Boolean
		{
			return _required;
		}

		public function toString() : String
		{
			return _fieldName + "<" + type + ">";
		}

		public function get arrayTypeHint() : Class
		{
			return _arrayTypeHint;
		}
	}
}
