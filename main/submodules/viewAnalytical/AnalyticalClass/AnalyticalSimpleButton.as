package main.submodules.viewAnalytical.AnalyticalClass
{
	//import com.EventHandle.EventInteraction;
	//import com.loading.ClassLoadImage;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import main.submodules.tools.ConfigTools;
	import main.submodules.tools.LoadObj;
	import main.submodules.viewAnalytical.AnalyticalObj;
	import main.submodules.viewAnalytical.IAnalytical;
	import main.submodules.viewAnalytical.AnalyticalWindows;
	import main.submodules.viewAnalytical.vo.AnalyticalVo;
	import main.submodules.viewAnalytical.vo.simpleButtonVo;
	import main.submodules.tools.XmlUtil;
	
	//import org.puremvc.as3.patterns.facade.Facade;

	public class AnalyticalSimpleButton extends AnalyticalObj implements IAnalytical
	{
		var skinArr:Array = ["upSkin", "downSkin", "overSkin", "disabledSkin", "clickSkin"];
		
		public function AnalyticalSimpleButton()
		{
		}
		/**
		 *解析按钮 
		 * @param vo
		 * @param _parent
		 * @param view
		 * 
		 */		
		public function analytical(ixml:XML,parent:Object,av:AnalyticalVo):void{
			
			var v:simpleButtonVo=new simpleButtonVo();
			
			v = simpleButtonVo(XmlUtil.AbtToObject(ixml, v));
			
			
			var sp:SimpleButton = new SimpleButton(v.isClick);
			
			if(v.id)sp.name=v.id;
			
			
			this.fillObj(v,sp);
			sp.buttonMode=true;
			
			if(v.resources){//如果按钮配置了资源则加载，否则使用默认的
				if(v.text && v.text!=""){
					sp.setLabel = ConfigTools.getConfig(v.text);
				}
				for(var i:uint =0 ;i < skinArr.length ; i++){
					var _name:String = skinArr[i];
					
					if(v[_name] && v[_name]!=""){
						//sp.setButtonStyle(_name, new ClassLoadImage(v.resources + v[_name]));
					}
				}
			}
			if(v.key){
				av.addDisplay(v.key,sp);
				av.addVo(v.key,v);
				av.addXmlItem(v.key,ixml);
				sp.addEventListener(MouseEvent.CLICK,btnClick);
			}
			parent.addChild(sp);
			if(v.key)
			sp.addEventListener(MouseEvent.MOUSE_OVER ,btnRollOver);
			sp.addEventListener(MouseEvent.MOUSE_OUT , btnRollOut);
			if(v.mouseMove)sp.addEventListener(MouseEvent.MOUSE_MOVE,btnMove);
			function btnClick(e:MouseEvent):void{
				if(!sp.getDisAble){
					return ;
				}
				sp.onMouseClick();
				if(v.key){
					sendMsg({obj:sp,vo:v},v.key,av.obj);
				}
			}
			function btnRollOver(e:MouseEvent):void{
				sp.onMouseMoves();
				if(v.rollOver){
					if(v.showTip=="auto")showTip(v.rollOver,sp);
					else sendMsg({obj:sp,vo:v},v.rollOver,av.obj);
				}
			}
			function btnRollOut(e:MouseEvent):void{
				sp.onMouseOut();
				if(v.rollOut){
					if(v.showTip=="auto")removeTip();
					else sendMsg({obj:sp,vo:v},v.rollOut,av.obj);
				}
			}
			function btnMove(e:MouseEvent):void{
				sendMsg({obj:sp,vo:v},v.mouseMove,av.obj);
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