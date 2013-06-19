package main.submodules.viewAnalytical
{
	import main.view.windows.Structure;
	
	import org.puremvc.as3.patterns.facade.Facade;

	public class AnalyticalPublicObj
	{
		public static var apo:AnalyticalPublicObj=null;
		public function AnalyticalPublicObj()
		{
			if(!apo){
				throw new Error("该类已实例化过");
			}
		}
		public static function getThis():AnalyticalPublicObj{
			if(!apo)apo=new AnalyticalPublicObj();
			return apo;
		}
		public function sendMsg(name:String,obj:Object=null,type:String=null):void{
			Facade.getInstance().sendNotification(name,obj,type);
		}
		public function get stage():Object{
			return Structure.getInstance().stage;
		}
	}
}