package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class HeaderView extends Sprite
	{
		private var _logo:Logo;
		private var _statusIcon:StatusIcon;
		private var _partition:Partition;
		private var _status:String;
		
		public function HeaderView()
		{
			super();
			
			_logo = new Logo;
			_logo.x = 18;
			_logo.y = 6;
			addChild(_logo);
			
			_statusIcon = new StatusIcon;
			_statusIcon.x = 287;
			_statusIcon.y = 18;
			addChild(_statusIcon);
			_statusIcon.addEventListener(MouseEvent.CLICK, handleStatus);
			
			_partition = new Partition;
			_partition.x = 20;
			_partition.y = 45;
			addChild(_partition);
			
			ConnectionController.instance.onChange.add(handleConnection);
		}
		
		private function handleStatus(e:MouseEvent):void
		{
			if(_status == ConnectionController.CONNECTED){
				Main.instance.toolsView.visible = !Main.instance.toolsView.visible;
				Main.instance.connectView.visible = !Main.instance.connectView.visible;
			}
		}
		
		private function handleConnection($status:String):void
		{
			switch($status)
			{
				case ConnectionController.DISCONNECTED:
				{
					_statusIcon.gotoAndStop(1);
					break;
				}
				case ConnectionController.PROGRESS:
				{
					_statusIcon.gotoAndStop(2);
					break;
				}
				case ConnectionController.CONNECTED:
				{
					_statusIcon.gotoAndStop(3);
					break;
				}
			}
			
			_status = $status;
		}
		
	}
}