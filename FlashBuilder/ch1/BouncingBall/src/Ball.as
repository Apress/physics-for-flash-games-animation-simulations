package{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class Ball extends Sprite{
		
		private var _radius:Number;
		private var _color:uint;
		
		public function Ball(radius:Number=20,color:uint=0x0000ff){
			_radius=radius;
			_color=color;
			init();
		}
		
		private function init():void{
			var sprite:Sprite = new Sprite();
			var matrix:Matrix = new Matrix();
			
			matrix.createGradientBox(_radius,_radius,0,-_radius,-_radius/2);
			
			with (sprite.graphics){
				beginGradientFill(GradientType.RADIAL,[0xffffff,_color],[1,1],[0,255],matrix);
				drawCircle(0,0,_radius);
				endFill();
			}
			addChild(sprite);
		}
		
	}
	
}
