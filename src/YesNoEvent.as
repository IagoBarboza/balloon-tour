package {
	import flash.events.Event;

	/**
	 * @author Ibs
	 */
	public class YesNoEvent extends Event {
		public static var YES_PRESSED: String = "yesPressed";
		public static var NO_PRESSED:String = "noPressed";
		public function YesNoEvent(type : String) {
			super(type, false, false);
		}
	}
}
