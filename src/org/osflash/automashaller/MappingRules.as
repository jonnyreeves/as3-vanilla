package org.osflash.automashaller
{
	import org.osflash.automashaller.mappingrules.AutoMappingRule;
	import org.osflash.automashaller.mappingrules.MappingRule;

	import flash.utils.Dictionary;
	/**
	 * @author Jonny
	 */
	public class MappingRules
	{
		public static const AUTO : MappingRules = new MappingRules(new Dictionary(), AutoMappingRule.INSTANCE, []);
		
		private var _mappingRules : Dictionary;
		private var _fallbackRule : MappingRule;
		private var _constructorFields : Array;
		
		public function MappingRules(mappingRules : Dictionary, fallbackRule : MappingRule, constructorFields : Array)
		{
			_mappingRules = mappingRules;
			_fallbackRule = fallbackRule;
			_constructorFields = constructorFields;
		}
		
		public function get constructorFields() : Array 
		{
			return _constructorFields;
		}
		
		public function getRule(fieldName : String) : MappingRule
		{
			return _mappingRules[fieldName] || _fallbackRule;
		}
	}
}
