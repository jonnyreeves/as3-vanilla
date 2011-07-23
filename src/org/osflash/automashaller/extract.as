package org.osflash.automashaller
{
	public function extract(source : Object, targetType : Class) : *
	{
		return AUTO_MARSHALLER_INSTANCE.extract(source, targetType);
	}
	
	
}
