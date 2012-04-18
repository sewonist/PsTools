package
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class Tool extends Sprite
	{
		private var _currentTool:Sprite;
		private var _toolClasses:Vector.<Class>;
		private var _background:ToolBackground;
		private var _timer:Timer;
		private var _group:Sprite;
		private var _selectCircle:Sprite;
		
		public function Tool(... $args)
		{
			super();
			
			_toolClasses = new Vector.<Class>;
			for(var i:int = 0;i<$args.length;i++){
				_toolClasses.push($args[i]);
			}
			
			_background = new ToolBackground;
			addChild(_background);
			
			_currentTool = new _toolClasses[0]();
			addChild(_currentTool);
			
			
			
			addEventListener(MouseEvent.MOUSE_DOWN, handleThis);
			addEventListener(MouseEvent.MOUSE_UP, handleThis);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function select($className:String):void
		{
			for(var i:int = 0;i<_toolClasses.length;i++){
				if($className == getQualifiedClassName(_toolClasses[i])){
					setCurrentTool(_toolClasses[i]);
					if(_group){
						setSelectCircle();
					}
					_background['mc_select'].visible = true;
					ActionController.selectTool($className);
					return;
				} else {
					_background['mc_select'].visible = false;
					hideGroup();
				}
			}
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_background['mc_select'].visible = false;
			if( _toolClasses.length > 1 ){
				_background['mc_group'].visible = true;
				makeGroup();
			} else {
				_background['mc_group'].visible = false;
			}
		}
		
		private function makeGroup():void
		{
			
			_timer = new Timer(250, 1);
			
			_group = new Sprite;
			_group.graphics.beginFill(0xb1b1b1);			
			_group.graphics.lineStyle(1, 0x909090);
			if(y < 400){
				_group.graphics.moveTo(-x-2, 0);
				_group.graphics.lineTo(width/2-8, 0);
				_group.graphics.lineTo(width/2, -10);
				_group.graphics.lineTo(width/2+8, 0);
				_group.graphics.lineTo(320 - x, 0);
				_group.graphics.lineTo(320 - x, 72);
				_group.graphics.lineTo(-x-2, 72);
				_group.graphics.endFill();
				_group.y = height + 12;
			} else {
				_group.graphics.moveTo(-x-2, 0);
				_group.graphics.lineTo(320 - x, 0);
				_group.graphics.lineTo(320 - x, 72);
				_group.graphics.lineTo(width/2+8, 72);
				_group.graphics.lineTo(width/2, 82);
				_group.graphics.lineTo(width/2-8, 72);
				_group.graphics.lineTo(-x-2, 72);
				_group.graphics.endFill();
				_group.y = -85;
			}
			_group.alpha = 0;
			_group.visible = false;
			
			for(var i:int=0; i<_toolClasses.length;i++){
				var tool:* = new _toolClasses[i];
				tool.x = -x + (i * 53.3);
				tool.y = 8;
				tool.addEventListener(MouseEvent.CLICK, handleGroupTool);
				_group.addChild(tool);
			}
			
			
			
			_selectCircle = new Sprite;
			_selectCircle.graphics.beginFill(0x666666);
			_selectCircle.graphics.drawEllipse(0, 0, 8, 8);
			_selectCircle.graphics.endFill();
			_group.addChild(_selectCircle);
			setSelectCircle();
		}
		
		private function setSelectCircle():void
		{
			for(var i:int; i<_group.numChildren;i++){
				var test:* = _group.getChildAt(i);
				if( getQualifiedClassName(_currentTool) == getQualifiedClassName(test) ){
					_selectCircle.x = test.x + (test.width/2) - 3;
					_selectCircle.y = test.y + test.height;
				}
			}
		}
		
		private function setCurrentTool($class:Class):void
		{
			removeChild(_currentTool);
			_currentTool = null;
			_currentTool = new $class();
			addChild(_currentTool);
		}
		
		private function handleGroupTool(e:MouseEvent):void
		{
			var tempClass:Class = getDefinitionByName(getQualifiedClassName(e.currentTarget)) as Class;
			setCurrentTool(tempClass);
			
			stopTimer();
			setTool();
			hideGroup();
		}
		
		
		
		private function handleTimer(e:TimerEvent):void
		{
			stopTimer();
			viewGroup();
		}
		
		private function viewGroup():void
		{
			removeEventListener(MouseEvent.MOUSE_UP, handleThis);
			removeEventListener(MouseEvent.MOUSE_OUT, handleThis);
			addEventListener(MouseEvent.MOUSE_UP, handleSub);
			addEventListener(MouseEvent.MOUSE_OUT, handleSub);
			
			parent.setChildIndex(this, parent.numChildren-1);
			
			addChild(_group);
			_group.visible = true;
			TweenLite.to(_group, .3, {alpha:1, ease:Strong.easeOut, overwrite: true} );
		}
		
		private function handleSub(e:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_UP, handleThis);
			removeEventListener(MouseEvent.MOUSE_OUT, handleThis);
			
			addEventListener(MouseEvent.MOUSE_UP, handleThis);
		}
		
		private function hideGroup():void
		{
			if(_group){
				TweenLite.to(_group, .3, {alpha:0, ease:Strong.easeOut, onComplete:function():void
					{
						_group.visible = false;
					},
					overwrite: true
				} );
			}
		}
		
		
		private function handleThis(e:MouseEvent):void
		{
			switch(e.type)
			{
				case MouseEvent.MOUSE_DOWN:
				{
					addEventListener(MouseEvent.MOUSE_OUT, handleThis);
					setTool();
					if(_toolClasses.length>1){
						startTimer();
					}
					break;
				}
				case MouseEvent.MOUSE_OUT:
				case MouseEvent.MOUSE_UP:
				{
					if(_toolClasses.length>1){
						stopTimer();
						hideGroup();
					}
					break;
				}
				
			}
		}
		
		private function setTool():void
		{
			var className:String = getQualifiedClassName(_currentTool);
			psTools.instance.toolsView.setTool(className);
		}
		
		private function startTimer():void
		{
			_timer.addEventListener(TimerEvent.TIMER, handleTimer);
			_timer.reset();
			_timer.start();
		}
		
		private function stopTimer():void
		{
			_timer.removeEventListener(TimerEvent.TIMER, handleTimer);
			_timer.stop();
			_timer.reset();
		}
		
		
	}
}