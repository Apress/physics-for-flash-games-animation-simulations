﻿package {	import flash.display.Sprite;		import flash.events.Event;		public class CollidingBalls extends Sprite {		private var g:Number=0.1; // acceleration due to gravity		private var balls:Array;		private var rSquare:Number=1600; // radius of balls is 20, so (2*radius) squared is 1600		private var numBalls:int=5;		public function CollidingBalls() {			init();		}		private function init():void {					balls = new Array();			for (var i:uint=0; i<numBalls; i++){				var ball:Ball = new Ball();					ball.x = 50 + 100*i;				ball.y = 75;				ball.vx = (Math.random()-0.5)*10;				ball.vy = (Math.random()-0.5)*4;				addChild(ball);					balls.push(ball);			}			addEventListener(Event.ENTER_FRAME,onEachTimestep); 		}		private function onEachTimestep(evt:Event):void{			for (var i:uint=0; i<balls.length; i++){				var ball:Ball = balls[i];				ball.vy += g;     							ball.x += ball.vx; 				ball.y += ball.vy; 							if (ball.y > 350){					ball.y = 350;					ball.vy *= -0.8;   				}								// collisions between balls!				for (var j:Number=i+1; j<balls.length; j++){					var ballTest:Ball = balls[j];					var dx:Number = ball.x - ballTest.x;					var dy:Number = ball.y - ballTest.y;					var distSquare:Number = dx*dx + dy*dy;					if (distSquare <= rSquare){						// for now, the balls are actually bouncy bubbles!						ball.visible=false;						ballTest.visible=false;					}				}			}		}	}}