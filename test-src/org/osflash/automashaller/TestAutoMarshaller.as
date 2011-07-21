package org.osflash.automashaller
{
	import org.osflash.automashaller.testdata.PersonMetadata;
	import org.osflash.automashaller.testdata.PersonContructor;
	import org.flexunit.asserts.assertEquals;
	import org.osflash.automashaller.testdata.PersonExplicitFields;
	import org.osflash.automashaller.testdata.PersonImplicitFields;
	import org.osflash.automashaller.testdata.PersonPublicFields;
	
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
		
		[Test]
		public function withPublicFields() : void
		{
			const result : PersonPublicFields = AutoMarshaller.marshall(SOURCE, PersonPublicFields);
			assertEquals(SOURCE["name"], result.name);
			assertEquals(SOURCE["age"], result.age);
			assertEquals(SOURCE["artists"], result.artists);
		}
		
		[Test]
		public function withImplicitFields() : void
		{
			const result : PersonImplicitFields = AutoMarshaller.marshall(SOURCE, PersonImplicitFields);
			assertEquals(SOURCE["name"], result.name);
			assertEquals(SOURCE["age"], result.age);
			assertEquals(SOURCE["artists"], result.artists);
		}
		
		[Test]
		public function withExplicitFields() : void
		{
			const mappingRules : MappingRules = new MappingRulesBuilder()
				.mapSetter("name", "setName")
				.mapSetter("age", "setAge")
				.mapSetter("artists", "setArtists")
				.build();
				
			const result : PersonExplicitFields = AutoMarshaller.marshall(SOURCE, PersonExplicitFields, mappingRules);
			assertEquals(SOURCE["name"], result.getName());
			assertEquals(SOURCE["age"], result.getAge());
			assertEquals(SOURCE["artists"], result.getArtists());
		}
		
		[Test]
		public function withConstructorArguments() : void
		{
			const mappingRules : MappingRules = new MappingRulesBuilder()
				.withConstructorArgs("name", "age", "artists")
				.build();
				
			const result : PersonContructor = AutoMarshaller.marshall(SOURCE, PersonContructor, mappingRules);
			assertEquals(SOURCE["name"], result.name);
			assertEquals(SOURCE["age"], result.age);
			assertEquals(SOURCE["artists"], result.artists);
		}
		
		[Test(expects="Error")]
		public function withConstructorArgumentsInTheWrongOrder() : void
		{
			const mappingRules : MappingRules = new MappingRulesBuilder()
				.withConstructorArgs("artists", "name", "age")
				.build();
				
			AutoMarshaller.marshall(SOURCE, PersonContructor, mappingRules);
		}
		
		[Test]
		public function withMetadata() : void
		{
			const result : PersonMetadata = AutoMarshaller.marshall(SOURCE, PersonMetadata);
			assertEquals(SOURCE["name"], result.getName());
			assertEquals(SOURCE["age"], result.getAge());
			assertEquals(SOURCE["artists"], result.getArtists());		
		}
	}
}





