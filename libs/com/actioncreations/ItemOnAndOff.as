package com.actioncreations {	import flash.display.MovieClip;	import flash.events.*;	public class ItemOnAndOff extends MovieClip	{		private var overGoActive : Boolean = false;		public function ItemOnAndOff()		{			this.stop();		}		public function turnOn() : void		{			playTimeline();		}		public function turnOff() : void		{			rewindTimeline();		}		public function playTimeline() : void		{			//animate timeline forward			this.addEventListener(Event.ENTER_FRAME, timelineControl);			overGoActive = true;		}		public function rewindTimeline() : void		{			//animate timeline backwards			overGoActive = false;			this.addEventListener(Event.ENTER_FRAME, timelineControl);		}		public function timelineControl(event : Event) : void		{			//trace("running");			if (overGoActive) //if the mouse is OVER			{				this.nextFrame();			} 			else			{				this.prevFrame();			}						if (this.currentFrame == this.totalFrames) //if it's in the end			{				this.removeEventListener(Event.ENTER_FRAME, timelineControl);				//trace("removed");			}						if ((this.currentFrame == 1) && (!overGoActive)) //if it's in the beginning			{				this.removeEventListener(Event.ENTER_FRAME, timelineControl);				//trace("removed");			}		}		}}