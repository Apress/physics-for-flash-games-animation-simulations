﻿package{	import flash.display.Sprite;	import com.physicscodes.objects.Ball;	import com.physicscodes.math.Vector2D;		import com.physicscodes.objects.Particle;	public class FloatingBall extends Sprite{		public function FloatingBall():void{			init();		}		private function init():void{			// create a ball					var ball:Ball;			ball = new Ball(20,0x0000ff,1);			ball.pos2D = new Vector2D(50,50);			ball.velo2D = new Vector2D(40,-20);						addChild(ball);											// create water			var water:Sprite = new Sprite;			with (water.graphics) {				beginFill(0x00ffff,0.5);				drawRect(0,100,stage.stageWidth,stage.stageHeight-100);				endFill();					}			addChild(water);			// make the ball move			var floater:Floater=new Floater(ball);					floater.startTime(10);		}	}}