﻿package main.submodules.viewAnalytical.AnalyticalClass
{
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import fl.controls.TextArea;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	
	import main.submodules.tools.ConfigTools;
	import main.submodules.viewAnalytical.AnalyticalObj;
	import main.submodules.viewAnalytical.AnalyticalWindows;
	import main.submodules.viewAnalytical.IAnalytical;
	import main.submodules.viewAnalytical.vo.AnalyticalVo;
	import main.submodules.viewAnalytical.vo.textAreaVo;
	import main.submodules.tools.XmlUtil;
	
	//import org.puremvc.as3.patterns.facade.Facade;
	
	public class AnalyticalTextArea extends AnalyticalObj implements IAnalytical
	{
		public function AnalyticalTextArea()
		{
			super();
		}
		/**
		 *解析文本框 
		 * @param v 
		 * @param _parent
		 * @param view
		 * 
		 */		
		public function analytical(ixml:XML,parent:Object,av:AnalyticalVo):void{
			var v:textAreaVo=new textAreaVo();
 			v = textAreaVo(XmlUtil.AbtToObject(ixml, v));
			var txt:TextArea=new TextArea();
			var tf:TextFormat=new TextFormat();
			//fillObj(v,txt.textField);
			fillObj(v,txt);
			fillObj(v,tf);
			txt.setStyle("textFormat",tf);	
			txt.textField.setTextFormat(tf);
			if(v.strokes)setTextFilters(txt.textField,uint(v.strokes));
			if(v.key){
				av.addDisplay(v.key,txt);
				av.addVo(v.key,v);
				av.addXmlItem(v.key,ixml);
			}
			parent.addChild(txt);
			if(v.textEvent){
				txt.addEventListener(Event.CHANGE,textEvent);
			}
			function textEvent(e:Event):void{
				sendMsg({obj:txt,vo:v},v.textEvent,av.obj);
			}
			if(v.clickEvent)txt.addEventListener(TextEvent.LINK,clickEvent);
			function clickEvent(e:TextEvent):void{
				sendMsg(e.text,v.clickEvent,av.obj);
			}
		}
		public static function setTextFilters(text:TextField,color:Number=0x000000):void
		{
			var gf:GlowFilter = new GlowFilter();
			gf.color = color;
			gf.alpha = 1;
			gf.blurX = 2;
			gf.blurY = 2;
			gf.strength = 5;
			text.filters = [gf];
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