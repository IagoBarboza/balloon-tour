package {
	import flash.events.Event;

	/**
	 * @author rodrigopex
	 */
	public class CompeSoundEvent extends Event {
		public static var SOUND_LEVEL : String = "SoundLevel";
		public static var LIMIT_EXCEEDED : String = "LimitExceeded";
		public static var SINGLE_SOUND : String = "SingleSound";
		public static var DOUBLE_SOUND : String = "DoubleSound";
		public var level : uint;
		public var discarted : uint = 0;

		public function CompeSoundEvent(type : String, level : uint = 0, _soClose : uint = 0) {
			super(type);
			this.level = level;
			this.discarted = _soClose;
		}
	}
}
