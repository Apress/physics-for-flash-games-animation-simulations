﻿package com.physicscodes.objects {	import flash.display.Sprite;			public class Spot extends Particle{				private var _radius:Number;		private var _color:uint;			private var _sprite:Sprite;				public function Spot(pradius:Number=20,pcolor:uint=0x006600,pmass:Number=1,pcharge:Number=0){			this.mass=pmass;			this.charge=pcharge;						_radius=pradius;			_color=pcolor;					_sprite = new Sprite();						drawBall();		}		private function drawBall():void{			with (_sprite.graphics){					beginFill(_color);				drawCircle(0,0,_radius);				endFill();			}			addChild(_sprite);		}						public function clear():void{			_sprite.graphics.clear();			removeChild(_sprite);		}		public function get radius():Number{			return _radius;		}				public function set radius(pradius:Number):void{			_radius = pradius;			clear();			drawBall();		}				public function get color():Number{			return _color;		}				public function set color(pcolor:Number):void{			_color = pcolor;			clear();			drawBall();		}			}	}