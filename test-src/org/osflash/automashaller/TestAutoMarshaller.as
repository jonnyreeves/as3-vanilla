package org.osflash.automashaller
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.osflash.automashaller.testdata.PersonConstructorMetadata;
	import org.osflash.automashaller.testdata.PersonImplicitFields;
	import org.osflash.automashaller.testdata.PersonMutlipleArgumentSetterMetadata;
	import org.osflash.automashaller.testdata.PersonPublicFields;
	import org.osflash.automashaller.testdata.PersonSetterMetadata;
	
	/**
	 * @author Jonny
	 */
	public class TestAutoMarshaller
	{
		/**
		 * Plain old AS3 Object which we want to Marhsall into a strong type.
		 */
		public static const SOURCE : Object = {
			name: "jonny",
			age: 28,
			artists: [ "mew", "tool" ]
		};
			
		private var _marshaller : AutoMarshaller;

		[Before]
		public function setup() : void
		{
			_marshaller = new AutoMarshaller();
		}
		
		[Test]
		public function withPublicFields() : void
		{
			const result : PersonPublicFields = _marshaller.marshall(SOURCE, PersonPublicFields);
			assertEquals(SOURCE["name"], result.name);
			assertEquals(SOURCE["age"], result.age);
			assertEquals(SOURCE["artists"], result.artists);
		}
		
		[Test]
		public function withImplicitFields() : void
		{
			const result : PersonImplicitFields = _marshaller.marshall(SOURCE, PersonImplicitFields);
			assertEquals(SOURCE["name"], result.name);
			assertEquals(SOURCE["age"], result.age);
			assertEquals(SOURCE["artists"], result.artists);
		}
		
		
		[Test (description="Marshalling doesn't require all fields in the TargetType to be present in the source object")]
		public function missingFieldsUsingFieldInection() : void
		{
			const source : Object = { name: "dave" };
			const result : PersonPublicFields = _marshaller.marshall(source, PersonPublicFields);
			assertEquals(source["name"], result.name);
			assertEquals(0, result.age);
			assertEquals(null, result.artists);
		}
		
		[Test (description="Marshalling doesn't require all fields in the TargetType to be present in the source object")]
		public function missingFieldsUsingMutatorInection() : void
		{
			const source : Object = { name: "dave" };
			const result : PersonSetterMetadata = _marshaller.marshall(source, PersonSetterMetadata);
			assertEquals(source["name"], result.getName());
			assertEquals(0, result.getAge());
			assertEquals(null, result.getArtists());
		}		
		
		[Test (description="If the values dont exist in the source object, the AVM will either use the default value (if defined) or assign the default empty value for the method param's Type")]
		public function missingFieldsUsingMultipleArgumentSetter() : void
		{
			const source : Object = { name: "dave" };
			const result : PersonMutlipleArgumentSetterMetadata = _marshaller.marshall(source, PersonMutlipleArgumentSetterMetadata);
			assertEquals(source["name"], result.getName());
			assertEquals(0, result.getAge());
			assertEquals(null, result.getArtists());
		}	
		
		[Test (description="Marshalling will ignore any extra fields present in the source object that don't exist in the TargetType")]
		public function withAdditionalFieldsInSource() : void
		{
			const source : Object = { name: "bob", age: 27, artists: [ "nin", "qotsa" ], gender: "m" };
			const result : PersonPublicFields = _marshaller.marshall(source, PersonPublicFields);
			assertEquals(source["name"], result.name);
			assertEquals(source["age"], result.age);
			assertEquals(source["artists"], result.artists);
		}		

		[Test]		
		public function mismatchedDataType() : void
		{
			var errorThrown : Boolean;
			try {
				const source : Object = { name: "Jonny", age: "27" };
				_marshaller.marshall(source, PersonPublicFields);
			}
			catch (e : MarshallingError) {
				errorThrown = true;
				assertEquals(MarshallingError.TYPE_MISMATCH, e.errorID);
			}
			assertTrue(errorThrown);
		}
		
		[Test]
		public function missingRequiredFieldDefinedByConstructorInjection() : void
		{
			var errorThrown : Boolean;
			try {
				const source : Object = { name: "Jonny" };
				_marshaller.marshall(source, PersonConstructorMetadata);
			}
			catch (e : MarshallingError) {
				errorThrown = true;
				assertEquals(MarshallingError.MISSING_REQUIRED_FIELD, e.errorID);
			}
			assertTrue(errorThrown);
		}
	
		
		[Test]
		public function withMetadataDefinedConstructorArguments() : void
		{
			const result : PersonConstructorMetadata = _marshaller.marshall(SOURCE, PersonConstructorMetadata);
			assertEquals(SOURCE["name"], result.name);
			assertEquals(SOURCE["age"], result.age);
			assertEquals(SOURCE["artists"], result.artists);
		}		
		
		
		[Test]
		public function withMetadataDefinedSetters() : void
		{
			const result : PersonSetterMetadata = _marshaller.marshall(SOURCE, PersonSetterMetadata);
			assertEquals(SOURCE["name"], result.getName());
			assertEquals(SOURCE["age"], result.getAge());
			assertEquals(SOURCE["artists"], result.getArtists());
		}
		
		[Test]
		public function withMetadataDefinedMultipleArgumentSetter() : void
		{
			const result : PersonMutlipleArgumentSetterMetadata = _marshaller.marshall(SOURCE, PersonMutlipleArgumentSetterMetadata);
			assertEquals(SOURCE["name"], result.getName());
			assertEquals(SOURCE["age"], result.getAge());
			assertEquals(SOURCE["artists"], result.getArtists());
		}
		

	}
}





