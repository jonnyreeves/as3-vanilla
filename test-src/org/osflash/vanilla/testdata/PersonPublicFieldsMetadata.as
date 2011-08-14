package org.osflash.vanilla.testdata
{
	/**
	 * The fields of this VO don't map to the properties of the source object, we defined Marshalling rules in the
	 * Metadata to create the correct mappings.
	 */
	public class PersonPublicFieldsMetadata
	{
		[Marshall (field="myName")]
		public var name : String;
		
		[Marshall (field="myAge")]
		public var age : uint;
	}
}
