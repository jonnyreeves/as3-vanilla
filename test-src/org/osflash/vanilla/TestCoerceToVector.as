package org.osflash.vanilla
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.osflash.vanilla.testdata.NumberVectorList;
	import org.osflash.vanilla.testdata.StringVectorList;
	/**
	 * @author Jonny
	 */
	public class TestCoerceToVector
	{
		[Test]
		public function strings() : void
		{
			const source : Object = { strings: ["red", "white", "blue"] };
			const result : StringVectorList =  extract(source, StringVectorList);
			
			assertNotNull(result.strings);
			assertEquals(3, result.strings.length);
		}
		
		[Test]
		public function numbers() : void
		{
			const source : Object = { numbers: [22, 18, 10294] };
			const result : NumberVectorList =  extract(source, NumberVectorList);
			
			assertNotNull(result.numbers);
			assertEquals(3, result.numbers.length);
		}
	}
}
