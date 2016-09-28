package {
	import com.greensock.TweenLite;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Microphone;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.text.TextFormat;
	

	public class Game extends MovieClip 
	{
		public var UP:Boolean = false;
		public var lifes : int = 3;		
		public var update:Boolean = false;
		public var keyPressed : Boolean = false;
		//buttons
		public var upButton:MovieClip;
		public var pressButton:MovieClip;
		public var blowButton:MovieClip;
		public var pauseButton:MovieClip;
		//
		public var balloon:Balloon = new Balloon();
		public var lifeIndicators : LifeIndicators = new LifeIndicators();	
		public var tryAgainMenu:TryAgainMenu = new TryAgainMenu();
		public var pauseMenu:PauseMenu = new PauseMenu();
		//
		public var i:int = 0;	
		public var j:int = 0;
		public var k:int = 0;
		//
		public var compeSound : CompeSound;
		public var mic:Microphone = Microphone.getMicrophone();
		public var soundLevel : int;
		public var blowControl : Boolean = false;
		public var getSound : Boolean = false;
		//
		public var camada1 : CamadaPredios;
		public var camada2 : CamadaPredios;
		public var camadaAir : CamadaAir;
		public var camada3 : MovieClip;
		public var camada4 : MovieClip;
		public var camada5 : MovieClip;
		//
		public var timeCounter : int;
		public var scoreCounter : Number =0;
		public var scoreBar : MovieClip;
		public var gameSpeed:int = 2;
		public var myFormat : TextFormat = new TextFormat();
		public var score:TextField = new TextField();
		public var scoreString:String;
		public var scoreWindow : ScoreWindow = new ScoreWindow();
		public var scoreWindowRemoved : Boolean = false;
		
		//
		public var currentPlayerName : String;
		
		//
		public var sharedGameData : SharedObject;
		public var sharedObject : SharedObject;
		
		//
		public var currentGameResumed : Boolean = false;
		public var newGameStarted : Boolean = false;
		
		//
		public var collisionEnable : Boolean = true;
		
		//
		public var distanciaAux = 0;
		
		public function Game() 
		{
			sharedGameData = SharedObject.getLocal("GameData");
			sharedObject = SharedObject.getLocal("topScores");
			//if(sharedGameData.data.gameIsPaused == true) loadGameData(tempScoreCounter, tempLifesN, tempBalloonY, tempGameSpeed);
			
			pressButton.addEventListener(MouseEvent.CLICK, start1);
			blowButton.addEventListener(MouseEvent.CLICK, start2);	
			
			
			
			//myFormat.font = myFont.fontName;
			//myFormat.size = 50;
			//myTextField.defaultTextFormat = myFormat;
			
			//score.textField = myTextField;
			
			
		}

//		private function loadGameData(tempScoreCounter : Number, tempLifesN : int, tempBalloonY : int, tempGameSpeed : int) : void
//		{
//			scoreCounter = tempScoreCounter;
//			lifes = tempLifesN;
//			balloon.y = tempBalloonY;
//			gameSpeed = tempGameSpeed;
//		}

		public function start1(event : MouseEvent) : void 
		{	
			setGameButtons();
			upButton.addEventListener(MouseEvent.MOUSE_DOWN, mouseDOWN);
			upButton.addEventListener(MouseEvent.MOUSE_OUT, mouseUP);
			upButton.addEventListener(MouseEvent.MOUSE_UP, mouseUP);
		
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDOWN);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUP);
			tryAgainMenu.addEventListener("yesPressed", yesButtonPressed);
			tryAgainMenu.addEventListener("noPressed", noButtonPressed);
			scoreWindow.addEventListener("scoreOkPressed", removeScoreWindow);
			pauseButton.addEventListener(MouseEvent.CLICK, pauseGame);	
			pressButton.visible = false;
			blowButton.visible = false;
			balloonStart();
			lifeIndicatorsStart();
			setGameScore();		
			startUpdate();
		}

		public function removeScoreWindow(event : Event) : void
		{
			removeChild(scoreWindow);
			scoreWindowRemoved = true;
			tryAgainMenu.startTryAgainMenu();
		}

		
		public function start2(event : MouseEvent) : void 
		{	
			compeSoundStart();
			setGameButtons();
			removeChild(upButton);
			tryAgainMenu.addEventListener("yesPressed", yesButtonPressed);
			tryAgainMenu.addEventListener("noPressed", noButtonPressed);
			scoreWindow.addEventListener("scoreOkPressed", removeScoreWindow);	
			compeSound.addEventListener(CompeSoundEvent.SOUND_LEVEL, getSoundLevel, false, 0,true);
			pressButton.visible = false;
			blowButton.visible = false;
			blowControl = true;
			//setGameButtons();
			//removeChild(upButton);
			compeSoundStart();
			balloonStart();
			lifeIndicatorsStart();
			setGameScore();
			startUpdate();
			pauseButton.addEventListener(MouseEvent.CLICK, pauseGame);
			
		}

	
	
		
		// update world 
		private function updateWorld(event : Event) : void 
		{
			if(update)
			{	
				//camada1.addEventListener("colisão", collision);
				
				gameScore();	
				balloonMoovement();
				bgMoovement();
				collision();
				//trace("Posição X predio Alto: "+getBuildPositionC1());
			}
		}


		//

		private function setGameButtons() : void
		{
			upButton = new UpButton();
			pauseButton = new PauseButton();

			addChild(upButton);
			addChild(pauseButton);
			
			upButton.x = 920;
			upButton.y = 530;
			//upButton.visible = false;
			pauseButton.x = 80;
			pauseButton.y = 540;
			
		}
		
		private function startUpdate() : void 
		{	
			this.addEventListener(Event.ENTER_FRAME, updateWorld);
			update = true;
			balloon.visible = true;
			balloon.alpha = 1;
			balloon.startAnimation();
			if(balloon.collisionEnableStatus() == false)balloon.animateCollision();
			if(blowControl) getSound = true;
			
		}
		
		private function stopUpdate() : void 
		{
			update = false;
			balloon.visible = false;
			balloon.stopAnimation();	
			if(blowControl) getSound = false;
		}
		
		private function lifeIndicatorsStart() : void 
		{
			lifes = 3;
			lifeIndicators.x = 880;
			lifeIndicators.y = 14;
			addChild(lifeIndicators);
			trace(sharedGameData.data.gameIsPaused)
			
			if(sharedGameData.data.gameIsPaused && !newGameStarted)
			{
				trace("remover os lifeIndicators");
				trace(sharedGameData.data.lifes);
     			if(sharedGameData.data.lifes == 2) lifeIndicators.removeChild(lifeIndicators.lifeIndicator_1);
				if(sharedGameData.data.lifes == 1)
				{
					lifeIndicators.removeChild(lifeIndicators.lifeIndicator_1)	
				 	lifeIndicators.removeChild(lifeIndicators.lifeIndicator_2);
				}
				if(sharedGameData.data.lifes == 0)
				{
					lifeIndicators.removeChild(lifeIndicators.lifeIndicator_1)	
				 	lifeIndicators.removeChild(lifeIndicators.lifeIndicator_2);
				 	lifeIndicators.removeChild(lifeIndicators.lifeIndicator_3)	
				}
			}
		}
		
		private function setGameScore() : void
		{
			myFormat.size = 25;
			myFormat.font = "hooge 05_53";
			score.defaultTextFormat = myFormat;
			score.x = 770;
			score.y = 10;
			addChild(score);
		}

		private function balloonStart() : void 
		{
			balloon.x = 80;
			balloon.y = 63;
			balloon.addEventListener("collisionEnable", enableCollision);
			balloon.addEventListener("collisionDisable", disableCollision);
			addChild(balloon);

		}

		private function disableCollision(event : Event) : void
		{	
			collisionEnable = false;	
			trace("collision disabled");
			
		}

		private function enableCollision(event : Event) : void
		{
			collisionEnable = true;
			 trace("enableCollision");
		}
		
		private function compeSoundStart() : void 
		{
				compeSound = new CompeSound(mic);
				compeSound.start();
		}
			
					
		// mouse and keyboard event listeners functions
		private function keyUP(event : KeyboardEvent) : void 
		{
			UP = false;
			keyPressed = false;
		}

		private function keyDOWN(event : KeyboardEvent) : void 
		{
			if(!keyPressed)
			{
				UP = true;
				keyPressed = true;
			}
		}

		private function mouseUP(event : MouseEvent) : void 
		{
			UP = false;
			keyPressed = false;
		}

		private function mouseDOWN(event : MouseEvent) : void 
		{
			UP = true;
			keyPressed = true;
			trace("mouseDown");
		}
		
		 //compe sound event listener 
		private function getSoundLevel(event : CompeSoundEvent) : void 
		{	
			soundLevel = event.level;
			//forceUP = soundLevel;
			trace(soundLevel);
			//balloon.y = soundLevel;
			
			
			if(soundLevel>=20)
			{
				UP = true;
			}	
				
			if(soundLevel<20)
			{
				UP =false;
			}
		}
				
		// pause button listener 
		public function pauseGame(event : MouseEvent) : void 
		{
			stopUpdate();
			addChild(pauseMenu);
			upButton.visible = false;
			pauseButton.visible = false;
			pauseMenu.startPauseMenu();
			pauseMenu.addEventListener("PlayButtonPressed", resumeGame);
			pauseMenu.addEventListener("ExitButtonPressed", returnMainMenu);
			//compeSound.removeEventListener(CompeSoundEvent.SOUND_LEVEL, getSoundLevel);
			dispatchEvent(new Event("currentGameIsPaused"));
			dispatchEvent(new Event("GameIsPaused"));
		}
		
		// game data to be send to MainMenu

		public function balloonY() : int
		{
			return balloon.y;
		}
		
		public function lifesN() : int
		{
			return lifes;	
		}
		
		public function ScoreN() : Number
		{
			return scoreCounter;
		}
		
		public function currentGameSpeed() : int
		{
			return  gameSpeed;
		}
		
		private function resumeGame(event : Event) : void 
		{
				startUpdate();
				pauseMenu.stopPauseMenu();
				upButton.visible = true;
				pauseButton.visible = true;
				if(blowControl) compeSound.addEventListener(CompeSoundEvent.SOUND_LEVEL, getSoundLevel);
			//	dispatchEvent(new Event("GameIsNotPaused"));
		}
		
		private function returnMainMenu(event : Event) : void 

		{
			sharedGameData.data.gameIsPaused = true;
			update = false;
		    //(parent as MainMenu).startGameButton.visible = false;
		    (parent as MainMenu).resumeGameButton.visible = true;
		    this.visible = false;
		}
		
		// tryAgainMenu Buttons listeners 
		private function noButtonPressed(event : Event) : void 
		{	
			(parent as MainMenu).addChild((parent as MainMenu).startGameButton);
			(parent as MainMenu).resumeGameButton.visible = false;
			(parent as MainMenu).startGameButton.visible = true;
			(parent as MainMenu).removeChild(this);
			//compeSound.stop();
		}

		private function yesButtonPressed(event : Event) : void 
		{
			(parent as MainMenu).removeChild(this);
			 dispatchEvent(new Event("restartGame"));
			 //compeSound.stop();
		}
		
		// moovement functions
		
		private function balloonMoovement() : void 
		{
			if(balloon.y >=21)
			{
			 balloon.move(UP,gameSpeed);
			}
			//else if(balloon.y<=33)balloon.y =33;
			else if(balloon.y<21)
			{
				UP = false;
				balloon.y =21;
			}
			
			
			if(!blowControlState()){
				
				if(balloon.y > 50 && !UP && keyPressed)
				{
					UP = true;
				}
			}
			else if(blowControlState()){
				if(balloon.y > 31 && !UP && soundLevel > 40) UP = true;
			}
			
		}
		
		private function bgMoovement() : void 
		{
				//trace(camada1.x);
				//TweenLite.to(camada1,1,{x:camada1.x-40});	
				//TweenLite.to(camada2,1,{x:camada2.x-40});
				//TweenLite.to(camada3,1,{x:camada3.x-10});
				//TweenLite.to(camada4,1,{x:camada4.x-10});
				camada1.startMove(gameSpeed);
				camada2.startMove(gameSpeed);
				camada3.x = camada3.x -1*gameSpeed;
				camada4.x = camada4.x -1*gameSpeed;
				camada5.x = camada5.x -1*gameSpeed;
				camadaAir.startMove(gameSpeed);
				
				if(camada3.x <-965) // lembrar de corrigir o bug do reposicionamento 
				{
					camada3.x = 3175;
					distanciaAux = (camada3.x - camada4.x);
				}
				
				if(camada4.x <-965)
				{
					camada4.x = 3715;
					distanciaAux = (camada4.x - camada3.x);
				}
				
				if(camada5.x <-965)
				{
					camada5.x = 3715;	
				}
				
		}
		
		// score refresh
		
		private function gameScore() : void
		{
				scoreCounter = (scoreCounter + 0.5*gameSpeed);
				if(scoreCounter%300==0)gameSpeed+=1;
				scoreString = int(scoreCounter).toString();	// converte int pra string	
				score.text = scoreString;
		}
		
		// set score window on the stage
		
		public function setScoreWindow() : void
		{
			addChild(scoreWindow);
			TweenLite.to(scoreWindow, 0.5, {x:512,y:250});
			scoreWindow.setScore(scoreString);
			scoreWindow.addEventListener("OKScoreWindowPressed", getPlayerName);
		}
		
		// collision
		
		private function collision() : void 
		{
			
			if(balloon.y > 600) buildCollision();
			
			for(i=0;i<5;i++)
			{
				// se o predio for o 1 ou o 2 analisar a colisão do body e head do predio
				if(camada1.array[i] == camada1.predio_cod1 || camada1.array[i] == camada1.predio_cod2)
				{
				
					if(
					   (balloon.top.hitTestObject(camada1.array[i].body)|| balloon.top.hitTestObject(camada1.array[i].head))
					|| (balloon.mid.hitTestObject(camada1.array[i].body)|| balloon.mid.hitTestObject(camada1.array[i].head)) 
					|| (balloon.bot.hitTestObject(camada1.array[i].body)|| balloon.bot.hitTestObject(camada1.array[i].head))
					)
					{
						if(collisionEnable) buildCollision();
					}
				}
			 	else
			 	
			 	if(camada1.array[i] == camada1.predio_cod3)
			 	{
			 		if(
					   (balloon.top.hitTestObject(camada1.array[i].bot)|| balloon.top.hitTestObject(camada1.array[i].mid)|| balloon.top.hitTestObject(camada1.array[i].top1) || balloon.top.hitTestObject(camada1.array[i].top2)|| balloon.top.hitTestObject(camada1.array[i].top3))
					|| (balloon.mid.hitTestObject(camada1.array[i].bot)|| balloon.mid.hitTestObject(camada1.array[i].mid)|| balloon.mid.hitTestObject(camada1.array[i].top1) || balloon.mid.hitTestObject(camada1.array[i].top2)|| balloon.mid.hitTestObject(camada1.array[i].top3)) 
					|| (balloon.bot.hitTestObject(camada1.array[i].bot)|| balloon.bot.hitTestObject(camada1.array[i].mid)|| balloon.bot.hitTestObject(camada1.array[i].top1) || balloon.bot.hitTestObject(camada1.array[i].top2)|| balloon.bot.hitTestObject(camada1.array[i].top3))
					)
					{
						if(collisionEnable) buildCollision();
					}
			 		
			 	}
			 	else
			 	{
			 		if(balloon.top.hitTestObject(camada1.array[i]) || balloon.mid.hitTestObject(camada1.array[i]) 
					|| balloon.bot.hitTestObject(camada1.array[i]))
					{
						if(collisionEnable) buildCollision();
					}
			 	}
			 
			 }
			i =0;
				
			
			for(j=0;j<5;j++)
			{
				// se o predio for o 1 ou o 2 analisar a colisão do body e head do predio
				if(camada2.array[j] == camada2.predio_cod1 || camada2.array[j] == camada2.predio_cod2)
				{
				
					if(
					   (balloon.top.hitTestObject(camada2.array[j].body)|| balloon.top.hitTestObject(camada2.array[j].head))
					|| (balloon.mid.hitTestObject(camada2.array[j].body)|| balloon.mid.hitTestObject(camada2.array[j].head)) 
					|| (balloon.bot.hitTestObject(camada2.array[j].body)|| balloon.bot.hitTestObject(camada2.array[j].head))
					)
					{
						if(collisionEnable) buildCollision();
					}
				}
			 	else
			 	
			 	if(camada2.array[j] == camada2.predio_cod3)
			 	{
			 		if(
					   (balloon.top.hitTestObject(camada2.array[j].bot)|| balloon.top.hitTestObject(camada2.array[j].mid)|| balloon.top.hitTestObject(camada2.array[j].top1) || balloon.top.hitTestObject(camada2.array[j].top2)|| balloon.top.hitTestObject(camada2.array[j].top3))
					|| (balloon.mid.hitTestObject(camada2.array[j].bot)|| balloon.mid.hitTestObject(camada2.array[j].mid)|| balloon.mid.hitTestObject(camada2.array[j].top1) || balloon.mid.hitTestObject(camada2.array[j].top2)|| balloon.mid.hitTestObject(camada2.array[j].top3)) 
					|| (balloon.bot.hitTestObject(camada2.array[j].bot)|| balloon.bot.hitTestObject(camada2.array[j].mid)|| balloon.bot.hitTestObject(camada2.array[j].top1) || balloon.bot.hitTestObject(camada2.array[j].top2)|| balloon.bot.hitTestObject(camada2.array[j].top3))
					)
					{
						if(collisionEnable) buildCollision();
					}
			 		
			 	}
			 	else
			 	{
			 		if(balloon.top.hitTestObject(camada2.array[j]) || balloon.mid.hitTestObject(camada2.array[j]) 
					|| balloon.bot.hitTestObject(camada2.array[j]))
					{
						if(collisionEnable) buildCollision();
					}
			 	}
			 
			 }
			j =0;
			
			for(k=0;k<4;k++)
			{	
				if(camadaAir.array[k] == camadaAir.airPlane1 || camadaAir.array[k] == camadaAir.airPlane2){
						if(balloon.top.hitTestObject(camadaAir.array[k].bodyAirPlane) || 
						 balloon.top.hitTestObject(camadaAir.array[k].asa1) ||
						 balloon.mid.hitTestObject(camadaAir.array[k].bodyAirPlane) ||
						 balloon.mid.hitTestObject(camadaAir.array[k].asa1) ||
					 	balloon.bot.hitTestObject(camadaAir.array[k].bodyAirPlane) ||
					 	balloon.bot.hitTestObject(camadaAir.array[k].asa1))
					 	
					{
						if(collisionEnable) airCollision();	
					}
				}
					
				else if(camadaAir.array[k] == camadaAir.helicopter1 || camadaAir.array[k] == camadaAir.helicopter2)
				{ 
					if(balloon.top.hitTestObject(camadaAir.array[k]) || balloon.mid.hitTestObject(camadaAir.array[k]) 
						|| balloon.bot.hitTestObject(camadaAir.array[k]))
					{	 
						if(collisionEnable) airCollision();	
					}	
				}
			}
			k=0;
		}
				
				
		private function airCollision() : void 
		{
					camadaAir.x = 1700;
					//removeChild(balloon);
					balloonStart();
					balloon.counter = 7;
					balloon.animateCollision();
					lifes--;
					if(lifes == 2)lifeIndicators.removeChild(lifeIndicators.lifeIndicator_1);
					if(lifes == 1)lifeIndicators.removeChild(lifeIndicators.lifeIndicator_2);
					if(lifes == 0)lifeIndicators.removeChild(lifeIndicators.lifeIndicator_3);
					if(lifes == -1)
					{	
						//trace(blowControl);
						//if(blowControl) compeSound.removeEventListener(CompeSoundEvent.SOUND_LEVEL, getSoundLevel);
						removeChild(balloon);
						stopUpdate();
						addChild(tryAgainMenu);
						if(scoreCounter > sharedObject.data.player1ScoreN)setScoreWindow();
						else tryAgainMenu.startTryAgainMenu();
						//if(scoreWindowRemoved)
						//{
							//addChild(tryAgainMenu);
							//tryAgainMenu.startTryAgainMenu();
						//}
						
						upButton.visible = false;
						pauseButton.visible = false;
						sharedGameData.data.gameIsPaused = false;
					}
				
					
		}


		private function buildCollision() : void
		{
						//removeChild(balloon);
						balloonStart();
						balloon.animateCollision();
						lifes--;
						if(lifes == 2) lifeIndicators.removeChild(lifeIndicators.lifeIndicator_1);
						if(lifes == 1) lifeIndicators.removeChild(lifeIndicators.lifeIndicator_2);
						if(lifes == 0) lifeIndicators.removeChild(lifeIndicators.lifeIndicator_3);
						
						if(lifes == -1)
						{	
							//compeSound.removeEventListener(CompeSoundEvent.SOUND_LEVEL, getSoundLevel);
							removeChild(balloon);
							stopUpdate();
							addChild(tryAgainMenu);
							if(scoreCounter > sharedObject.data.player1ScoreN)setScoreWindow();
							else tryAgainMenu.startTryAgainMenu();
							//tryAgainMenu.startTryAgainMenu();
							upButton.visible = false;
							pauseButton.visible = false;
							sharedGameData.data.gameIsPaused = false;	
						}
		}
		
		private function getPlayerName(event : Event) : void
		{
			currentPlayerName = scoreWindow.PlayerName();
			dispatchEvent(new Event("GetPlayerInfo"));
			
		}
		
		public function playerName() : String
		{
			return currentPlayerName;
		}
		
		public function playerScoreString() : String
		{
			return scoreString;
		}
		
		public function playerScoreNumber() : Number
		{
			return scoreCounter;
		}
		
		public function blowControlState() : Boolean
		{
			return blowControl;
		}
		
		public function getBuildPositionC1() : Number
		{
			return camada1.predio_cod3.x;
		}
		public function getBuildPositionC2() : Number
		{
			return camada2.predio_cod3.x;
		}
		
		
	}	
}
