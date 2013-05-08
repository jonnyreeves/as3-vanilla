package org.osflash.vanilla {
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.osflash.vanilla.testdata.ComplexVectorList;
	/**
	 * @author Ilya Malanin (flashdeveloper[at]pastila.org)
	 */
	public class TestExtractComplexVector 
	{
		[Test]
		public function complex() : void {
			const source : Object = {
				numbers: [
					[1,2,3], 
					[4,5,6], 
					[7,8,9]
				],
				persons: [
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
			const result : ComplexVectorList = extract(source, ComplexVectorList);
			
			assertNotNull(result.numbers);
			assertNotNull(result.persons);
			
			assertEquals(3, result.numbers.length);
			assertEquals(3, result.numbers[0].length);
			
			assertEquals("jonny", result.persons[0][0].name);
			assertEquals("Tomsk", result.persons[0][1].address.city);
		}
	}
}
