package org.osflash.vanilla.reflection
{
	/**
	 * @author Jonny
	 */
	public class AnnotationError extends Error
	{
		public static const MULTIPLE_ANNOTATIONS : uint = 160000;
		
		public function AnnotationError(message : String, id : uint)
		{
			super(message, id);
		}
	}
}
