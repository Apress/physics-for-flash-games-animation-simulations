﻿package {	import flash.display.Sprite;	import com.physicscodes.motion.MultiForcer;	import com.physicscodes.motion.Forces;		import com.physicscodes.objects.Particle;	import com.physicscodes.objects.Ball;		import com.physicscodes.math.Vector2D;	import flash.events.MouseEvent;			public class FireworksMover2 extends MultiForcer{		private var _sprite:Sprite;		private var _particles:Array = new Array();		private var _maxParticles:uint = 200;				private var _g:Number = 10;		private var _k:Number = 0.005;		private var _vx:Number = 150;		private var _vy:Number = -100;		// number of sparks per explosion		private var _numSparks:uint	= 0;			//minimum and maximum lifetime of sparks in seconds		private var _minLife:Number = 2;		private var _maxLife:Number = 4;		//maximum duration of fireworks in seconds		private var _duration:Number = 6;				private var _startTime:Number=0;				public function FireworksMover2(psprite:Sprite):void{					_sprite = psprite;			_sprite.stage.addEventListener(MouseEvent.MOUSE_DOWN,onDown);															super(_particles);		}					private function onDown(e:MouseEvent):void{			_sprite.stage.addEventListener(MouseEvent.MOUSE_UP,onUp);			_startTime = time;		}		private function onUp(e:MouseEvent):void{			_sprite.stage.removeEventListener(MouseEvent.MOUSE_UP,onUp);			var elapsed:Number = time - _startTime;			_numSparks = Math.floor(elapsed);			createNewParticles(new Vector2D(_sprite.mouseX,_sprite.mouseY),0xffff00);			startTime();		}								override protected function calcForce(pparticle:Particle):void{			var gravity:Vector2D = Forces.constantGravity(pparticle.mass,_g);				var drag:Vector2D = Forces.drag(_k,pparticle.velo2D);			force = Forces.add([gravity, drag]);		}				override protected function moveObject():void{			super.moveObject();			limitParticles();						ageParticles();		}				private function createNewParticles(ppos:Vector2D,pcol:uint):void{			for (var i:uint=0; i<_numSparks; i++){				var newBall:Ball = new Ball(2,pcol,1,0,false);				newBall.pos2D = ppos;				newBall.velo2D = new Vector2D((Math.random()-0.5)*_vx,(Math.random()-0.5)*_vy);				newBall.lifetime = _minLife + (_maxLife-_minLife)*Math.random();				_sprite.addChild(newBall);				_particles.push(newBall);			}		}				private function limitParticles():void{			if (_particles.length > _maxParticles){				_sprite.removeChild(_particles[0]);				_particles.shift();			}		}			private function ageParticles():void{			for (var i:uint=0; i<_particles.length; i++){				var particle:Ball = _particles[i];				particle.age += dt;				particle.alpha += -0.005;				if (particle.age > particle.lifetime){					if (time<_duration){						explode(particle);					}					removeParticle(particle,i);				}			}		}					private function explode(pparticle:Particle):void{			createNewParticles(pparticle.pos2D,0xffffff*Math.random());		}				private function removeParticle(pparticle:Particle,pnum:uint):void{			_sprite.removeChild(pparticle);			_particles.splice(pnum,1);		}			}}