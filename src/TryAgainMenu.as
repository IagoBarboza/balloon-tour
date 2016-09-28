package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class TryAgainMenu extends MovieClip
	{
		public var yesButton : MovieClip;
		public var noButton : MovieClip;
		
		public function TryAgainMenu()
		{
			this.x = 436;
			this.y = -200;
			
			yesButton.addEventListener(MouseEvent.CLICK, yesPressed);
			noButton.addEventListener(MouseEvent.CLICK, noPressed);
		}

		public function startTryAgainMenu() : void
		{
			
			this.x = 512;
			this.y = 300;
			
			//TweenLite.to(this, 0.5, {x:436.10, y: 68});
		}
		
		public function stopTryAgainMenu() : void
		{
			this.x = 436;
			this.y = -200;
			
			//TweenLite.to(this, 0.5, {x:436, y: -69});
		}

		private function yesPressed(event : MouseEvent) : void
		{
			dispatchEvent(new YesNoEvent(YesNoEvent.YES_PRESSED));
		}

		private function noPressed(event : MouseEvent) : void
		{
			dispatchEvent(new YesNoEvent(YesNoEvent.NO_PRESSED));
		}
	}
}
