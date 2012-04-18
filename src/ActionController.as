package
{
	public class ActionController
	{
		static private var _id:String;
		
		public function ActionController()
		{
		}
		
		static public function selectTool($className:String):void
		{
			var id:String = ToolStringConverter.nameToID($className);
			_id = id;
			
			var command:String = "var idslct = charIDToTypeID( \"slct\" );\n"+
				"var desc19 = new ActionDescriptor();\n"+
				"var idnull = charIDToTypeID( \"null\" );\n"+
				"var ref17 = new ActionReference();\n"+
				"var tool = stringIDToTypeID( \""+id+"\" );\n"+
				"ref17.putClass( tool );\n"+
				"desc19.putReference( idnull, ref17 );\n"+
				"executeAction( idslct, desc19, DialogModes.NO );";
			ConnectionController.instance.execCommand(command);
		}
		
		static public function subscribeToEvent($inEvent:String):void
		{
			var command:String = "var idNS = stringIDToTypeID( 'networkEventSubscribe' );";
			command += "var desc1 = new ActionDescriptor();";
			command += "desc1.putClass( stringIDToTypeID( 'eventIDAttr' ), stringIDToTypeID( '" + $inEvent + "' ) );";
			command += "executeAction( idNS, desc1, DialogModes.NO );";
			ConnectionController.instance.execCommand(command);
		}
		
		static public function messageRunner($command:String, $extra:String):void
		{
			if($command == 'toolChanged' && _id != $extra){
				trace($extra);
				var name:String = ToolStringConverter.idToName($extra);
				psTools.instance.toolsView.setTool(name);
			}
		}
	}
}