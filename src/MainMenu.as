package {
	import com.greensock.TweenLite;
	import flash.net.SharedObject;
	import flash.display.MovieClip;
	import flash.desktop.NativeApplication;
	import flash.events.MouseEvent;
	import fl.controls.Button;
	import flash.display.Sprite;
	import flash.events.Event;


	public class MainMenu extends Sprite 
	{
		public var soundMenu : SoundMenu = new SoundMenu();
		
		// buttons 
		public var resumeGameButton:MovieClip;
		public var startGameButton:MovieClip;
		public var recordsButton:MovieClip;
		public var quitButton:MovieClip;
		
		//
		public var game:Game;
		
		//
		public var scoreNumber : Number;
		public var scoreString : String;
		public var nome : String;
		public var blowControl : Boolean;
		
		public var records : Records = new Records();
		
		public var gameIsPaused : Boolean = false;
		
		// game data to be saved at sharedObject
		
		public var scoreCounter : Number;
		public var lifes : int;
		public var balloonY : int;
		public var gameSpeed : int;
		
		public var sharedGameData : SharedObject;
		
		public var oldGameResumed : Boolean = false;
		public var currentGamePaused : Boolean = false;
		
		// sound
		public var soundController : SoundController = new SoundController();
		
		//
		public var blackScreen : MovieClip = new BlackScreen();
		
		public function MainMenu() 
		{
			//addChild(soundMenu);
			
			sharedGameData = SharedObject.getLocal("GameData");
			//shared object initialization
			if(sharedGameData.data.gameIsPaused == undefined)	sharedGameData.data.gameIsPaused = false;
			
			AppSoundOFF();
			
			// sound menu listeners
			//soundMenu.addEventListener("soundON", AppSoundON);
			//soundMenu.addEventListener("soundOFF", AppSoundOFF);
			
			// buttons listeners
			resumeGameButton.addEventListener(MouseEvent.CLICK, resumeGameON);
			startGameButton.addEventListener(MouseEvent.CLICK, startGameON);
			recordsButton.addEventListener(MouseEvent.CLICK, recordsON);
			quitButton.addEventListener(MouseEvent.CLICK, quitGameON);
			blackScreen.addEventListener(MouseEvent.CLICK, recordsOFF);
		}

		private function checkGameIsPaused() : void
		{
			if(sharedGameData.data.gameIsPaused == true) 
			{
				//startGameButton.visible = false;
				resumeGameButton.visible = true;
			}
			else resumeGameButton.visible = false;
		}
//
//		private function loadGameData() : void
//		{
//			lifes = sharedGameData.data.lifes;
//			scoreNumber = sharedGameData.data.scoreNumber;
//			balloonY = sharedGameData.data.balloonY;
//			gameSpeed = sharedGameData.data.gameSpeed;
//		}
		
		private function AppSoundON(event:Event) : void 
		{
			soundController.playMusic1();
			removeChild(soundMenu);
			resumeGameButton.visible = false;
			// analisa se tem um jogo pausado
			checkGameIsPaused();
		}
		
		private function AppSoundOFF() : void 
		{
			//removeChild(soundMenu);
			resumeGameButton.visible = false;
			// analisa se tem um jogo pausado
			checkGameIsPaused();	
		}
		
		//
	
		private function resumeGameON(event : MouseEvent) : void 
		{
			if(sharedGameData.data.gameIsPaused && !oldGameResumed && !currentGamePaused)
			{
				trace("gameIsPausedIsTrue");
				game = new Game();
				addChild(game);
				//game class listeners
				game.addEventListener("restartGame", restartGameON);
				//game.scoreWindow.addEventListener("OKScoreWindowPressed", getPlayerInfo);
				game.addEventListener("GetPlayerInfo", getPlayerInfo);
				game.addEventListener("GameIsPaused", setGamePausedTrue);
				game.addEventListener("GameIsNotPaused", setGamePausedFalse);
				game.addEventListener("currentGameIsPaused", setCurrentGameIsPaused);
				//game.start1(event);
				if(sharedGameData.data.blowControl) game.start2(event);
				else game.start1(event);
				game.pauseGame(event);
				game.balloon.y = sharedGameData.data.balloonY;
				game.lifes = sharedGameData.data.lifes;
				game.scoreCounter = sharedGameData.data.scoreNumber;
				game.gameSpeed = sharedGameData.data.gameSpeed;
				oldGameResumed = true;
				blackScreen.addEventListener(MouseEvent.CLICK, recordsOFF);
				records.visible = false;
				
			}
			
			game.visible = true;
		}

		private function setCurrentGameIsPaused(event : Event) : void
		{
			currentGamePaused = true;
		}
		
		private function startGameON(event : MouseEvent) : void 
		{
			soundController.stopMusic1();
			sharedGameData.data.gameIsPause = false;
			//removeChild(startGameButton);
			game = new Game();
			addChild(game);
			game.newGameStarted = true;
			//game class listeners
			game.addEventListener("restartGame", restartGameON);
			//game.scoreWindow.addEventListener("OKScoreWindowPressed", getPlayerInfo);
			game.addEventListener("GetPlayerInfo", getPlayerInfo);
			game.addEventListener("GameIsPaused", setGamePausedTrue);
			game.addEventListener("currentGameIsPaused", setCurrentGameIsPaused);
			blackScreen.addEventListener(MouseEvent.CLICK, recordsOFF);
			//game.addEventListener("GameIsNotPaused", setGamePausedFalse);
			records.visible = false;	
		}

		private function restartGameON(event : Event) : void 
		{
			sharedGameData.data.gameIsPaused = false;
			game = new Game();
			addChild(game);
			game.newGameStarted = true;
			game.addEventListener("restartGame", restartGameON);
			game.addEventListener("GetPlayerInfo", getPlayerInfo);
			game.addEventListener("GameIsPaused", setGamePausedTrue);
			game.addEventListener("currentGameIsPaused", setCurrentGameIsPaused);
			blackScreen.addEventListener(MouseEvent.CLICK, recordsOFF);
			//game.addEventListener("GameIsNotPaused", setGamePausedFalse);
			records.visible=false;
		}

		private function setGamePausedFalse(event : Event) : void
		{
			gameIsPaused = false;
		}

		private function setGamePausedTrue(event : Event) : void
		{
			sharedGameData.data.gameIsPaused = true;
		}
		
		private function recordsON(event : Event) : void 
		{
			
			//records.x = 325;
			//records.y = 600;
			//records.visible = true;
			TweenLite.to(records, 0.5, {x:512,y:300});
			//records.x = 427;
			//records.y = 240;
			addChild(blackScreen);
			blackScreen.x = 512;
			blackScreen.y = 300;
			
			addChild(records);
			records.visible = true;
			//records.addEventListener("BackButtonPressed", removeRecordTable);
			
		}
		
		public function recordsOFF(event : Event) : void {
			
			TweenLite.to(records, 0.5, {x:512,y:900});
			removeChild(blackScreen);
		}

		
		private function quitGameON(event : MouseEvent) : void 
		{
			if(sharedGameData.data.gameIsPaused && currentGamePaused) saveGameData();
		
			trace(sharedGameData.data.gameIsPaused);
			NativeApplication.nativeApplication.exit();
		}

		private function saveGameData() : void
		{
			// gets game info and save the paused game to be continued on the next time the game is running
			lifes = game.lifesN();
			scoreNumber = game.ScoreN();
			balloonY = game.balloonY();
			gameSpeed = game.currentGameSpeed();
			blowControl = game.blowControlState();
			
			sharedGameData.data.lifes = lifes;
			sharedGameData.data.scoreNumber = scoreNumber;
			sharedGameData.data.balloonY = balloonY;
			sharedGameData.data.gameSpeed = gameSpeed;
			sharedGameData.data.gameIsPaused = true;
			sharedGameData.data.blowControl = blowControl;
			trace(sharedGameData.data.blowControl);
		}
		
		private function getPlayerInfo(event : Event) : void
		{
			nome = game.currentPlayerName;
			scoreString = game.playerScoreString();
			scoreNumber = game.playerScoreNumber();
			
			//trace(nome);
			//trace(scoreString);
			//trace(scoreNumber);
			
			records.getPlayerInfo(scoreString, scoreNumber, nome);
			
		}
		
		
		
	}
}
