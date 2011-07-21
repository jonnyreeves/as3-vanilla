package org.osflash.automashaller
{
	import org.osflash.automashaller.mappingrules.MappingRule;
	import org.as3commons.reflect.Method;
	import org.osflash.automashaller.mappingrules.SetterMappingRule;
	import org.as3commons.reflect.MetadataContainer;
	import org.as3commons.reflect.Metadata;
	import org.as3commons.reflect.Type;
	import org.as3commons.lang.ClassUtils;
	
	/**
	 * @author Jonny
	 */
	public class AutoMarshaller
	{
		public static function marshall(source : Object, targetClazz : Class, mappingRules : MappingRules = null) : *
		{
			mappingRules ||= MappingRules.AUTO;
			
			const constructorArgs : Array = fetchContstructorArgs(mappingRules.constructorFields, source);
			const instance : Object = ClassUtils.newInstance(targetClazz, constructorArgs);
			
			const remainingFields : Array = fetchRemainingFieldNames(mappingRules.constructorFields, source);
			const numRemainingFields : uint = remainingFields.length;
			
			const marshallingMetadataMap : Object = fetchMetdataMarshallingRulesMap(targetClazz);
			
			for (var i : uint = 0; i < numRemainingFields; i++)
			{
				const fieldName : String = remainingFields[i];
				
				if (marshallingMetadataMap[fieldName]) {
					(marshallingMetadataMap[fieldName] as MappingRule).apply(fieldName, source, instance);
				}
				else {
					mappingRules.getRule(fieldName).apply(fieldName, source, instance);
				}
			}
			
			return instance;
		}

		private static function fetchMetdataMarshallingRulesMap(targetClazz : Class) : Object
		{
			const result : Object = {};
			const containers : Array = Type.forClass(targetClazz).getMetadataContainers("Marshall");
			
			if (containers == null) {
				return result;
			}
			
			const numContainers : uint = containers.length;

			for (var i : uint = 0; i < numContainers; i++)
			{
				const container : MetadataContainer = containers[i];
				if (container is Method) 
				{
					const fieldName : String = extractMappingMetadataFieldNameFromMethod(container as Method);
					result[fieldName] = new SetterMappingRule((container as Method).name);
				}
			}

			return result;
		}

		private static function extractMappingMetadataFieldNameFromMethod(method : Method) : String
		{
			const numMetadata : uint = method.metadata.length;
			for (var i : uint = 0; i < numMetadata; i++) 
			{
				const metadata : Metadata = method.metadata[i];
				if (metadata.name == "Marshall" && metadata.getArgument("field")) {
					return metadata.getArgument("field").value;
				}
			}
			return null;
		}

		private static function fetchRemainingFieldNames(constructorFields : Array, source : Object) : Array
		{
			const constructorFieldSet : Object = {};
			const result : Array = [];
			const numConstructorFields : uint = constructorFields.length;
			
			// Array => Set for lookup.
			for (var i : uint = 0; i < numConstructorFields; i++) {
				constructorFieldSet[constructorFields[i]] = true;
			}
			
			var j : uint = 0;
			for (var fieldName : String in source) {
				if (constructorFieldSet[fieldName] === undefined) {
					result[j] = fieldName;
					j++;
				}
			}
			
			return result;
		}

		private static function fetchContstructorArgs(fieldNames : Array, source : Object) : Array
		{
			const result : Array = [];
			const numFields : uint = fieldNames.length;
			
			for (var i : uint = 0; i < numFields; i++)
			{
				const fieldName : String = fieldNames[i];
				if (fieldName in source) {
					result[i] = source[fieldName];
				}
			}
			
			return result;
		}

	}
}
