﻿package com.physicscodes.motion{	import com.physicscodes.math.Vector2D;	public class Forces {		public function Forces():void {		}		static public function zeroForce():Vector2D {			return (new Vector2D(0,0));		}		static public function constantGravity(m:Number,g:Number):Vector2D {			return new Vector2D(0,m*g);		}		static public function gravity(G:Number,m1:Number,m2:Number,r:Vector2D):Vector2D {			return r.multiply(-G*m1*m2/(r.lengthSquared*r.length));		}				static public function linearDrag(k:Number,vel:Vector2D):Vector2D {			var force:Vector2D;			var velMag:Number=vel.length;			if (velMag>0) {				force=vel.multiply(-k);			}			else {				force=new Vector2D(0,0);			}			return force;		}		static public function drag(k:Number,vel:Vector2D):Vector2D {			var force:Vector2D;			var velMag:Number=vel.length;			if (velMag>0) {				force=vel.multiply(-k*velMag);			}			else {				force=new Vector2D(0,0);			}			return force;					}		static public function lift(k:Number,vel:Vector2D):Vector2D {			var force:Vector2D;			var velMag:Number=vel.length;			if (velMag>0) {				force=vel.perp(k*velMag);			}			else {				force=new Vector2D(0,0);			}			return force;					}					static public function upthrust(rho:Number,V:Number,g:Number):Vector2D {			return new Vector2D(0,-rho*V*g);		}		    static public function vortex(k:Number,r0:Number,r:Vector2D):Vector2D{			var force:Vector2D;			var rMag:Number=r.length;			if (rMag > 0){				if (rMag > r0) {					force=r.multiply(-k*Math.pow(r0/rMag,4));				}else{					force=r.multiply(k);				}			}else{				force=new Vector2D(0,0);			}			return force;		}			static public function add(arr:Array):Vector2D {			var forceSum:Vector2D = new Vector2D(0,0);			for (var i:uint=0; i<arr.length; i++){				var force:Vector2D = arr[i];				forceSum.incrementBy(force);			}			return forceSum;		}	}}