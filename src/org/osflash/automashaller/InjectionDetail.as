package org.osflash.automashaller
{
	/**
	 * @author Jonny
	 */
	internal class InjectionDetail
	{
		private var _fieldName : String;
		private var _type : Class;
		private var _required : Boolean;
		
		public function InjectionDetail(fieldName : String, type : Class, required : Boolean) {
			_fieldName = fieldName;
			_type = type;
			_required = required;
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
	}
}
