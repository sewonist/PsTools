package
{
	public class ToolStringConverter extends Object
	{
		static private const TOOL_NAMES:Array = [
			'MoveTool', 'RectangularMarqueeTool', 'EllipticalMarqueeTool', 'SingleRowMarqueeTool', 'SingleColumnMarqueeTool',
			'LassoTool', 'PolygonalLassoTool', 'MagneticLassoTool', 'QuickSelectionTool', 'MagicWandTool',
			'SliceTool', 'CropTool', 'SliceSelectTool', 'EyedropperTool', 'RulerTool', 'NoteTool',
			'ColorSamplerTool', 'CountTool', 'SpotHealingBrushTool', 'HealingBrushTool', 'PatchTool',
			'RedEyeTool', 'CloneStampTool', 'PatternStampTool', 'BackgroundEraserTool', 'EraserTool',
			'MagicEraserTool', 'BlurTool',  'SharpenTool', 'SmudgeTool', 'DodgeTool', 'BurnTool',
			'SpongeTool', 'PencilTool', 'BrushTool', 'ColorReplacementTool', 'MixerBrushTool',
			'HistoryBrushTool', 'ArtHistoryBrushTool', 'GradientTool', 'PaintBucketTool', 'PenTool',
			'FreeformPenTool', 'AddAnchorPointTool', 'DeleteAnchorPointTool', 'ConvertPointTool', 'HorizontalTypeTool',
			'VerticalTypeTool', 'VerticalTypeTool', 'HorizontalTypeMaskTool', 'VerticalTypeMaskTool',
			'PathSelectionTool', 'DirectSelectionTool', 'RectangleTool', 'RoundedRectangleTool', 'EllipseTool',
			'PolygonTool', 'LineTool', 'CustomShapeTool', 'CustomShapeTool', 
			'ThreeDObjectRotateTool', 'ThreeDObjectRollTool', 'ThreeDObjectPanTool', 'ThreeDObjectSlideTool', 'ThreeDObjectScaleTool',
			'ThreeDRotateCameraTool', 'ThreeDRollCameraTool', 'ThreeDPanCameraTool', 'ThreeDWalkCameraTool', 'ThreeDZoomCameraTool',
			'HandTool', 'RotateViewTool', 'ZoomTool'
		];
		
		static private const TOOL_IDS:Array = [
			'moveTool', 'marqueeRectTool', 'marqueeEllipTool', 'marqueeSingleRowTool','marqueeSingleColumnTool',
			'lassoTool', 'polySelTool', 'magneticLassoTool', 'quickSelectTool', 'magicWandTool',
			'sliceTool', 'cropTool', 'sliceSelectTool', 'eyedropperTool', 'rulerTool', 'textAnnotTool',
			'colorSamplerTool', 'countTool', 'spotHealingBrushTool', 'magicStampTool', 'patchSelection',
			'redEyeTool', 'cloneStampTool', 'patternStampTool', 'backgroundEraserTool', 'eraserTool',
			'magicEraserTool', 'blurTool', 'sharpenTool', 'smudgeTool', 'dodgeTool', 'burnInTool',
			'saturationTool', 'pencilTool', 'paintbrushTool', 'colorReplacementBrushTool', 'wetBrushTool',
			'historyBrushTool', 'artBrushTool', 'gradientTool', 'bucketTool', 'penTool',
			'freeformPenTool', 'addKnotTool', 'deleteKnotTool', 'convertKnotTool', 'typeCreateOrEditTool',
			'typeVerticalCreateOrEditTool', 'typeVerticalCreateOrEditTool', 'typeCreateMaskTool', 'typeVerticalCreateMaskTool',
			'pathComponentSelectTool', 'directSelectTool', 'rectangleTool', 'roundedRectangleTool', 'ellipseTool',
			'polygonTool', 'lineTool', 'customShapeTool', 'customShapeTool', 
			'3DObjectRotateTool', '3DObjectRollTool', '3DObjectPanTool', '3DObjectSlideTool', '3DObjectScaleTool',
			'3DOrbitCameraTool', '3DRollCameraTool', '3DPanCameraTool', '3DWalkCameraTool', '3DFOVTool',
			'handTool', 'rotateTool', 'zoomTool'
		]; 

		static public function nameToID($name:String):String
		{
			if(TOOL_NAMES.length != TOOL_NAMES.length){
				return '';
			}
			
			for (var i:int = 0; i < TOOL_IDS.length; i++) {
				if (TOOL_NAMES[i] == $name)
					return TOOL_IDS[i];
			}
			return '';
		}
		
		static public function idToName($id:String):String
		{
			if(TOOL_NAMES.length != TOOL_NAMES.length){
				return '';
			}
			
			for (var i:int = 0; i < TOOL_IDS.length; i++) {
				if (TOOL_IDS[i] ==  $id)
					return TOOL_NAMES[i];
			}
			return '';
		}

	}
}