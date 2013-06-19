package main.submodules.viewAnalytical
{
	import com.EventHandle.EventInteraction;
	
	import flash.display.Sprite;
	
	import main.submodules.openWindowLoad.OpenLoadWindowStatic;
	import main.submodules.sys.SysType;
	
	import org.puremvc.as3.patterns.facade.Facade;

	public class AnalyticalWindows extends Sprite
	{
		private var _view:viewAnalytical ;
		
		private var win_name:String = "";
		private var isLoading:Boolean = false ;
		
		public function AnalyticalWindows(parentObj:Object,_win_name:String,url:String=null,_obj:Object=null, _isLoading:Boolean = true )
		{
			win_name = _win_name;
			
			isLoading = _isLoading;
			
			_view = new viewAnalytical(parentObj, url, _obj);
			
			_view.addEventListener(EventInteraction.DISPATCH_DATA , onLoadingEvent);
		}
		
		private function onLoadingEvent(event:EventInteraction):void
		{
			sendLoadingMsg(event.GetCmd , event.GetData);
		}
		
		private function sendLoadingMsg(type:String,obj:Object=null):void
		{
			if(!isLoading){
				return ;
			}
			if(!win_name || win_name==""){
				return ;
			}
			switch(type){
				case "loadStartData":
				
					Facade.getInstance().sendNotification(OpenLoadWindowStatic.OpenLoadWindowMediator, win_name, OpenLoadWindowStatic.SHOW);
					break;
				case "loadProgressData":
					var _obj:Object = {};
					_obj.win_name = win_name ;
					_obj.current_byte = obj.bytesLoaded;
					_obj.total_byte = obj.bytesTotal;
					_obj.itemsLoaded = 0;
					_obj.itemsTotal = 1;
					Facade.getInstance().sendNotification(OpenLoadWindowStatic.OpenLoadWindowMediator, _obj, OpenLoadWindowStatic.PROGRESS);
					break ;
				case SysType.analyticalEnd:
					Facade.getInstance().sendNotification(OpenLoadWindowStatic.OpenLoadWindowMediator, win_name, OpenLoadWindowStatic.COMPLETE);
					break ;
			}
		}
	}
}