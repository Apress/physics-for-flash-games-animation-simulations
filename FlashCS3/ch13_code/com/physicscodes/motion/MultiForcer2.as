﻿package com.physicscodes.motion {		import com.physicscodes.motion.Mover;	import com.physicscodes.objects.Particle;			import com.physicscodes.math.Vector2D;	public class MultiForcer2 extends Mover{				private var _particles:Array;		private var _force:Vector2D;		private var _acc:Vector2D;				public function MultiForcer2(pparticles:Array):void{			_particles = pparticles;			super(null);		}					public function get force():Vector2D {			return _force;		}							public function set force(pforce):void {			_force = pforce;		}						override protected function moveObject():void{			for (var i:uint=0; i<_particles.length; i++){				var particle:Particle = _particles[i];				particle.pos2D = particle.pos2D.addScaled(particle.velo2D,dt);											calcForce(particle,i);				_acc = _force.multiply(1/particle.mass);								particle.velo2D = particle.velo2D.addScaled(_acc,dt);															}		}				override protected function spinObject():void{			for (var i:uint=0; i<_particles.length; i++){				var particle:Particle = _particles[i];				if (particle.angVelo !=0){					particle.rotation += particle.angVelo*dt*180/Math.PI; 				}														}					}						protected function calcForce(pparticle:Particle,pnum:uint):void{			_force = Forces.zeroForce();		}		}	}