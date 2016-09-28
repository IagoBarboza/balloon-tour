package {
	import fl.controls.Button;
	import fl.controls.TextInput;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ScoreWindow extends MovieClip
	{
		public var score : TextField = new TextField();
		public var format : TextFormat = new TextFormat();
		public var textInput : TextInput;
		public var okButton : Button;
		public var nome : String;
		public var scoreString : String;
		public var textFormat : TextFormat = new TextFormat();
		
		public function ScoreWindow()
		{
			textFormat.size = 30;
			
			textInput.maxChars = 12;
			textInput.setStyle("Style1", textFormat);
			
			format.size = 30;
			format.font = "hooge 05_53";
			format.color = 0xFFFFFF;
			score.defaultTextFormat = format;
			score.x = -38;
			score.y = -100;
			score.width = 300;
			this.x = 512;
			this.y = 600;
			
			addChild(score);
			scoreString = score.text;
			
			// event listeners
			okButton.addEventListener(MouseEvent.CLICK, okPressed);	
		}

		private function okPressed(event : MouseEvent) : void
		{
			nome = textInput.text;
			dispatchEvent(new Event("OKScoreWindowPressed"));
			dispatchEvent(new Event("scoreOkPressed"));
		}

		public function PlayerName() : String
		{
			return nome;
		}

		public function setScore(text : String) : void
		{
			score.text = text;		
		}
		
	}
}
