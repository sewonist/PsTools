package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(frameRate="30", backgroundColor="#D6D6D6")] 
	public class psTools extends Sprite
	{
		static private var _instance:psTools;
		
		public var headerView:HeaderView;
		public var toolsView:ToolsView;
		public var connectView:ConnectView;
		
		public function psTools()
		{
			super();
			
			_instance = this;
			
			if(stage) init(null);
			else {addEventListener(Event.ADDED_TO_STAGE, init);}
		}
		
		final private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.align = StageAlign.TOP_LEFT;  
			initLayout();
		}
	
		private function initLayout():void
		{
			toolsView = new ToolsView;
			toolsView.visible = false;
			addChild(toolsView);
			
			connectView = new ConnectView;
			addChild(connectView);
			
			headerView = new HeaderView;
			addChild(headerView);
			
			width = stage.stageWidth;
			height = 480 * (width/320);
			
			ConnectionController.instance.onChange.add(handleConnection);
		}
		
		private function handleConnection($status:String):void
		{
			
			switch($status)
			{
				case ConnectionController.DISCONNECTED:
				case ConnectionController.PROGRESS:
				{
					toolsView.visible = false;
					connectView.visible = true;
					break;
				}
				case ConnectionController.CONNECTED:
				{
					toolsView.visible = true;
					connectView.visible = false;
					break;
				}
			}
		}
		
		static public function get instance():psTools
		{
			return _instance;
		}
	}
}