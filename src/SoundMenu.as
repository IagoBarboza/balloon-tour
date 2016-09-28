package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;


	public class SoundMenu extends Sprite 
	{
		// buttons 
		public var yesButton:MovieClip;
		public var noButton:MovieClip;
		
		// sound Status
		public var soundON:Boolean;	
		
		
		public function SoundMenu() 
		{
			// buttons listeners
			yesButton.addEventListener(MouseEvent.CLICK, yesPressed);
			noButton.addEventListener(MouseEvent.CLICK, noPressed);
													
		}

		private function noPressed(event : MouseEvent) : void 
		{
			dispatchEvent(new Event("soundOFF"));
			soundON = true;
		}

		private function yesPressed(event : MouseEvent) : void 
		{
			dispatchEvent(new Event("soundON"));	
			soundON = false;
		}
	}
}
