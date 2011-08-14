package org.osflash.vanilla
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.osflash.vanilla.testdata.Address;
	import org.osflash.vanilla.testdata.NumberArrayList;
	import org.osflash.vanilla.testdata.PersonWithMultipleAddressesArrayField;
	import org.osflash.vanilla.testdata.StringArrayList;

	/**
	 * @author Jonny
	 */
	public class TestExtractTypedArray
	{
		[Test]
		public function numbers() : void
		{
			const source : Object = {numbers:[21, 44, 1847]};
			const result : NumberArrayList = extract(source, NumberArrayList);

			assertNotNull(result.numbers);
			assertEquals(3, result.numbers.length);
			
			assertEquals(21, result.numbers[0]);
			assertEquals(44, result.numbers[1]);
			assertEquals(1847, result.numbers[2]);
		}
		
		[Test]
		public function strings() : void
		{
			const source : Object = {strings:["hello", "world"]};
			const result : StringArrayList = extract(source, StringArrayList);
			
			assertNotNull(result.getStrings());
			assertEquals(2, result.getStrings().length);
			
			assertEquals("hello", result.getStrings()[0]);
			assertEquals("world", result.getStrings()[1]); 
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
			
			const result : PersonWithMultipleAddressesArrayField = extract(source, PersonWithMultipleAddressesArrayField);
			assertNotNull(result.addresses);
			assertEquals(2, result.addresses.length);
			assertTrue(result.addresses[0] is Address);
			assertEquals(source["addresses"][0]["address1"], (result.addresses[0] as Address).address1);
			assertEquals(source["addresses"][0]["city"], (result.addresses[0] as Address).city);
			assertEquals(source["addresses"][1]["address1"], (result.addresses[1] as Address).address1);
			assertEquals(source["addresses"][1]["city"], (result.addresses[1] as Address).city);
		}
	}
}
