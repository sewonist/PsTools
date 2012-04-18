package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	
	public class ToolsView extends Sprite
	{
		private var _toolGroup:Array;
		
		public function ToolsView()
		{
			super();
			
			initLayout();
		}
		
		public function setTool($className:String):void
		{
			for(var i:int = 0;i<_toolGroup.length;i++){
				for(var j:int = 0;j<_toolGroup[i].length;j++){
					_toolGroup[i][j].select($className);
				}
			}
		}
		
		private function initLayout():void
		{
			_toolGroup = new Array;
			
			var tempGroup:Vector.<Tool>;
			// select group
			tempGroup = new Vector.<Tool>;
			tempGroup.push(new Tool(MoveTool));
			tempGroup.push(new Tool(RectangularMarqueeTool, EllipticalMarqueeTool, SingleRowMarqueeTool, SingleColumnMarqueeTool));
			tempGroup.push(new Tool(LassoTool, PolygonalLassoTool, MagneticLassoTool));
			tempGroup.push(new Tool(QuickSelectionTool, MagicWandTool));
			tempGroup.push(new Tool(CropTool, SliceTool, SliceSelectTool));
			tempGroup.push(new Tool(EyedropperTool, ColorSamplerTool, RulerTool, NoteTool, CountTool));
			_toolGroup.push(tempGroup);
			// edit group
			tempGroup = new Vector.<Tool>;
			tempGroup.push(new Tool(SpotHealingBrushTool, HealingBrushTool, PatchTool, RedEyeTool));
			tempGroup.push(new Tool(BrushTool, PencilTool, ColorReplacementTool, MixerBrushTool));
			tempGroup.push(new Tool(CloneStampTool, PatternStampTool));
			tempGroup.push(new Tool(HistoryBrushTool, ArtHistoryBrushTool));
			tempGroup.push(new Tool(EraserTool, BackgroundEraserTool, MagicEraserTool));
			tempGroup.push(new Tool(PaintBucketTool, GradientTool));
			tempGroup.push(new Tool(BlurTool, SharpenTool, SmudgeTool));
			tempGroup.push(new Tool(DodgeTool, BurnTool, SpongeTool));
			_toolGroup.push(tempGroup);
			// path group
			tempGroup = new Vector.<Tool>;
			tempGroup.push(new Tool(PenTool, FreeformPenTool, AddAnchorPointTool, DeleteAnchorPointTool, ConvertPointTool));
			tempGroup.push(new Tool(HorizontalTypeTool, VerticalTypeTool, HorizontalTypeMaskTool, VerticalTypeMaskTool));
			tempGroup.push(new Tool(PathSelectionTool, DirectSelectionTool));
			tempGroup.push(new Tool(RectangleTool, RoundedRectangleTool, EllipseTool, PolygonTool, LineTool, CustomShapeTool));
			_toolGroup.push(tempGroup);
			// 3d group
			tempGroup = new Vector.<Tool>;
			tempGroup.push(new Tool(ThreeDObjectRotateTool, ThreeDObjectRollTool, ThreeDObjectPanTool, ThreeDObjectSlideTool, ThreeDObjectScaleTool));
			tempGroup.push(new Tool(ThreeDRotateCameraTool, ThreeDRollCameraTool, ThreeDPanCameraTool, ThreeDWalkCameraTool, ThreeDZoomCameraTool));
			tempGroup.push(new Tool(HandTool, RotateViewTool));
			tempGroup.push(new Tool(ZoomTool));
			_toolGroup.push(tempGroup);
			
			var lastX:Number = 20;
			var lastY:Number = 50;
			var tempTool:Tool;
			for(var i:int=0;i<_toolGroup.length;i++){
				for(var j:int=0;j<_toolGroup[i].length;j++){
					tempTool = _toolGroup[i][j];
					tempTool.x = lastX;
					tempTool.y = lastY;
					addChild(tempTool);
					
					if((j+1)%4==0 || j == _toolGroup[i].length - 1 ){
						lastX = 18;
						lastY = lastY + tempTool.height + 8;
					} else {
						lastX = lastX + tempTool.width + 18;
					}
				}
				
				if(i < _toolGroup.length-1){
					var partition:Partition = new Partition;
					partition.x = lastX;
					partition.y = lastY + 11;
					addChild(partition);
				}
				lastX = 20;
				lastY = lastY + 24;
			}
		}
		
		
	}
}