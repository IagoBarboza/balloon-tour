package
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;

	import flash.display.MovieClip;

	public class PauseMenu extends MovieClip
	{
		public var playButton : MovieClip;
		public var exitButton : MovieClip;
		//public var pausedScreen : MovieClip = new PausedScreen();
		
		public function PauseMenu()
		{
			this.x = 512;
			this.y = 300;	
			
			// buttons listeners
			
			playButton.addEventListener(MouseEvent.CLICK, playPressed);
			exitButton.addEventListener(MouseEvent.CLICK, exitPressed);
			
			
		}

		private function playPressed(event : MouseEvent) : void
		{
			dispatchEvent(new Event("PlayButtonPressed"));
		}

		private function exitPressed(event : MouseEvent) : void
		{
			dispatchEvent(new Event("ExitButtonPressed"));
		}

		public function startPauseMenu() : void
		{
			//TweenLite.to(this, 0.5, {x:70,y:360});
			this.x = 512;
			this.y = 300;
		}
		
		public function stopPauseMenu() : void
		{
			//TweenLite.to(this, 0.5, {x:-70,y:360});	
			this.x = 3000;
			this.y = 3000;
		}
	}
}
