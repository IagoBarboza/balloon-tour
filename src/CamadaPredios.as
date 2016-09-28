package {
	import flashx.textLayout.formats.Float;
	import flash.display.MovieClip;

	
	public class CamadaPredios extends MovieClip
	{
		var predio_cod1 : MovieClip = new Predio_cod1();
		var predio_cod2 : MovieClip = new Predio_cod2();
		var predio_cod3 : MovieClip = new Predio_cod3();
		var predio_cod4 : MovieClip = new Predio_cod4();
		var predio_cod5 : MovieClip = new Predio_cod5();
		var predio_cod6 : MovieClip = new Predio_cod6();
		//var predio_cod7 : MovieClip = new Predio_cod7();
		//var predio_cod8 : MovieClip = new Predio_cod8();
		var array : Array = new Array(MovieClip);
		var i : int;
		var nR : int;
		var aux : int = -1000;
		
			
		public function CamadaPredios()
		{
		
//			trace(this.height);
//			trace(this.width);
			
			//this.height = 266;
			//this.width = 2800;
		
			
			
			array[0] =  predio_cod1;
			array[1] =  predio_cod2;
			array[2] =  predio_cod3;
			array[3] =  predio_cod4;
			array[4] =  predio_cod5;
			array[5] =  predio_cod6;
			//array[6] =  predio_cod7;
			//array[7] =  predio_cod8;
		
		
			array = shuffleArray(array);
			
			for(i=0;i<5;i++)
			{
				
				array[i].x = aux;
				array[i].y = -12;
				if(array[i] == predio_cod3) array[i].y = -10;
				addChild(array[i]);
				aux = aux + 550;
			}
	
		}
		
		public function startMove(gameSpeed : int) : void
		{
			this.x = this.x -2*gameSpeed;
			
				if(this.x < -1668)
				{
					this.x = 4050;
					//trace("reposicionou");
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
