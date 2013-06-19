package main.submodules.viewAnalytical.AnalyticalClass
{
	//import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import main.submodules.tools.LoadObj;
	import main.submodules.viewAnalytical.AnalyticalObj;
	import main.submodules.viewAnalytical.AnalyticalWindows;
	import main.submodules.viewAnalytical.IAnalytical;
	import main.submodules.viewAnalytical.vo.AnalyticalVo;
	import main.submodules.viewAnalytical.vo.resourcesVo;
	import main.submodules.tools.XmlUtil;
	
	//import org.puremvc.as3.patterns.facade.Facade;

	public class AnalyticalResources extends AnalyticalObj implements IAnalytical
	{
		public function AnalyticalResources()
		{
		}
		/**
		 *解析资源 
		 * @param v
		 * @param _parent
		 * @param view
		 * 
		 */		
		public function analytical(ixml:XML,parent:Object,av:AnalyticalVo):void{
			var v:resourcesVo=new resourcesVo();
			v = resourcesVo(XmlUtil.AbtToObject(ixml, v));
			var sp:Sprite=new Sprite();
			fillObj(v,sp);
			if(v.resources)av.addResources(v.resources,sp,v);
			if(v.key){
				av.addDisplay(v.key,sp);
				av.addVo(v.key,v);
				av.addXmlItem(v.key,ixml);
			}
			if(v.resourcesClass){
				av.addResourcesClass(v.resourcesClass,sp,v);
			}
			parent.addChild(sp);
			if(v.drag){
				sp.addEventListener(MouseEvent.MOUSE_DOWN,spDrag);
				sp.removeEventListener(MouseEvent.MOUSE_UP,spStopDrag);
				sp.addEventListener(MouseEvent.MOUSE_UP,spStopDrag);
			}
			if(v.mouseUp){
				sp.removeEventListener(MouseEvent.MOUSE_UP,spStopDrag);
				sp.addEventListener(MouseEvent.MOUSE_UP,spStopDrag);
			}
			if(v.rollOver){
				sp.addEventListener(MouseEvent.ROLL_OVER,btnRollOver);
				sp.addEventListener(MouseEvent.MOUSE_OVER ,btnRollOver);
			}
			if(v.rollOut){
				sp.addEventListener(MouseEvent.ROLL_OUT,btnRollOut);
				sp.addEventListener(MouseEvent.MOUSE_OUT , btnRollOut);
			}
			if(v.doubleClick){
				sp.doubleClickEnabled=true;
				sp.addEventListener(MouseEvent.DOUBLE_CLICK,btnDoubleClick);
			}
			if(v.mouseClick){
				sp.addEventListener(MouseEvent.CLICK,btnMouseClick);
			}
			function btnRollOver(e:MouseEvent):void{
				if(v.showTip=="auto")showTip(v.rollOver,sp);
				else sendMsg({obj:sp,vo:v},v.rollOver,av.obj);
			}
			function btnRollOut(e:MouseEvent):void{
				if(v.showTip=="auto")removeTip();
				else sendMsg({obj:sp,vo:v},v.rollOut,av.obj);
			}
			function spDrag(e:MouseEvent):void{
				e.target.parent.startDrag();
			}
			function spStopDrag(e:MouseEvent):void{
				e.target.stopDrag();
				sendMsg({obj:sp,vo:v},v.mouseUp,av.obj);
			}
			function btnDoubleClick(e:MouseEvent):void{
				sendMsg({obj:sp,vo:v},v.doubleClick,av.obj);
			}
			function btnMouseClick(e:MouseEvent):void{
				sendMsg({obj:sp,vo:v},v.mouseClick,av.obj);
			}
		}
		private function sendMsg(obj:Object,type:String=null,param:Object=null):void{
			if(param&&param["header"]){
				//Facade.getInstance().sendNotification(param["header"],obj,type);
			}else{
				//Facade.getInstance().sendNotification(type,obj);
			}
		}
	}
}