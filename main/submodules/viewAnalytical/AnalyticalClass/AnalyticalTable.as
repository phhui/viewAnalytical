﻿package main.submodules.viewAnalytical.AnalyticalClass
{
	import flash.utils.Dictionary;
	
	import main.submodules.control.DataList;
	import main.submodules.viewAnalytical.AnalyticalObj;
	import main.submodules.viewAnalytical.IAnalytical;
	import main.submodules.viewAnalytical.AnalyticalWindows;
	import main.submodules.viewAnalytical.vo.AnalyticalVo;
	import main.submodules.viewAnalytical.vo.tableVo;
	import main.submodules.tools.XmlUtil;
	
	//import org.puremvc.as3.patterns.facade.Facade;

	public class AnalyticalTable extends AnalyticalObj implements IAnalytical
	{
		public function AnalyticalTable()
		{
		}
		/**
		 *解析表格 
		 * @param v
		 * @param _parent
		 * @param view
		 * 
		 */		
		public function analytical(ixml:XML,parent:Object,av:AnalyticalVo):void{
			var v:tableVo=new tableVo();
			v = tableVo(XmlUtil.AbtToObject(ixml, v));
			var dg:DataList=new DataList(v.width?v.width:400,v.height?v.height:300,{rowHeight:v.rowHeight,rowBga:v.rowBga,rowBgb:v.rowBgb,rowOver:v.rowOver,rowChange:v.rowChange,align:v.align,isFilter:v.isFilter});
			fillObj(v,dg);
			if(v.key){
				av.addDisplay(v.key,dg);
				av.addVo(v.key,v);
				av.addXmlItem(v.key,ixml);
			}
			parent.addChild(dg);
			if(v.key){
				//Facade.getInstance().sendNotification(v.key,dg);
			}
		}
	}
}