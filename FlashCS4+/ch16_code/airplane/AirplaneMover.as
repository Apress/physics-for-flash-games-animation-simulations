﻿package {	import com.physicscodes.motion.ForcerRB3D;	import com.physicscodes.motion.Forces3D;	import com.physicscodes.objects.PolyhedronRB;	import com.physicscodes.objects.Particle;		import flash.geom.Vector3D;	import flash.events.Event;	import flash.events.KeyboardEvent;	import flash.events.MouseEvent;	import flash.ui.Keyboard;	import flash.text.TextField;	import flash.display.Sprite;	public class AirplaneMover extends ForcerRB3D	{		// airplane and its properties; values in SI units unless otherwise stated		private var _airplane:PolyhedronRB;		private var _massAirplane:Number;		private var _areaWing:Number = 150;		private var _areaVerticalTail:Number = 20;		private var _areaHorizontalTail:Number = 6;		private var _areaAileron:Number = 4;	// area of one aileron 				private var _distVtToCM:Number = 35;	// distance from vertical tail to airplane center of mass 		private var _distAlToCM:Number = 9; 	// distance between one aileron from one side and CM ( in m)		// drag and lift coefficients		//private var _cDrag:Number = 0.03;// drag coefficient (assumed constant)		private var _cDrag:Number = 1;// drag coefficient (assumed constant)		private var _cLift:Number; // lift coefficient 				private var _dcLdalpha:Number = 5;// derivative dcLift/d(alpha) (also assumed constant)		private var _kDrag:Number;		// angles		private var _alph:Number = 0;// angle between velocity vector projected in xy plane and airplane axis (ix) 		private var _beta:Number = 0;// angle between velocity vector projected in xz plane and airplane axis (ix)		// wing angle; fixed		private var _alphWing:Number = 10*Math.PI/180; // _alphWing is the pitch of the wings w.r.t. the fuselage (ix axis)		// angle displacements of control surfaces		private var _alphEl:Number = 0.0;	// user-controlled angle displacement of elevators (horizontal tail) 		private var _alphElMax:Number = 10*Math.PI/180;	// maximum magnitude		private var _alphElInc:Number = 0.5*Math.PI/180; 	// increment				private var _alphAl:Number = 0.0;	// user-controlled angle displacement of ailerons		private var _alphAlMax:Number = 2*Math.PI/180;	// maximum magnitude		private var _alphAlInc:Number = 0.1*Math.PI/180; 	// increment				private var _alphRd:Number = 0.0;	// user-controlled angle displacement of rudder (vertical tail) 		private var _alphRdMax:Number = 10*Math.PI/180;	// maximum magnitude		private var _alphRdInc:Number = 0.5*Math.PI/180; 	// increment						// thrust		private var _thrustMag:Number = 0;	// thrust is user-controllable		private var _thrustMax:Number = 300000; // maximum thrust magnitude		private var _thrustInc:Number = 10000; // thrust increment			// environmental parameters		private var _g:Number = 10; // gravity		private var _rho:Number = 1.0; // air density (decreases with height; smaller constant value assumed here)		private var _kAng:Number = 0.2; // angular damping factor							private var _groundLevel:Number = 600;	// location of ground in pixels		// textfields for displaying flight info		private var _txtAltitude:TextField;		private var _txtLocation:TextField;		private var _txtHorizontalVelo:TextField;		private var _txtVerticalVelo:TextField;		private var _txtControls:TextField;				public function AirplaneMover(pairplane:PolyhedronRB):void		{			_airplane = pairplane;			_massAirplane = _airplane.mass;			_kDrag = 0.5*_rho*_areaWing*_cDrag;			_airplane.stage.addEventListener(KeyboardEvent.KEY_DOWN,startControl);			setupDisplay();						super(_airplane);		}		private function setupDisplay():void{			_txtAltitude = new TextField();			_txtAltitude.x = 600;			_txtAltitude.y = 50;			_txtAltitude.width = 200;			_airplane.stage.addChild(_txtAltitude);			_txtVerticalVelo = new TextField();			_txtVerticalVelo.x = 600;			_txtVerticalVelo.y = 100;			_txtVerticalVelo.width = 200;			_airplane.stage.addChild(_txtVerticalVelo);							_txtLocation = new TextField();			_txtLocation.x = 600;			_txtLocation.y = 150;			_txtLocation.width = 200;			_airplane.stage.addChild(_txtLocation);						_txtHorizontalVelo = new TextField();			_txtHorizontalVelo.x = 600;			_txtHorizontalVelo.y = 200;			_txtHorizontalVelo.width = 200;			_airplane.stage.addChild(_txtHorizontalVelo);						_txtControls = new TextField();			_txtControls.x = 50;			_txtControls.y = 50;			_txtControls.width = 200;			_airplane.stage.addChild(_txtControls);						updateDisplay();		}				private function updateDisplay():void{			_txtAltitude.text = "Altitude = " + Math.round(_groundLevel-_airplane.y);			_txtVerticalVelo.text = "Vertical velocity = " + Math.round(_airplane.vy*10)/10;												_txtLocation.text = "Location = (" + Math.round(_airplane.x) + ", " + Math.round(_airplane.z) + ")";			_txtHorizontalVelo.text = "Horizontal velocity = (" + Math.round(_airplane.vx*10)/10 + ", " + Math.round(_airplane.vz*10)/10 + ")";		}		override protected function moveObject():void{			super.moveObject();			updateObject();			updateDisplay();		}				private function updateObject():void{			var vec:Vector3D = _airplane.angVelo;			vec.scaleBy(dt);			_airplane.clear();			_airplane.updatePolyhedron(vec.x,vec.y,vec.z);		}		private function startControl(evt:KeyboardEvent):void		{			// Horizontal tail (elevators) control: pitch 			if (evt.keyCode == Keyboard.UP){				if (_alphEl < _alphElMax){ // maximum elevator angle					_alphEl += _alphElInc;				}				_txtControls.text = "Elevators angle = " + Math.floor(_alphEl*180/Math.PI*10)/10;			}			if (evt.keyCode == Keyboard.DOWN){				if (_alphEl > -_alphElMax){ // minimum elevator angle					_alphEl += -_alphElInc;				}				_txtControls.text = "Elevators angle = " + Math.floor(_alphEl*180/Math.PI*10)/10;			}			// Aileron control: roll			if (evt.keyCode == Keyboard.LEFT){				if (_alphAl > -_alphAlMax){ // minimum aileron angle 					_alphAl += -_alphAlInc;				}				_txtControls.text = "Ailerons angle = " + Math.floor(_alphAl*180/Math.PI*10)/10;			}			if (evt.keyCode == Keyboard.RIGHT){				if (_alphAl < _alphAlMax){ // maximum aileron angle 					_alphAl += _alphAlInc;				}				_txtControls.text = "Ailerons angle = " + Math.floor(_alphAl*180/Math.PI*10)/10;			}						// Vertical tail (rudder) control: yaw			if (evt.keyCode == Keyboard.CONTROL){				if (_alphRd > -_alphRdMax){ // minimum rudder angle					_alphRd += -_alphRdInc;				}				_txtControls.text = "Rudder angle = " + Math.floor(_alphRd*180/Math.PI*10)/10;			}			if (evt.keyCode == Keyboard.SHIFT){				if (_alphRd < _alphRdMax){ // maximum rudder angle					_alphRd += _alphRdInc;				}				_txtControls.text = "Rudder angle = " + Math.floor(_alphRd*180/Math.PI*10)/10;			}			// thrust control			if (evt.keyCode == Keyboard.SPACE){				if (Keyboard.capsLock){					if (_thrustMag > 0){						_thrustMag += -_thrustInc;					}				}else{					if (_thrustMag < _thrustMax){						_thrustMag += _thrustInc;					}				}				_txtControls.text = "Thrust = " + _thrustMag;			}		}		override protected function calcForce():void		{			// update plane axes			var ix:Vector3D = _airplane.ix;// unit vector of x axis of airplane; 			var iy:Vector3D = _airplane.iy;// unit vector of y axis of airplane; 			var iz:Vector3D = _airplane.iz;// unit vector of z axis of airplane; 						// *** forces on whole plane ***			if(_airplane.ypos < _groundLevel){				force = Forces3D.constantGravity(_massAirplane,_g);	// gravity			}else{				force= new Vector3D(0,0,0); // reaction from the ground cancels gravity			}			force=force.add(Forces3D.drag(_kDrag,_airplane.velo)); // add drag			var thrust:Vector3D; 			if (_thrustMag > 0){				thrust = ix.clone();				thrust.scaleBy(_thrustMag);			}else{				thrust = new Vector3D(0,0,0);			}			force = force.add(thrust); // add thrust						// *** torques on whole plane ***			torque = new Vector3D(0,0,0); // gravity, drag and thrust don't have torques						// but let's add angular damping for stability			var vec:Vector3D = _airplane.angVelo;			vec.scaleBy(-_kAng);			torque = torque.add(vec);									// *** Now we consider the lift forces and torques on wings and control surfaces ***			if (_airplane.velo.length > 0){ // no lift if velocity is zero				var viX:Number = _airplane.velo.dotProduct(ix);// velocity of airplane along its x-axis 				var viY:Number = _airplane.velo.dotProduct(iy);// velocity of airplane along its y-axis				var viZ:Number = _airplane.velo.dotProduct(iz);// velocity of airplane along its z-axis 				                                                 				var vecX:Vector3D = ix.clone();				var vecY:Vector3D = iy.clone();				vecY.scaleBy(viY);				vecX.scaleBy(viX);				var viXY:Vector3D = vecX.add(vecY); // velocity of the airplane in the airplane xy plane 				                                                				vecX = ix.clone();				var vecZ:Vector3D = iz.clone();				vecX.scaleBy(viX);				vecZ.scaleBy(viZ);				var viZX:Vector3D = vecX.add(vecZ); // velocity of the airplane in the airplane xz plane 								// calculate angle of attack and lateral angle				_alph = Math.atan2(viY,viX); // so, the angle of attack				if ((viY==0) && (viX==0)){					_alph = 0;				}				_beta = Math.atan2(viZ,viX);// lateral angle				if ((viZ==0) && (viX==0)){					_beta = 0;				}				// force: lift on the Wing				var veloXY:Vector3D = viXY.clone();				veloXY = veloXY.crossProduct(iz);				if (Math.abs(_alph+_alphWing) > 20*Math.PI/180){					_cLift = 1.2*_alph/Math.abs(_alph)  // impose limit on _cLift				}else{					_cLift = _dcLdalpha*(_alph+_alphWing); 				}				veloXY.scaleBy(0.5*_rho*viXY.length*_areaWing*_cLift);				var liftW:Vector3D = veloXY.clone();				force = force.add(liftW);							// assume no overall torque generated by lift on main wings							// *** lift forces and torques on control surfaces ***				// force: ailerons; form a couple, so no net force  				// torque: ailerons				veloXY = viXY.clone();				veloXY = veloXY.crossProduct(iz);				veloXY.scaleBy(0.5*_rho*viXY.length*_areaAileron*_dcLdalpha*(_alphAl));				var liftAl:Vector3D = veloXY.clone(); // lift on one aileron only 				var ptorque:Vector3D = iz.crossProduct(liftAl);// T = r x F, r is in the direction of iz, along the wing 				ptorque.scaleBy(_distAlToCM*2); // factor of 2 because two ailerons contribute twice the torque				torque = torque.add(ptorque);				// force: horizontal tail (elevators); same formula as for the wing 				veloXY = viXY.clone();				veloXY = veloXY.crossProduct(iz); // the circulation vector has the same direction iz				if(Math.abs(_alphEl+_alph) > 20*Math.PI/180){					_cLift = 1.2*(_alphEl+_alph)/Math.abs(_alphEl+_alph)  // impose limit on _cLift				}else{					_cLift = _dcLdalpha*(_alphEl+_alph); 				}								veloXY.scaleBy(0.5*_rho*viXY.length*_areaHorizontalTail*_cLift);				var liftHt:Vector3D = veloXY.clone();				force = force.add(liftHt);				// torque: horizontal tail				ptorque = ix.crossProduct(liftHt); // T = r x liftHt; r being in the direction of ix axis				ptorque.scaleBy((-1)*_distVtToCM); // note negative distance along ix axis, ie. towards the rear of airplane				torque = torque.add(ptorque);				// force: vertical tail (rudder); same formula as for the wing;				var veloZX:Vector3D = viZX.clone();				veloZX = veloZX.crossProduct(iy); // note that the axis of the vertical tail is vertical, ie. along iy axis.				if(Math.abs(_alphRd+_beta) > 20*Math.PI/180){					_cLift = 1.2*(_alphRd+_beta)/Math.abs(_alphRd+_beta)  // impose limit on _cLift				}				else{					_cLift = _dcLdalpha*(_alphRd+_beta); //_beta will act as aerodymanic damping				}				veloZX.scaleBy(-0.5*_rho*viZX.length*_areaVerticalTail*_cLift); 				var _liftVt:Vector3D = veloZX.clone();				force = force.add(_liftVt);				// torque: vertical tail				ptorque = ix.crossProduct(_liftVt);// T = r x liftVt ; note that r is in the direction of ix 				ptorque.scaleBy(-_distVtToCM);				torque = torque.add(ptorque); 			}		}			}}