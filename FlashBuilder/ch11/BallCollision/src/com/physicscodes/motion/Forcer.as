﻿package com.physicscodes.motion{		import com.physicscodes.motion.Mover;	import com.physicscodes.objects.Particle;			import com.physicscodes.math.Vector2D;	import com.physicscodes.motion.Forces;	public class Forcer extends Mover{				private var _particle:Particle;		private var _force:Vector2D;		private var _acc:Vector2D;			public function Forcer(pparticle:Particle):void{			_particle = pparticle;			super(pparticle);		}					public function get force():Vector2D {			return _force;		}							public function set force(pforce:Vector2D):void {			_force = pforce;		}				public function get acc():Vector2D{			return _acc;		}				override protected function moveObject():void{			super.moveObject();			calcForce();			updateAccel();			updateVelo();		}						protected function calcForce():void{			_force = Forces.zeroForce();		}				private function updateAccel():void{			_acc = _force.multiply(1/_particle.mass);		}				private function updateVelo():void{			_particle.velo2D = _particle.velo2D.addScaled(_acc,dt);						}		}	}