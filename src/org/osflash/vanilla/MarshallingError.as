package org.osflash.vanilla
{
	public class MarshallingError extends Error
	{
		public static const TYPE_MISMATCH : uint = 150000;
		public static const MISSING_REQUIRED_FIELD : uint = 150001;
		
		public function MarshallingError(message : String, id : uint) {
			super(message, id);
		}
	}
}
