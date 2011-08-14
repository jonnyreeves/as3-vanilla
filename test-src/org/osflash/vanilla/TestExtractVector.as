package org.osflash.vanilla
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.osflash.vanilla.testdata.Address;
	import org.osflash.vanilla.testdata.NumberVectorList;
	import org.osflash.vanilla.testdata.PersonWithMultipleAddressesVectorField;
	import org.osflash.vanilla.testdata.StringVectorList;
	
	/**
	 * Test cases which ensure that Vanilla is capable of extracting values to Vectors. 
	 * 
	 * @author Jonny
	 */
	public class TestExtractVector
	{
		[Test]
		public function strings() : void
		{
			const source : Object = { strings: ["red", "white", "blue"] };
			const result : StringVectorList =  extract(source, StringVectorList);
			
			assertNotNull(result.strings);
			assertEquals(3, result.strings.length);
			assertEquals("red", result.strings[0]);
			assertEquals("white", result.strings[1]);
			assertEquals("blue", result.strings[2]);
		}
		
		[Test]
		public function numbers() : void
		{
			const source : Object = { numbers: [22, 18, 10294] };
			const result : NumberVectorList =  extract(source, NumberVectorList);
			
			assertNotNull(result.numbers);
			assertEquals(3, result.numbers.length);
			assertEquals(22, result.numbers[0]);
			assertEquals(18, result.numbers[1]);
			assertEquals(10294, result.numbers[2]);
		}
		
		[Test]
		public function complex_viaField() : void
		{
			const source : Object = {
				name: "Jonny",
				addresses: [
					{
						address1: "Address 1",
						city: "City 1"
					},
					{
						address1: "Address 2",
						city: "City 2"
					}
				]
			};
			
			const result : PersonWithMultipleAddressesVectorField = extract(source, PersonWithMultipleAddressesVectorField);
			assertNotNull(result.addresses);
			assertEquals(2, result.addresses.length);
			assertTrue(result.addresses[0] is Address);
			assertEquals(source["addresses"][0]["address1"], result.addresses[0].address1);
			assertEquals(source["addresses"][0]["city"], result.addresses[0].city);
			assertEquals(source["addresses"][1]["address1"], result.addresses[1].address1);
			assertEquals(source["addresses"][1]["city"], result.addresses[1].city);
		}
	}
}
