package
{
	import flash.text.TextField;
	import flash.media.Microphone;
	import flash.net.SharedObject;
	import flash.display.Sprite;
	
	public class Main extends Sprite 
	{
		public var mainMenu : MainMenu = new MainMenu();
		public var sharedObject : SharedObject;
	
		
		public function Main() 
		{
			addChild(mainMenu);	
			//showShared();		
		}

		private function showShared() : void
		{
			sharedObject = SharedObject.getLocal("topScores");	
			sharedObject.data.player1Name = undefined;
			sharedObject.data.player1ScoreN = undefined;
			sharedObject.data.player1ScoreS = undefined;
			
		}

		private function cleanSharedObjejct() : void
		{
			sharedObject = SharedObject.getLocal("topScores");	
			sharedObject.data.player1ScoreN = 0;
			sharedObject.data.player1Name = "Empty";
			sharedObject.data.player1ScoreS = "0";
		}
		
	}
}

