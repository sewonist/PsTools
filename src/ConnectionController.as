package
{
	import com.adobe.photoshop.connection.PhotoshopConnection;
	import com.adobe.photoshop.dispatchers.MessageDispatcher;
	import com.adobe.photoshop.events.PhotoshopEvent;
	import com.adobe.photoshop.events.PhotoshopMessageEvent;
	import com.adobe.photoshop.messages.TextMessage;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import idv.cjcat.signals.ISignal;
	import idv.cjcat.signals.Signal;

	public class ConnectionController
	{
		static public const DISCONNECTED:String = 'disconnected';
		static public const PROGRESS:String = 'progress';
		static public const CONNECTED:String = 'connected';
		static public const ENCRYPTION_SUCCESS:String = 'encyrptionSuccess';
		
		static private var _instance:ConnectionController;
		static private var _singleton_lock:Boolean = false;
		
		private var _ip:String = '';
		private var _password:String = '';
		private var _connection:PhotoshopConnection;
		private var _onChange:ISignal = new Signal(String);
		
		
		public function ConnectionController()
		{
			if ( !_singleton_lock ) throw new Error( 'Use ConnectionController.instance' );
			
			_onChange.dispatch(DISCONNECTED);
		}
		
		public function connect($ip:String, $password:String):void
		{
			if($ip=='demo' && $password == 'Passw0rd'){
				handleConnection(null);
				return;
			}
			
			if (!_connection || _ip != $ip) {
				_onChange.dispatch(PROGRESS);
				
				_ip = $ip;
				_password = $password;
				
				_connection = null;
				var conn:PhotoshopConnection = new PhotoshopConnection();
				conn.addEventListener(PhotoshopEvent.ERROR, handleError, false, 0, true);		
				conn.addEventListener(PhotoshopEvent.CONNECTED, handleConnection, false, 0, true);
				conn.addEventListener(PhotoshopEvent.DISCONNECTED, handleError, false, 0, true);
				conn.addEventListener(PhotoshopEvent.ENCRYPTION_SUCCESS, handleEncrypt, false, 0, true);
				
				conn.addEventListener(PhotoshopMessageEvent.MESSAGE_RECEIVED, handleMessage, false, 0, true);
				conn.addEventListener(PhotoshopMessageEvent.MESSAGE_SENT, handleMessage, false, 0, true);
				
				_connection = conn;
				
				// Encryption take a bit of time, delay to let UI rendering the text above
				// then do the encryption
				var timer:Timer = new Timer(100, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, delayForEncrypt);
				timer.start();
			} else {
				handleConnection(null);
			}
		}
		
		private function handleMessage(e:PhotoshopMessageEvent):void
		{
			if(e.message!=null && e.message is TextMessage){
				var splitter:Array = String(e.message['message']).split('\r',2);
				if(splitter[0]=='toolChanged' && splitter.length > 1){
					var extra:String;
					if(splitter[1].search('patchSelection') == -1){
						extra = splitter[1].split('Tool')[0]+'Tool';
					} else {
						extra = 'patchSelection';
					}
					
					ActionController.messageRunner(splitter[0], extra);
				}
			}
		}
		
		public function execCommand($command:String):void
		{
			if(_connection){
				var msg:TextMessage = MessageDispatcher.generateTextMessage($command);
				_connection.encryptAndSendData(msg.toStream());
			}
		}
		
		
		private function delayForEncrypt(event:TimerEvent):void
		{
			_connection.initEncryption(_password);
		}
		
		private function handleEncrypt(e:PhotoshopEvent):void
		{
			_connection.connect(_ip);
			_onChange.dispatch(ENCRYPTION_SUCCESS);
		}
		
		private function handleError(e:PhotoshopEvent):void
		{
			if (e.type == PhotoshopEvent.DISCONNECTED)
			{
				_connection = null;
				_onChange.dispatch(DISCONNECTED);
			} else {
				_connection = null;
				_onChange.dispatch(DISCONNECTED);
			}	
		}
		
		private function handleConnection(e:PhotoshopEvent):void
		{
			_onChange.dispatch(CONNECTED);
			ActionController.subscribeToEvent('toolChanged');
		}
		
		public static function get instance():ConnectionController 
		{
			if ( _instance == null )
			{
				_singleton_lock = true;
				_instance = new ConnectionController();
				_singleton_lock = false;
			}
			return _instance;
		}
		
		public function get onChange():ISignal { return _onChange; }
	}
}