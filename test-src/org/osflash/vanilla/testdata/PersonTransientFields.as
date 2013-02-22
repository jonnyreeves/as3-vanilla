package org.osflash.vanilla.testdata
{
	/**
	 * The fields of this VO map directly to the properties of the source object; all Marshalling is automagik.
	 */
	public class PersonTransientFields
	{
        [Transient]
		public var name : String;
		public var age : uint;
		public var artists : Array;
		public var address : Address;
	}
}
