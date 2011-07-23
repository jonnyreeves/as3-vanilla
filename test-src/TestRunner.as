package
{
	import org.osflash.automashaller.TestCoerceToVector;
	import org.osflash.automashaller.outside.TestExtractMethod;
	import flash.events.Event;
	import flash.display.Stage;
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	import org.fluint.uiImpersonation.VisualTestEnvironmentBuilder;
	import org.osflash.automashaller.TestAutoMarshaller;

	import flash.display.Sprite;
	
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

			//Instantiate the core.
			core = new FlexUnitCore();
			
			//Add any listeners. In this case, the TraceListener has been added to display results.
			core.addListener(new TraceListener());
			
			core.run([
				TestAutoMarshaller,
				TestExtractMethod,
				TestCoerceToVector
			]);			
		}
	}
}
