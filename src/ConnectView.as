package
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ConnectView extends Sprite
	{
		private var _connect:Connect;
		private var _txtIp:TextField;
		private var _txtPassword:TextField;
		private var _btnConnect:MovieClip;
		
		private var _ip:String;
		private var _password:String;
		
		
		public function ConnectView()
		{
			super();
			
			_connect = new Connect;
			addChild(_connect);
			
			_txtIp = _connect['txt_ip'];
			_txtPassword = _connect['txt_password'];
			_btnConnect = _connect['btn_connect'];
			_btnConnect.addEventListener(MouseEvent.CLICK, handleButton);
			_btnConnect['txt_label'].selectable = false;
			
			ConnectionController.instance.onChange.add(handleConnection);
		}
		
		private function handleConnection($status:String):void
		{
			
			switch($status)
			{
				case ConnectionController.ENCRYPTION_SUCCESS:
				{
					_btnConnect['txt_label'].text = 'CONNECTING...';
					break;
				}
				case ConnectionController.PROGRESS:
				{
					_btnConnect['txt_label'].text = 'ENCRYPTION...';
					_btnConnect.removeEventListener(MouseEvent.CLICK, handleButton);
					_btnConnect.mouseEnabled = false;
					_btnConnect.alpha = .5;
					break;
				}
				case ConnectionController.CONNECTED:
				case ConnectionController.DISCONNECTED:
				{
					_btnConnect['txt_label'].text = 'CONNECT' +
						'';
					_btnConnect.addEventListener(MouseEvent.CLICK, handleButton);
					_btnConnect.mouseEnabled = true;
					_btnConnect.alpha = 1;
					break;
				}
			}
		}
		
		private function handleButton(e:MouseEvent):void
		{
			_ip = _txtIp.text;
			_password = _txtPassword.text;
			
			if(_ip!='' && _password!=''){
				ConnectionController.instance.connect(_ip, _password);
			}
		}
	}
}