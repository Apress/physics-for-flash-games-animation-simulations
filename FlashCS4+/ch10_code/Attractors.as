﻿package{	import flash.display.Sprite;	import com.physicscodes.objects.Ball;	import com.physicscodes.math.Vector2D;		import com.physicscodes.objects.Particle;	public class Attractors extends Sprite{		public function Attractors():void{			init();		}		private function init():void{			var G:Number = 1; // Gravitational constant									// create a fixed attractor			var center:Ball;			center = new Ball(20,0x0099ff,1000000);			center.pos2D = new Vector2D(300,300);						addChild(center);						// create another fixed attractor			var center2:Ball;			center2 = new Ball(20,0x0099ff,1000000);			center2.pos2D = new Vector2D(500,300);						addChild(center2);						// create another fixed attractor//			var center3:Ball;//			center3 = new Ball(20,0x0099ff,1000000);//			center3.pos2D = new Vector2D(400,400);			//			addChild(center3);			// create an orbiter			var orbiter:Ball;			orbiter = new Ball(8,0x999999,1);//			orbiter.pos2D = new Vector2D(400,300);	//			orbiter.velo2D = new Vector2D(0,60);	//		orbiter.pos2D = new Vector2D(400,400);	//		orbiter.velo2D = new Vector2D(10,60);	//		orbiter.velo2D = new Vector2D(120,0);				orbiter.pos2D = new Vector2D(300,400);			orbiter.velo2D = new Vector2D(90,0);			addChild(orbiter);			// make the orbiter move//			var attractor:Attractor=new Attractor(orbiter,[center, center2, center3],G);					var attractor:Attractor=new Attractor(orbiter,[center, center2],G);					attractor.startTime(10);					}	}}