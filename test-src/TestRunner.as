package
{
	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;
	import org.osflash.vanilla.TestCoerceToVector;
	import org.osflash.vanilla.TestVanilla;
	import org.osflash.vanilla.outside.TestExtractMethod;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class TestRunner extends Sprite 
	{
		public static var STAGE : Stage;
		
		private var core : FlexUnitCore;

		public function TestRunner() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event : Event) : void
		{
			STAGE = stage;

			core = new FlexUnitCore();
			core.addListener(new TraceListener());
			core.addListener(new CIListener());
			
			core.run([
				TestVanilla,
				TestExtractMethod,
				TestCoerceToVector
			]);			
		}
	}
}
