package org.osflash.vanilla.reflection
{
	public interface IReflectionMapFactory
	{
		/**
		 * Given the supplied targetType, implemenations of this interface should construct a ReflectionMap 
		 * instance which describes it so that Vanilla can perform injection.
		 * 
		 * @param targetType	The Class Definition that Vanilla needs a ReflectionMap of.
		 */
		function create(targetType : Class) : ReflectionMap;
	}
}
