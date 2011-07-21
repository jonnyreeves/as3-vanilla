package org.osflash.automashaller
{
	import org.osflash.automashaller.mappingrules.AutoMappingRule;
	import org.osflash.automashaller.mappingrules.MappingRule;
	import org.osflash.automashaller.mappingrules.SetterMappingRule;
	import flash.utils.Dictionary;
	/**
	 * @author Jonny
	 */
	public class MappingRulesBuilder
	{
		private var _rules : Dictionary = new Dictionary();
		private var _fallbackRule : MappingRule;
		private var _constructorArgs : Array;
		
		public function MappingRulesBuilder(fallbackRule : MappingRule = null) 
		{
			_fallbackRule = fallbackRule || AutoMappingRule.INSTANCE;
		}
		
		public function mapSetter(fieldName : String, setterName : String) : MappingRulesBuilder
		{
			_rules[fieldName] = new SetterMappingRule(setterName);
			return this;
		}
		
		public function withConstructorArgs(...argumentNames : Array) : MappingRulesBuilder
		{
			_constructorArgs = argumentNames;
			return this;
		}
		
		public function build() : MappingRules
		{
			const ctorArgs : Array = _constructorArgs || [];
			return new MappingRules(_rules, _fallbackRule, ctorArgs);
		}
	}
	
}
