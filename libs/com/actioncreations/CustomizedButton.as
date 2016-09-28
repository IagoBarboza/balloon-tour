package com.actioncreations {
	import flash.display.MovieClip;
	import flash.events.*;

	public class CustomizedButton extends MovieClip
	{
		private var _canMoveBackwards : Boolean;
		private var _isAvailable : Boolean;

		public function CustomizedButton()
		{
			this.stop();
			_isAvailable = true;
			createButtonFuncionality();
		}

		private function createButtonFuncionality() : void
		{
			this.buttonMode = true;
			this.mouseEnabled = true;
			this.mouseChildren = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}

		private function removeButtonFuncionality() : void
		{
			this.buttonMode = false;
			this.mouseEnabled = false;
			this.mouseChildren = false;
			removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onOut);
		}

		public function get available() : Boolean
		{
			return _isAvailable;
		}

		public function set available(value : Boolean) : void
		{
			if (value)
			{
				onOut();
				createButtonFuncionality();
			}
			else
			{
				onOver();
				removeButtonFuncionality();
			}

			_isAvailable = value;
		}

		public function onOver(event : MouseEvent = null) : void
		{
			// animate timeline forward
			_canMoveBackwards = false;
			this.addEventListener(Event.ENTER_FRAME, timelineControl);
		}

		public function onOut(event : MouseEvent = null) : void
		{
			// animate timeline backwards
			_canMoveBackwards = true;
			this.addEventListener(Event.ENTER_FRAME, timelineControl);
		}

		public function timelineControl(event : Event) : void
		{
			if (_canMoveBackwards) // if the mouse is OVER
			{
				this.prevFrame();
			}
			else
			{
				this.nextFrame();
			}
			
			// if it's in the end
			if (this.currentFrame == this.totalFrames)
			{
				this.removeEventListener(Event.ENTER_FRAME, timelineControl);
				this.alpha -= .001; this.alpha += .001;
			}

			// if it's in the beginning
			if ((this.currentFrame == 1) && (_canMoveBackwards))
			{
				this.removeEventListener(Event.ENTER_FRAME, timelineControl);
			}
		}
	}
}