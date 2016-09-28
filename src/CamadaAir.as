package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class CamadaAir extends Sprite 
	{		
		 var helicopter1 : MovieClip = new Helicopter();
		 var helicopter2 : MovieClip = new Helicopter();
	     var airPlane1 : MovieClip = new AirPlane();
	     var airPlane2 : MovieClip = new AirPlane();
		 //
		 var move : Boolean = false;
		 var i : int = 0;
		 var aux : int = - 579;
		 //
		 public var array : Array = new Array(MovieClip);
			
		public function CamadaAir() 
		{
				array[0] = helicopter1;
				array[1] = airPlane1;
				array[2] = helicopter2;
				array[3] = airPlane2;

				setAirObjects();
				helicopter1.gotoAndPlay(3);
				helicopter2.gotoAndPlay(3);
				airPlane1.gotoAndPlay(4);
				airPlane2.gotoAndPlay(4);
				changePosition(array[0], array[1]);
		}

		

		public function stopMove() : void 
		{
			move = false;
		}

		public function startMove(gameSpeed : int) : void 
		{
			move = true;
		
				 
			
			
			//if(helicopter1.currentFrame == 4) helicopter1.gotoAndStop(1);
			
			this.x -= 4*gameSpeed;

	
			if(this.x < -2600)
			{	
				this.x = 1700;
				array = shuffleArray(array);
				changePosition(array[0], array[1]);	
			}
		}
		
		public function setAirObjects() : void
		{
			array = shuffleArray(array);
				
			for(i=0;i<4;i++)
			{
				array[i].x = aux;
				array[i].y = 20;
				addChild(array[i]);
				aux = aux + 1300;
			}
		}

		private function changePosition(obj1 : MovieClip, obj2 : MovieClip) : void
		{
			var auxX : Number;
			var auxY : Number;
			var n : Number;
			
			auxX = obj1.x;
			auxY = obj1.y;
			
			obj1.x = obj2.x;
			obj1.y = obj2.y;
			
			obj2.x = auxX;
			obj2.y = auxY;
			
			n = Math.random();
			if( 0 < n > 0.3) 
			{
				obj1.y = 140;
				obj2.y = 40;
			}
			
			if(0.3 < n < 0.6)
			{
				obj1.y = 40;
			 	obj2.y = -80;
			}
			
			if(0.6 < n < 0.9)
			{
				obj1.y = -80;
			 	obj2.y = 140;
			}
			
						
		}
		
		function shuffleArray(array:Array):Array
		{
			var len:Number = array.length;
			var mixed:Array = array.slice();
			var rn:int;
			var obj:Object;
			
			for(var i:int=0; i< len; i++)
			{
				obj = mixed[i];
				rn = Math.random()*len;
				mixed[i]= mixed[rn];
				mixed[rn]=obj;
			}
			
			return mixed;
		}
	}
}
