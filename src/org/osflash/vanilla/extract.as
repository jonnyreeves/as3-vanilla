package org.osflash.vanilla
{
	/**
	 * Attempts to extract properties from the supplied source object into an instance of the supplied targetType.
	 * 
	 * @param source		Object which contains properties that you wish to transfer to a new instance of the 
	 * 						supplied targetType Class.
	 * @param targetType	The target Class of which an instance will be returned.
	 * @return				An instance of the supplied targetType containing all the properties extracted from
	 * 						the supplied source object.
	 */
	public function extract(source : Object, targetType : Class) : *
	{
		return VANILLA_INSTANCE.extract(source, targetType);
	}
}
