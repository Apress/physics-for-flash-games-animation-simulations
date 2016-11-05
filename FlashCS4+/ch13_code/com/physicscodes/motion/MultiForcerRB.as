﻿package com.physicscodes.motion {	import com.physicscodes.motion.Mover;	import com.physicscodes.motion.Forces;		import com.physicscodes.objects.RigidBody;	import com.physicscodes.math.Vector2D;	public class MultiForcerRB extends Mover{		private var _rigidBodies:Array;		private var _force:Vector2D;		private var _acc:Vector2D;				private var _torque:Number;				private var _alp:Number;		public function MultiForcerRB(prigidBodies:Array):void{			_rigidBodies = prigidBodies;			super(null);		}					public function get force():Vector2D {			return _force;		}							public function set force(pforce):void {			_force = pforce;		}						public function get torque():Number {			return _torque;		}							public function set torque(ptorque):void {			_torque = ptorque;		}					override protected function moveObject():void{			for (var i:uint=0; i<_rigidBodies.length; i++){				var rigidBody:RigidBody = _rigidBodies[i];				rigidBody.pos2D = rigidBody.pos2D.addScaled(rigidBody.velo2D,dt);											calcForce(rigidBody,i);				_acc = _force.multiply(1/rigidBody.mass);								rigidBody.velo2D = rigidBody.velo2D.addScaled(_acc,dt);				// including rotational dynamics in moveObject() too				_alp = _torque/rigidBody.momentOfInertia ;				rigidBody.angVelo += _alp*dt;				if (rigidBody.angVelo !=0){					rigidBody.angDispl += rigidBody.angVelo*dt;					rigidBody.rotation = rigidBody.angDispl*180/Math.PI;				}			}		}		/*				override protected function spinObject():void{			for (var i:uint=0; i<_rigidBodies.length; i++){							var rigidBody:RigidBody = _rigidBodys[i];				if (_rigidBody.angVelo !=0){					_rigidBody.angDispl += _rigidBody.angVelo*_dt;					_rigidBody.rotation = _rigidBody.angDispl*180/Math.PI;				}			}		}*/				override protected function spinObject():void{			// all code is now in moveObject()		}				protected function calcForce(prigidBody:RigidBody,pnum:uint):void{			_force = Forces.zeroForce();			_torque = 0;		}	}	}