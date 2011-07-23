package org.osflash.automashaller
{
	import org.as3commons.lang.ClassUtils;
	import org.as3commons.reflect.Accessor;
	import org.as3commons.reflect.AccessorAccess;
	import org.as3commons.reflect.Field;
	import org.as3commons.reflect.Metadata;
	import org.as3commons.reflect.MetadataArgument;
	import org.as3commons.reflect.Method;
	import org.as3commons.reflect.Parameter;
	import org.as3commons.reflect.Type;
	import org.as3commons.reflect.Variable;
	
	/**
	 * @author Jonny
	 */
	public class AutoMarshaller
	{
		private static const METADATA_TAG : String = "Marshall";
		private static const METADATA_FIELD_KEY : String = "field";
		
		public function AutoMarshaller() 
		{
		}
		
		public function extract(source : Object, targetType : Class) : *
		{
			// Construct an InjectionMap which tells us how to inject fields from the source object into 
			// the Target class.
			const injectionMap : InjectionMap = new InjectionMap();
			addReflectedRules(injectionMap, targetType, Type.forClass(targetType));
			
			trace(injectionMap);

			const target : * = instantiate(targetType, fetchConstructorArgs(source, injectionMap.getConstructorFields()));
			injectFields(source, target, injectionMap);
			injectMethods(source, target, injectionMap);
			
			return target;
		}



		private function fetchConstructorArgs(source : Object, constructorFields : Array) : Array
		{
			const result : Array = [];
			for (var i : uint = 0; i < constructorFields.length; i++) 
			{
				result.push(extractValue(source, constructorFields[i]));
			}
			return result;
		}

		private function injectFields(source : Object, target : *, injectionMap : InjectionMap) : void
		{
			for each (var injectionDetail : InjectionDetail in injectionMap.getFields())
			{
				target[injectionDetail.name] = extractValue(source, injectionDetail);
			}
			
		}
		
		private function injectMethods(source : Object, target : *, injectionMap : InjectionMap) : void
		{
			const methodNames : Array = injectionMap.getMethodsNames();
			for each (var methodName : String in methodNames)
			{
				const values : Array = [];
				for each (var injectionDetail : InjectionDetail in injectionMap.getMethod(methodName))
				{
					values.push(extractValue(source, injectionDetail));
				}
				
				trace("Applying values: " + values + " to method: " + methodName);
				(target[methodName] as Function).apply(null, values);
			}
		}

		private function extractValue(source : Object, injectionDetail : InjectionDetail) : *
		{
			const value : * = source[injectionDetail.name];
			
			// Is this a required injection?
			if (injectionDetail.isRequired && value === undefined) {
				throw new MarshallingError("Required value " + injectionDetail + " does not exist in the source object.", MarshallingError.MISSING_REQUIRED_FIELD);
			}
				
			// If we have a value then perform a typecheck.
			if (value && !(value is injectionDetail.type)) {
				throw new MarshallingError("Could not coerce `" + injectionDetail.name + "` (value: " + value + " <" + Type.forInstance(value).clazz + "]>) from source object to " + injectionDetail, MarshallingError.TYPE_MISMATCH);
			}
			return value;
		}
		

		private function instantiate(targetType : Class, ctorArgs : Array) : *
		{
			return ClassUtils.newInstance(targetType, ctorArgs);
		}

		private function addReflectedRules(injectionMap : InjectionMap, targetType : Class, reflectionMap : Type) : void
		{
			addReflectedConstructorRules(injectionMap, reflectionMap);
			addReflectedFieldRules(injectionMap, reflectionMap.fields);
			addReflectedSetterRules(injectionMap, reflectionMap.methods);
		}

		private function addReflectedConstructorRules(injectionMap : InjectionMap, reflectionMap : Type) : void
		{
			const clazzMarshallingMetadata : Array = reflectionMap.getMetadata(METADATA_TAG);
			if (!clazzMarshallingMetadata) {
				return;
			}
			
			const marshallingMetadata : Metadata = clazzMarshallingMetadata[0];
			const numArgs : uint = marshallingMetadata.arguments.length;
			
			for (var i : uint = 0; i < numArgs; i++) {
				var argument : MetadataArgument = marshallingMetadata.arguments[i];
				if (argument.key == METADATA_FIELD_KEY) {
					const param : Parameter = reflectionMap.constructor.parameters[i];
					injectionMap.addConstructorField(new InjectionDetail(argument.value, param.type.clazz, true));
				}
			}
		}

		private function addReflectedFieldRules(injectionMap : InjectionMap, fields : Array) : void
		{
			for each (var field : Field in fields) {
				if (canAccess(field)) {
					injectionMap.addField(new InjectionDetail(field.name, field.type.clazz, false));
				}
			}
		}

		private function addReflectedSetterRules(injectionMap : InjectionMap, methods : Array) : void
		{
			for each (var method : Method in methods) {

				const methodMarshallingMetadata : Array = method.getMetadata(METADATA_TAG);
				if (methodMarshallingMetadata == null) {
					continue;
				}
				
				const metadata : Metadata = methodMarshallingMetadata[0];
				const numArgs : uint = metadata.arguments.length;
				
				for (var i : uint = 0; i < numArgs; i++) {
					var argument : MetadataArgument = metadata.arguments[i];
					if (argument.key == METADATA_FIELD_KEY) {
						const param : Parameter = method.parameters[i];
						injectionMap.addMethod(method.name, new InjectionDetail(argument.value, param.type.clazz, false));
					}
				}
			}
		}		
		

		private function canAccess(field : Field) : Boolean
		{
			if (field is Variable) {
				return true;
			}
			else if (field is Accessor) {
				const accessor : Accessor = field as Accessor;
				return accessor.access == AccessorAccess.READ_WRITE || accessor.access == AccessorAccess.WRITE_ONLY;
			}
			return false;
		}
	}
}
