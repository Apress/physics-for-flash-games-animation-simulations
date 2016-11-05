﻿package {	import com.physicscodes.motion.MultiForcer;	import com.physicscodes.motion.Forces;		import com.physicscodes.objects.Particle;			import com.physicscodes.math.Vector2D;	import flash.display.Sprite;	import flash.display.Graphics;	public class BubbleTurbulenceMover extends MultiForcer{				private var _particles:Array;				private var _arrowSprite:Sprite;		private var _g:Number=10;		private var _rho:Number=1;		private var _rhoP:Number=0.99;		private var _kfac:Number=0.01;		private var _windvel:Vector2D;		public function BubbleTurbulenceMover(pparticles:Array,parrowSprite:Sprite):void{			_particles = pparticles;				_arrowSprite = parrowSprite;			super(pparticles);		}							override protected function moveObject():void{			super.moveObject();			showArrow();		}		override protected function calcForce(pparticle:Particle):void{			_windvel = new Vector2D(20 + (Math.random()-0.5)*1000,(Math.random()-0.5)*1000);			var V:Number = pparticle.mass/_rhoP;			var k:Number = pparticle.width*pparticle.width*_kfac;			var gravity:Vector2D = Forces.constantGravity(pparticle.mass,_g);			var upthrust:Vector2D = Forces.upthrust(_rho,V,_g);			var relwind:Vector2D = _windvel.subtract(pparticle.velo2D);			var wind:Vector2D = Forces.drag(-k,relwind);				force = Forces.add([gravity, upthrust, wind]);										}				private function showArrow():void{			var x0:Number = 275;			var y0:Number = 200;			var scale:Number = 0.1;			with (_arrowSprite.graphics){				clear();				lineStyle(1);				drawCircle(x0,y0,2);								moveTo(x0,y0);				lineTo(scale*_windvel.x+x0,scale*_windvel.y+y0);			}					}			}}