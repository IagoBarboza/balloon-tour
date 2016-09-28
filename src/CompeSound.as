package {
	import flash.events.EventDispatcher;
	import flash.events.SampleDataEvent;
	import flash.events.TimerEvent;
	import flash.media.Microphone;
	import flash.utils.Timer;

	/**
	 * @author rodrigopex
	 */
	class CompeSound extends EventDispatcher {
		private var __clickTimer : Timer;
		private var __timer : Timer;
		private var __delay : uint = 200;
		private var __mic : Microphone;
		private var __levelLimit : uint;
		public var lastExceededLimit : uint;
		public var lastExceededTimerCount : uint;
		public var currentLevel : uint;
		
		public function CompeSound(mic : Microphone, levelLimit : uint = 30, delay : uint = 50) {
			super();
			__delay = delay;
			__levelLimit = levelLimit;
			__mic = mic;
			__mic.addEventListener(SampleDataEvent.SAMPLE_DATA, updateCurrentLevel, false, 0, true);
			__timer = new Timer(__delay, 1);
			__timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerEnd);
			//__timer.start();
			__clickTimer = new Timer(400, 1);
			__clickTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onClickTimerComplete, false, 0, true);
		}

		public function start() : void
		{
			this.__timer.start();
		}
		
		public function stop() : void
		{
			this.__timer.stop();
		}
		
		private function updateCurrentLevel(event : SampleDataEvent) : void {
			currentLevel = __mic.activityLevel;
		}

		public function get delay() : uint {
			return __delay;
		}
		
		public function get currentCount() : uint {
			return __timer.currentCount;
		}

		public function set delay(_delay : uint) : void {
			__timer.stop();
			__timer.delay = __delay = _delay;
			__timer.start();
		}

		public function get levelLimit() : uint {
			return __levelLimit;
		}

		public function set levelLimit(_levelLimit : uint) : void {
			__levelLimit = _levelLimit;
		}

		protected function onTimerEnd(event : TimerEvent) : void {
			this.dispatchEvent(new CompeSoundEvent(CompeSoundEvent.SOUND_LEVEL, currentLevel));
			if (currentLevel > __levelLimit) {
				if (lastExceededTimerCount + 1 < __timer.currentCount) {
					palma();
					lastExceededLimit = currentLevel;
					lastExceededTimerCount = __timer.currentCount;
					this.dispatchEvent(new CompeSoundEvent(CompeSoundEvent.LIMIT_EXCEEDED, currentLevel));
				} else {
				    this.dispatchEvent(new CompeSoundEvent(CompeSoundEvent.LIMIT_EXCEEDED, currentLevel, 1));
				}
			}
			__timer.start();
		}

		private function onClickTimerComplete(event : TimerEvent) : void {
			this.dispatchEvent(new CompeSoundEvent(CompeSoundEvent.SINGLE_SOUND, lastExceededLimit));
		}

		private function palma() : void {
			if (__clickTimer.running) {
				this.dispatchEvent(new CompeSoundEvent(CompeSoundEvent.DOUBLE_SOUND));
				__clickTimer.stop();
			} else {
				__clickTimer.start();
			}
		}
	}
}
