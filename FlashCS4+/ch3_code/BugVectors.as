﻿package{	import flash.display.Sprite;	import flash.utils.Timer;	import flash.events.TimerEvent;		public class BugVectors extends Sprite{				private var bug:Bug;			private var xorig=50;		private var yorig=350;		private var arrow1:Arrow;		private var arrow2:Arrow;		private var arrow3:Arrow;						public function BugVectors(){			init();			trace(Math.sqrt(341.4)*15);		}		private function init():void{			plotGraph();			placeArrows();			placeBug();					}		private function plotGraph():void{			var graph:Graph = new Graph(0,20,0,20,xorig,yorig,300,300);						graph.drawgrid(10,1,10,1);						graph.drawaxes('x','y');			addChild(graph);				}		private function placeBug():void{			bug = new Bug();			bug.width *= 0.2;			bug.height *= 0.2;			bug.x = xorig;			bug.y = yorig;			addChild(bug);					}		private function placeArrows():void{			arrow1 = new Arrow(xorig,yorig,150,-90,0xff0000);			addChild(arrow1);			//arrow2 = new Arrow(xorig,yorig-150,150,0,0xff0000);			arrow2 = new Arrow(xorig,yorig-150,150,-45,0xff0000);			addChild(arrow2);						//arrow3 = new Arrow(xorig,yorig,212,-45,0x00ff00);			arrow3 = new Arrow(xorig,yorig,277,-67.5,0x00ff00);			addChild(arrow3);					}	}}