package {
	import flash.media.SoundChannel;
	import flash.display.Sprite;
	import flash.media.Sound;

	/**
	 * @author Ibs
	 */
	public class SoundController extends Sprite 
	{
		public var music1 : Sound = new Music1();
		public var music2 : Sound = new Music2();
		public var channel1 : SoundChannel = new SoundChannel();
		public var channel2 : SoundChannel = new SoundChannel();
		
		public function SoundController() 
		{
			
			
			trace("SoundController Started");
		}
		
		public function playMusic1() : void 
		{
			channel1 = music1.play();
		}
		
		public function stopMusic1() : void
		{
			channel1.stop();
		}
		
		public function playMusic2() : void
		{
			channel2 = music2.play();
			
		}
		
		public function stopMusic2() : void
		{
			channel2.stop();
		}
		
		
	}
}
