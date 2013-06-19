package main.submodules.viewAnalytical
{
	import main.submodules.tools.ObjectClone;
	
	import flash.utils.ByteArray;
	
	import main.submodules.tools.ConfigTools;
	//import main.submodules.tools.Tip;
	import main.submodules.viewAnalytical.vo.AnalyticalVo;

	public class AnalyticalObj
	{
		public function AnalyticalObj()
		{
			
		}
		public function fillObj(fromObj:Object,toObj:Object):void{
			ObjectClone.fillObj(fromObj,toObj);
		}
		public function showTip(key:String,target:Object=null):void{
			//Tip.getInstance().bindData({htmlText:ConfigTools.getConfig(key)},target);
		}
		public function removeTip():void{
			//Tip.getInstance().removeTip();
		}
	}
}