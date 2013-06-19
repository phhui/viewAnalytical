package main.submodules.viewAnalytical.AnalyticalClass
{
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	
	import main.submodules.tools.ConfigTools;
	import main.submodules.viewAnalytical.AnalyticalObj;
	import main.submodules.viewAnalytical.IAnalytical;
	import main.submodules.viewAnalytical.vo.AnalyticalVo;
	import main.submodules.viewAnalytical.vo.labelVo;
	import main.submodules.tools.XmlUtil;

	public class AnalyticalLabel extends AnalyticalObj implements IAnalytical
	{
		public function AnalyticalLabel()
		{
		}
		/**
		 *解析label 
		 * @param v
		 * @param _parent
		 * @param view
		 * 
		 */
		public function analytical(ixml:XML,parent:Object,av:AnalyticalVo):void{
			var v:labelVo=new labelVo();
			v = labelVo(XmlUtil.AbtToObject(ixml, v));
			var txt:TextField=new TextField();
			var tf:TextFormat=new TextFormat();
			fillObj(v,txt);
			fillObj(v,tf);
			txt.setTextFormat(tf);
			txt.mouseEnabled=false;
			txt.selectable=false;
			if(v.strokes)setTextFilters(txt,uint(v.strokes));//描边
			if(v.key){				
				av.addDisplay(v.key,txt);
				av.addVo(v.key,v);
				av.addXmlItem(v.key,ixml);
			}
			parent.addChild(txt);
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
	}
}