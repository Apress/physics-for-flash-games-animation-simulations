﻿package{	import flash.display.Sprite;	import com.physicscodes.objects.Ball;	import com.physicscodes.math.Vector2D;			public class MultipleBallCollision extends Sprite{		public function MultipleBallCollision():void{			init();		}		private function init():void{			var center:Vector2D = new Vector2D(stage.stageWidth/2,stage.stageHeight/2);			var balls:Array=new Array();			for(var i:uint = 0; i < 9; i++){				var ball:Ball = new Ball(15,0xffffff*Math.random(),1);				ball.pos2D = new Vector2D(Math.random()*stage.stageWidth, Math.random()*stage.stageHeight);				ball.velo2D = center.subtract(ball.pos2D).multiply(0.2);				addChild(ball);				balls.push(ball);		    }						var collider:MultiBallCollider=new MultiBallCollider(balls);			collider.startTime();		}	}}