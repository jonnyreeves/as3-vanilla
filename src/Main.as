package
{
	import org.osflash.vanilla.Vanilla;

	import flash.display.Sprite;

	/**
	 * @author Jonny
	 */
	public class Main extends Sprite
	{
		public function Main()
		{
			const source : Object = {bar:"Dave"};
			const result : Foo = new Vanilla().extract(source, Foo);

			trace(result.bar);
		}
	}
}


[Marshall (field="bar")]
class Foo
{
	private var _bar : String;
	
	public function Foo(bar : String) {
		_bar = bar;
	}
	
	public function get bar() : String {
		return _bar;
	}
}