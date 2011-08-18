package org.osflash.vanilla.reflection
{
	internal class MetadataProvider
	{
		private static const EMPTY : Vector.<MetadataArgument> = new Vector.<MetadataArgument>(0, true);
		
		protected const _metadataArgumentsByTagName : Object = {};

		public function MetadataProvider(metadataTags : Vector.<MetadataTag>) 
		{
			if (metadataTags) {
				populateMap(metadataTags);
			}
		}

		private function populateMap(tags : Vector.<MetadataTag>) : void
		{
			const numTags : uint = tags.length;
			for (var i : uint = 0; i < numTags; i++) {
				if (_metadataArgumentsByTagName[tags[i].tagName] !== undefined) {
					throw new AnnotationError("Vanilla does not support annotating mutliple metadata tags on a given field or method.  Found more than on occurance of " + tags[i], AnnotationError.MULTIPLE_ANNOTATIONS);
				}
				
				_metadataArgumentsByTagName[tags[i].tagName] = tags[i].arguments;
			}
		}
		
		/**
		 * Retrieves the MetadataArguments for the supplied tagName.  If there is no MetadataTag that matches the
		 * supplied name then an empty list will be returned.  Note that Vanilla does not support annotating
		 * more than one MetadataTag on a given method or field.
		 */
		public function getMetadataArguments(tagName : String) : Vector.<MetadataArgument> 
		{
			if (_metadataArgumentsByTagName[tagName]) {
				return _metadataArgumentsByTagName[tagName];
			}
			return EMPTY;
		}		
	}
}
