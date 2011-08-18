package org.osflash.vanilla.reflection.impl
{
	import org.as3commons.reflect.Variable;
	import org.as3commons.reflect.Accessor;
	import org.osflash.vanilla.reflection.Ctor;
	import org.as3commons.reflect.Parameter;
	import org.osflash.vanilla.reflection.Parameter;
	import org.as3commons.reflect.Method;
	import org.osflash.vanilla.reflection.Method;
	import org.as3commons.reflect.MetadataArgument;
	import org.osflash.vanilla.reflection.MetadataArgument;
	import org.as3commons.reflect.Metadata;
	import org.osflash.vanilla.reflection.MetadataTag;
	import org.as3commons.reflect.Field;
	import org.osflash.vanilla.reflection.Field;
	import org.as3commons.reflect.Type;
	import org.osflash.vanilla.reflection.IReflectionMapFactory;
	import org.osflash.vanilla.reflection.ReflectionMap;

	/**
	 * Provides an implementation of the Vanialla IReflector interface for aS3Commons-reflect.
	 */
	public class AS3CommonsReflectionMapFactory implements IReflectionMapFactory
	{
		public function create(targetType : Class) : ReflectionMap
		{
			const type : Type = Type.forClass(targetType);
			
			const fields : Vector.<org.osflash.vanilla.reflection.Field> = extractFields(type);
			const methods : Vector.<org.osflash.vanilla.reflection.Method> = extractMethods(type);
			const ctor : Ctor = extractCtor(type);
			
			return new ReflectionMap(fields, methods, ctor);
		}

		private function extractFields(type : Type) : Vector.<org.osflash.vanilla.reflection.Field>
		{
			const result : Vector.<org.osflash.vanilla.reflection.Field> = new Vector.<org.osflash.vanilla.reflection.Field>();
			const numFields : uint = type.fields.length;
			
			for (var i : uint = 0; i < numFields; i++) 
			{
				const field : org.as3commons.reflect.Field = type.fields[i];
				if (canAccess(field)) {
					const vectorType : Class = (field.type.parameters) ? field.type.parameters[0] : null;
					const metadataTags : Vector.<MetadataTag> = extractMetadataTags(field.metadata);
					
					result.push(new org.osflash.vanilla.reflection.Field(field.name, field.type.clazz, metadataTags, vectorType));
				}
			}
			
			return result;
		}
		
		private function extractMethods(type : Type) : Vector.<org.osflash.vanilla.reflection.Method>
		{
			const result : Vector.<org.osflash.vanilla.reflection.Method> = new Vector.<org.osflash.vanilla.reflection.Method>();
			const numMethods : uint = type.methods.length;
			
			for (var i : uint = 0; i < numMethods; i++)
			{
				const method : org.as3commons.reflect.Method = type.methods[i];
				
				// If the method has not been annotated then we can skip over it.
				if (method.metadata.length) {
					const metadataTags : Vector.<MetadataTag> = extractMetadataTags(method.metadata);
					const parameters : Vector.<org.osflash.vanilla.reflection.Parameter> = extractParameters(method.parameters);
					result.push(new org.osflash.vanilla.reflection.Method(method.name, parameters, metadataTags));
				}
			}
			
			return result;
		}

		private function extractCtor(type : Type) : Ctor
		{
			// If there's no metadata, we can't marshall anything.
			if (!type.metadata.length) {
				return Ctor.EMPTY;
			}
			
			const metadataTags : Vector.<MetadataTag> = extractMetadataTags(type.metadata);
			const parameters : Vector.<org.osflash.vanilla.reflection.Parameter> = extractParameters(type.constructor.parameters);
			
			return new Ctor(parameters, metadataTags);
		}

		private function extractParameters(as3Parameters : Array) : Vector.<org.osflash.vanilla.reflection.Parameter>
		{
			const result : Vector.<org.osflash.vanilla.reflection.Parameter> = new Vector.<org.osflash.vanilla.reflection.Parameter>();
			const numParams : uint = as3Parameters.length;
			
			for (var i : uint = 0; i < numParams; i++) {
				const as3Param : org.as3commons.reflect.Parameter = as3Parameters[i];
				const vectorType : Class = (as3Param.type.parameters) ? as3Param.type.parameters[0] : null;
				
				result.push(new org.osflash.vanilla.reflection.Parameter(as3Param.type.clazz, vectorType)); 
			}
			
			return result;
		}

		private function extractMetadataTags(metadataTags : Array) : Vector.<MetadataTag>
		{
			const result : Vector.<MetadataTag> = new Vector.<MetadataTag>();
			const numTags : uint = metadataTags.length;
			
			for (var i : uint = 0; i < numTags; i++) {
				const metadataTag : Metadata = metadataTags[i];
				
				// Ignore private Metadata Tags.
				if (metadataTag.name.charAt(0) != "_") {
					const args : Vector.<org.osflash.vanilla.reflection.MetadataArgument> = convertMetadataArgs(metadataTag.arguments);
					result.push(new MetadataTag(metadataTag.name, args));
				}
			}
			
			return result;
		}

		private function convertMetadataArgs(as3Arguments : Array) : Vector.<org.osflash.vanilla.reflection.MetadataArgument>
		{
			const result : Vector.<org.osflash.vanilla.reflection.MetadataArgument> = new Vector.<org.osflash.vanilla.reflection.MetadataArgument>();
			const numArgs : uint = as3Arguments.length;
			
			for (var i : uint = 0; i < numArgs; i++) {
				const as3Argument : org.as3commons.reflect.MetadataArgument = as3Arguments[i];
				result.push(new org.osflash.vanilla.reflection.MetadataArgument(as3Argument.key, as3Argument.value));
			}
			
			return result;
		}
		
		private function canAccess(field : org.as3commons.reflect.Field) : Boolean
		{
			if (field is org.as3commons.reflect.Variable) {
				return true;
			}
			else if (field is Accessor) {
				return (field as Accessor).writeable;
			}
			return false;
		}		
		
	}
}
