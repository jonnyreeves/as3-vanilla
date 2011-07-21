package org.osflash.automashaller.mappingrules
{
	import org.as3commons.reflect.Field;
	import org.as3commons.reflect.Type;
	
	/**
	 * @author Jonny
	 */
	public class AutoMappingRule implements MappingRule
	{
		public static const INSTANCE : AutoMappingRule = new AutoMappingRule();
		
		public function apply(fieldName : String, source : Object, instance : Object) : void
		{
			const type : Type = Type.forInstance(instance);
			const field : Field = type.getField(fieldName);
			
			if (field && source[fieldName] is field.type.clazz) {
				instance[field.name] = source[field.name];
			}
		}
	}
}
