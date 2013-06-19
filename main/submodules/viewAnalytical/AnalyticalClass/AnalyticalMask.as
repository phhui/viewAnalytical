package main.submodules.viewAnalytical.AnalyticalClass
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import main.submodules.viewAnalytical.AnalyticalObj;
	import main.submodules.viewAnalytical.IAnalytical;
	import main.submodules.viewAnalytical.AnalyticalWindows;
	import main.submodules.viewAnalytical.vo.AnalyticalVo;
	import main.submodules.viewAnalytical.vo.MaskVo;
	import main.submodules.tools.XmlUtil;
	
	public class AnalyticalMask extends AnalyticalObj implements IAnalytical
	{
		public function AnalyticalMask()
		{
			super();
		}
		
		public function analytical(ixml:XML,parent:Object,av:AnalyticalVo):void
		{
			var v:MaskVo=new MaskVo();
			v=MaskVo(XmlUtil.AbtToObject(ixml,v));
			var sp:Sprite=new Sprite();
			if(v.width.toString()=="NaN"){
				v.width=0;
				v.height=0;
			}
			sp.graphics.beginFill(v.color,v.alpha);
			sp.graphics.drawRect(0,0,v.width,v.height);
			sp.graphics.drawRect(v.migrationX,v.migrationY,v.w,v.h);
			this.fillObj(v,sp);
			if(v.key){
				av.addDisplay(v.key,sp);
				av.addVo(v.key,v);
				av.addXmlItem(v.key,ixml);
			}
			parent.addChild(sp);
		}
	}
}