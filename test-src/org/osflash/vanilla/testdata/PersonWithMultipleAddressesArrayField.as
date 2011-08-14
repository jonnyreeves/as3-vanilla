package org.osflash.vanilla.testdata
{
	/**
	 * @author Jonny
	 */
	public class PersonWithMultipleAddressesArrayField
	{
		public var name : String;
		
		[Marshall (type="org.osflash.vanilla.testdata.Address")]
		public var addresses : Array;
	}
}
