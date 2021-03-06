﻿package main.submodules.viewAnalytical.AnalyticalClass
{
	//import com.EventHandle.EventInteraction;
	
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
	import main.submodules.viewAnalytical.vo.buttonVo;
	import main.submodules.tools.XmlUtil;

	public class AnalyticalButton extends AnalyticalObj implements IAnalytical
	{
		public function AnalyticalButton()
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
			var sp:Sprite=new Sprite();
			var v:buttonVo=new buttonVo();
			v = buttonVo(XmlUtil.AbtToObject(ixml, v));
			this.fillObj(v,sp);
			if(v.resources){
				av.addResources(v.resources,sp,v);
			}else if(v.resourcesClass){
				av.addResourcesClass(v.resourcesClass,sp,v);
			}else{
				var btn:SmileBtn=new SmileBtn();
				sp.addChild(btn);
				if(v.text)btn.labelValue=ConfigTools.getConfig(v.text);
			}
			if(v.key){
				av.addDisplay(v.key,sp);
				av.addVo(v.key,v);
				av.addXmlItem(v.key,ixml);
				sp.addEventListener(MouseEvent.CLICK,btnClick);
			}
			if(v.rollOver){
				sp.addEventListener(MouseEvent.ROLL_OVER,btnRollOver);
				sp.addEventListener(MouseEvent.MOUSE_OVER ,btnRollOver);
			}
			if(v.rollOut){
				sp.addEventListener(MouseEvent.ROLL_OUT,btnRollOut);
				sp.addEventListener(MouseEvent.MOUSE_OUT , btnRollOut);
			}
			parent.addChild(sp);
			function btnClick(e:MouseEvent):void{
				sendMsg(v.key,av);
			}
			function btnRollOver(e:MouseEvent):void{
				sendMsg(v.rollOver,av);
			}
			function btnRollOut(e:MouseEvent):void{
				sendMsg(v.rollOut,av);
			}
		}
		private function sendMsg(key:String,av:AnalyticalVo):void{
			if(av.obj&&av.obj["header"]){
				av.sendMsg(av.obj["header"],av,key);
			}else{
				av.sendMsg(key,av);
			}
		}
	}
}