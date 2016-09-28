package {
	import flash.events.Event;
	import fl.controls.Button;

	import com.greensock.TweenLite;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author Ibs
	 */
	public class Records extends MovieClip
	{
//		public var player1 : Player = new Player();
//		public var player2 : Player = new Player();
//		public var player3 : Player = new Player();
//		public var player4 : Player = new Player();
//		public var player5 : Player = new Player();
		
		public var array : Array = new Array(Player);
		
		public var nome : String;
		public var scoreNumber : Number;
		public var scoreString : String;
		public var score : TextField = new TextField();
		public var format : TextFormat = new TextFormat();
		public var playerName : TextField = new TextField();
		
		public var i : int;
		public var j : int;
		
		public var sharedObject : SharedObject;
		
		//public var backButton : MovieClip;
		
		public function Records()
		{
//			array[0] = player1;
//			array[1] = player2;
//			array[2] = player3;
//			array[3] = player4;
//			array[4] = player5;
			
		

			// sharedObject inicialization
			sharedObject = SharedObject.getLocal("topScores");
			if(sharedObject.data.player1Name == undefined) sharedObject.data.player1Name = "Empty";
			if(sharedObject.data.player1ScoreS == undefined) sharedObject.data.player1ScoreS = "0";
			if(sharedObject.data.player1ScoreN == undefined) sharedObject.data.player1ScoreN = 0;
			
			format.font = "hooge 0553";
			format.size = 30;
			format.color = 0x000000;
			score.defaultTextFormat = format;
			score.x = -45;
			score.y = 0;
			score.text = sharedObject.data.player1ScoreS;
			score.width = 90;
			addChild(score);
			
			
			playerName.defaultTextFormat = format;
			playerName.x = -90;
			playerName.y=-90;
			playerName.text = sharedObject.data.player1Name;
			playerName.width = 180;
			addChild(playerName);
			
			
			
			this.x = 512;
			this.y = 600;
			
			//loadArray();
			//loadShared();
		}

		private function backMainMenu(event : MouseEvent) : void
		{
			//this.visible = false;

		}
		
		public function getPlayerInfo(scoreS : String, scoreN : Number, currentName : String) : void 
		{
			if(scoreN > sharedObject.data.player1ScoreN)
			{
				nome = currentName;
				scoreNumber = scoreN;
				scoreString = scoreS;
				trace("Anterior");
				trace(sharedObject.data.player1Name);
				trace(sharedObject.data.player1ScoreN);
				sharedObject.data.player1Name = nome;
				sharedObject.data.player1ScoreN = scoreNumber;
				sharedObject.data.player1ScoreS = scoreString;
				trace("Novo");
				trace(sharedObject.data.player1Name);
				trace(sharedObject.data.player1ScoreN);
				trace(sharedObject.data.player1ScoreS);
				
				score.text = scoreString;
				playerName.text = nome;
			
			}
			//trace(nome);
			//trace(scoreNumber);
			//trace(scoreString);
			//trace("getting player info - records");
			
			
			
			//putPlayerAtList(scoreNumber, scoreString, nome);
			
		}

//		private function loadShared() : void
//		{
//			
//			trace("loading shared");
//			array[0].nome = sharedObject.data.player1Name;
//			array[0].scoreS = sharedObject.data.player1ScoreS;
//			array[0].scoreN = sharedObject.data.player1ScoreN;
//			
//			array[1].nome = sharedObject.data.player2Name;
//			array[1].scoreS = sharedObject.data.player2ScoreS;
//			array[1].scoreN = sharedObject.data.player2ScoreN;
//			
//			array[2].nome = sharedObject.data.player3Name;
//			array[2].scoreS = sharedObject.data.player3ScoreS;
//			array[2].scoreN = sharedObject.data.player3ScoreN;
//			
//			array[3].nome = sharedObject.data.player4Name;
//			array[3].scoreS = sharedObject.data.player4ScoreS;
//			array[3].scoreN = sharedObject.data.player4ScoreN;
//			
//			array[4].nome = sharedObject.data.player5Name;
//			array[4].scoreS = sharedObject.data.player5ScoreS;
//			array[4].scoreN = sharedObject.data.player5ScoreN;
//		}
//		
//
//		private function putPlayerAtList(scoreN : Number, scoreS : String, currentName : String) : void
//		{
//			for(j=4 ; j>=0 ; j--)
//			{
//					
//					if(j > 0)
//					{
//						if(scoreN > array[j].scoreN && scoreN < array[j-1].scoreN)
//						{
//							array[j].nome = currentName;
//							array[j].scoreS = scoreS;
//							array[j].scoreN = scoreN;
//						}
//					}
//					if(j == 0)
//					{
//						if(scoreN > array[j].scoreN)
//						{
//							array[j].nome = currentName;
//							array[j].scoreS = scoreS;
//							array[j].scoreN = scoreN;
//							
//						}
//						
//							saveScoreList();
//					}
//				
//				//trace(array[j].nome);
//				//trace(array[j].scoreN);
//				trace("putting player at list");
//			}
//		}

//		private function loadArray() : void
//		{
//			for(i=0; i<5; i++)
//			{
//				array[i].scoreN = 0;
//				array[i].nome = "empty";
//			}
//		}
		
		
		
//		public function saveScoreList() : void
//		{
//			sharedObject.data.player1Name = array[0].nome;
//			sharedObject.data.player1ScoreS = array[0].scoreS;
//			sharedObject.data.player1ScoreN = array[0].scoreN;
//			
//			sharedObject.data.player2Name = array[1].nome;
//			sharedObject.data.player2ScoreS = array[1].scoreS;
//			sharedObject.data.player2ScoreN = array[1].scoreN;
//			
//			sharedObject.data.player3Name = array[2].nome;
//			sharedObject.data.player3ScoreS = array[2].scoreS;
//			sharedObject.data.player3coreN = array[2].scoreN;
//			
//			sharedObject.data.player4Name = array[3].nome;
//			sharedObject.data.player4ScoreS = array[3].scoreS;
//			sharedObject.data.player4coreN = array[3].scoreN;
//			
//			sharedObject.data.player5Name = array[4].nome;
//			sharedObject.data.player5ScoreS = array[4].scoreS;
//			sharedObject.data.player5ScoreN = array[4].scoreN;
//		
//			trace(array[0].nome);
//			trace(array[0].scoreN);
//			trace(array[1].nome);
//			trace(array[1].scoreN);
//			trace(array[2].nome);
//			trace(array[2].scoreN);
//			trace(array[3].nome);
//			trace(array[3].scoreN);
//			trace(array[4].nome);
//			trace(array[4].scoreN);
//		}
	}
}
