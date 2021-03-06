﻿package main.submodules.viewAnalytical.AnalyticalClass
{
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import main.submodules.viewAnalytical.AnalyticalObj;
	import main.submodules.viewAnalytical.AnalyticalWindows;
	import main.submodules.viewAnalytical.IAnalytical;
	import main.submodules.viewAnalytical.vo.AnalyticalVo;
	import main.submodules.viewAnalytical.vo.checkBoxVo;
	import main.submodules.tools.XmlUtil;
	
	//import org.puremvc.as3.patterns.facade.Facade;
	import fl.controls.CheckBox;

	public class AnalyticalCheckBox extends AnalyticalObj implements IAnalytical
	{
		public function AnalyticalCheckBox()
		{
		}
		/**
		 *解析checkbox 
		 * @param v
		 * @param _parent
		 * @param view
		 * 
		 */		
		public function analytical(ixml:XML,parent:Object,av:AnalyticalVo):void{
			var v:checkBoxVo=new checkBoxVo();
			v = checkBoxVo(XmlUtil.AbtToObject(ixml, v));
			var cb:CheckBox=new CheckBox();
			fillObj(v,cb);
			if(v.key){
				cb.addEventListener(MouseEvent.MOUSE_UP,checkBoxClick);
				av.addDisplay(v.key,cb);
				av.addVo(v.key,v);
				av.addXmlItem(v.key,ixml);
			}
			parent.addChild(cb);
			if(v.rollOver){
				cb.addEventListener(MouseEvent.ROLL_OVER,btnRollOver);
				cb.addEventListener(MouseEvent.MOUSE_OVER ,btnRollOver);
			}
			if(v.rollOut){
				cb.addEventListener(MouseEvent.ROLL_OUT,btnRollOut);
				cb.addEventListener(MouseEvent.MOUSE_OUT , btnRollOut);
			}
			function btnRollOver(e:MouseEvent):void{
				if(v.showTip=="auto")showTip(v.rollOver,cb);
				else sendMsg(v.rollOver,av);
			}
			function btnRollOut(e:MouseEvent):void{
				if(v.showTip=="auto")removeTip();
				else sendMsg(v.rollOut,av);
			}
			function checkBoxClick(e:MouseEvent):void{
				sendMsg(v.key,av);
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