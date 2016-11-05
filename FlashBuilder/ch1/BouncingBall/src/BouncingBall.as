package {
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BouncingBall extends Sprite {
		private var g:Number=0.1; // acceleration due to gravity
		private var vx:Number=2;  // initial horizontal speed
		private var vy:Number=0;  // initial vertical speed
		private var ball:Ball;
		
		public function BouncingBall() {
			init();
		}
		private function init():void {	
			ball = new Ball();
			ball.x = 50;
			ball.y = 75;
			addChild(ball);	
			addEventListener(Event.ENTER_FRAME,onEachTimestep); 
		}

		private function onEachTimestep(evt:Event):void{

			vy += g;      // gravity increases the vertical speed
			
			ball.x += vx; // horizontal speed increases horizontal position
			ball.y += vy; // vertical speed increases vertical position
			
			if (ball.y > 350){ // if ball hits the ground
				vy *= -0.8;    // its vertical velocity reverses and reduces
			}

		}
	}
}
