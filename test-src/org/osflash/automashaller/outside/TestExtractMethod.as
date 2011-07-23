package org.osflash.automashaller.outside
{
	import org.flexunit.asserts.assertEquals;
	import org.osflash.automashaller.extract;
	/**
	 * @author Jonny
	 */
	public class TestExtractMethod
	{
		[Test]
		public function useConvenienceMethod() : void
		{
			const source : Object = {
				name: "Jonny",
				age: 28
			};
			
			const result : PersonVO = extract(source, PersonVO);
			assertEquals("Jonny", result.name);
			assertEquals(28, result.age);
		}
	}
}

class PersonVO {
	public var name : String;
	public var age : uint;
}