package org.osflash.automashaller.mappingrules
{
	/**
	 * @author Jonny
	 */
	public interface MappingRule
	{
		function apply(fieldName : String, source : Object, instance : Object) : void
	}
}
