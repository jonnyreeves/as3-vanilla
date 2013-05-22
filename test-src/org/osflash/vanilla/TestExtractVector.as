package org.osflash.vanilla
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.osflash.vanilla.testdata.Address;
	import org.osflash.vanilla.testdata.NumberVectorList;
	import org.osflash.vanilla.testdata.NestedNumberVectorList;
	import org.osflash.vanilla.testdata.NestedComplexVectorList;
	import org.osflash.vanilla.testdata.PersonWithMultipleAddressesVectorField;
	import org.osflash.vanilla.testdata.StringVectorList;

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

		[Test]
		public function nested_numbers() : void
		{
			const source : Object = {
				numbers: [
					[1, 2],
					[4, 5],
					[7, 8, 9]
				]
			};

			const result : NestedNumberVectorList = extract(source, NestedNumberVectorList);
			assertEquals(3, result.numbers.length);

			assertEquals(1, result.numbers[0][0]);
			assertEquals(2, result.numbers[0][1]);
			assertEquals(4, result.numbers[1][0]);
			assertEquals(5, result.numbers[1][1]);
			assertEquals(7, result.numbers[2][0]);
			assertEquals(8, result.numbers[2][1]);
			assertEquals(9, result.numbers[2][2]);
		}

		[Test]
		public function nested_complex() : void
		{
			const source : Object = {
				people: [
					[
						{
							name: "jonny",
							age: 28,
							artists: [ "mew", "tool" ]
						},
						{
							name: "mayakwd",
							age: 26,
							address: {
								adress1: "Somewhere",
								city: "Tomsk"
							}
						}
					]
				]
			};

			const result: NestedComplexVectorList = extract(source, NestedComplexVectorList);

			assertEquals("jonny", result.people[0][0].name);
			assertEquals("Tomsk", result.people[0][1].address.city);

		}
	}
}
