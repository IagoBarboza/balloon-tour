package {
	import flash.events.Event;
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	import com.greensock.easing.Cubic;
	import flash.display.MovieClip;

	public class Balloon extends Sprite
	{
		public var top : MovieClip;
		public var mid : MovieClip;
		public var bot : MovieClip;
		private var animated: int = 0;
		private var state: int = 10;
		private var forceUP : int;
		private var state2: int = 0;
		public var counter : int = 7;
		private var collisionEnable:Boolean =true; 

		
		public function Balloon() 
		{
			top.alpha = 0;
			mid.alpha = 0;
			bot.alpha = 0;
			this.startAnimation();
		}

		public function startAnimation() : void {
		
				if(!this.animated){
					this.animated = 1;
					this.animate();			
					}
				}
			//this.animated2 = true;
				
		

		public function stopAnimation() : void {
			this.animated = 0;
			//this.animated2 = false;
		}
		
		private function animate() : void {
			
			if(this.animated)
			{
				this.state = this.state * (-1);
				TweenLite.to(this, 2, {rotationZ:state, ease:Cubic.easeInOut, onComplete: this.animate});
			
			}
		}
		public function animateCollision() : void
		{
			
			//if(animated2)
			//{
				if(counter > 0)
				{
					TweenLite.to(this, 0.5, {alpha:state2, onComplete:this.animateCollision});
				
					switch (state2)
					{
						case 1: state2 = 0;
						break;
					
						case 0: state2 = 1; 
						break;
					}
				
					this.stopAnimation();
					counter--;
					//trace("counter");
					//trace(counter);
				
					dispatchEvent(new Event("collisionDisable"));
					collisionEnable = false;
				
				}
			
			
				if(counter == 0) 
				{
					if(this.alpha == 0) this.alpha = 1;
					this.startAnimation();
					counter = 7;
					dispatchEvent(new Event("collisionEnable"));
					collisionEnable = true;
				}
			
			//}
						
		}
		
		public function move(UP: Boolean,gameSpeed:int) : void
		{
			//if(balloon.y <= 60) forceUP -=20;
			
			
			// UP is true
			if(UP == false && forceUP <= 0){
				
				forceUP += 1;
			}
			
			// DOWN is true
			if(UP == true && forceUP >= 0){
			
				forceUP -= 1;	
			}
			
			
			// moovement		
			 //TweenLite.to(balloon,3, {y:balloon.y+resultantFORCE});		
			this.y = this.y + (forceUP)*gameSpeed;
		}
		
		public function collisionEnableStatus() : Boolean
		{
			return this.collisionEnable;
		}
	}
}
