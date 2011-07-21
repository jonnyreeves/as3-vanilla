package org.osflash.automashaller.mappingrules
{
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Parameter;
	import org.as3commons.reflect.Type;

	/**
	 * @author Jonny
	 */
	public class SetterMappingRule implements MappingRule
	{
		private var _setterName : String;
		
		public function SetterMappingRule(setterName : String)
		{
			_setterName = setterName;
		}

		public function apply(fieldName : String, source : Object, instance : Object) : void
		{
			const targetType : Type = Type.forInstance(instance);
			const setter : Method = targetType.getMethod(_setterName);
			
			if (!setter || setter.parameters.length != 1) {
				throw new Error("No Setter in " +  instance + " with the name " + _setterName);
			}
			
			if (source[fieldName] is (setter.parameters[0] as Parameter).type.clazz) {
				instance[_setterName](source[fieldName]);
			}
		}
	}
}
