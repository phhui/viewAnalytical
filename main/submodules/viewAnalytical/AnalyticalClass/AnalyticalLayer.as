﻿package main.submodules.viewAnalytical.AnalyticalClass
{
	//import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	//import main.submodules.sys.WindowMediator;
	import main.submodules.tools.LoadObj;
	import main.submodules.viewAnalytical.AnalyticalObj;
	import main.submodules.viewAnalytical.IAnalytical;
	import main.submodules.viewAnalytical.vo.AnalyticalVo;
	import main.submodules.viewAnalytical.vo.layerVo;
	import main.submodules.tools.XmlUtil;

	public class AnalyticalLayer extends AnalyticalObj implements IAnalytical
	{
		public function AnalyticalLayer()
		{
			
		}
		public function analytical(ixml:XML,parent:Object,av:AnalyticalVo):void{			
			var sp:Sprite=new Sprite();
			var v:layerVo=new layerVo();
			v = layerVo(XmlUtil.AbtToObject(ixml, v));
			fillObj(v,sp);
			parent.addChild(sp);
			//if(v.align)av.sendMsg(WindowMediator.registerAutoSize,{obj:sp,x:v.x,y:v.y},v.align);
			if(v.config)av.va.load(v.config,sp);
			if(v.resources){
				var ressp:Sprite=new Sprite();
				sp.addChild(ressp);
				av.addResources(v.resources,ressp,v);
			}
			if(v.key){
				av.addDisplay(v.key,sp);
				av.addVo(v.key,v);
				av.addXmlItem(v.key,ixml);
			}
			if(v.showTip=="auto"){
				sp.addEventListener(MouseEvent.ROLL_OVER,showtip);
				sp.addEventListener(MouseEvent.ROLL_OUT,removetip);
			}
			function showtip(e:MouseEvent):void{
				showTip(v.rollOver,sp);				
			}
			function removetip(e:MouseEvent):void{
				removeTip();
			}
			av.va.analyticalXML(ixml,sp,av);
		}
	}
}