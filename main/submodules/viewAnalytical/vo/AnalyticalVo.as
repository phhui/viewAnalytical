﻿package main.submodules.viewAnalytical.vo
{
	import flash.display.Loader;
	import flash.utils.Dictionary;
	
	import main.submodules.viewAnalytical.viewAnalytical;
	
	//import org.puremvc.as3.patterns.facade.Facade;

	public class AnalyticalVo
	{
		public var va:viewAnalytical;
		public var load:Loader;
		public var url:String;
		/**当前解析进程解析后所显示的位置*/		
		public var parent:Object;
		/**当前解析进程所附带的参数*/	
		public var obj:Object;
		/**待解析的XML数量 ，用于外部调用analyticalXML方法时判断是否解析完成以便加载资源 */		
		public var xmlNum:int=0;
		/**已加载的资源大小 */		
		public var loadedSize:int=0;
		/**所有资源总大小*/		
		public var totalSize:int;
		/**已加载的资源数量*/		
		public var loadedNum:int=0;
		/**总共需要加载的资源数量 */		
		public var totalNum:int;
		/**当前进程中已加载的配置文件数量，即已加载的包括嵌套的XML数量 */		
		public var configLoadedNum:int;
		/**当前进程中所有配置文件数量，包括嵌套的XML数量*/		
		public var configTotalNum:int;
		/**当前进程中解析到的所有显示对象*/		
		private var view:Dictionary=new Dictionary();
		/**当前进程中所有解析的对象模型 */
		private var vo:Dictionary=new Dictionary();
		/**当前进程中所有解析的XML节点 */		
		private var xmlItem:Dictionary=new Dictionary();
		private var _resourcesList:Array=[];
		private var _resources:Array=[];
		public var resourcesUrl:String;
		/**
		 *此类的目的是方便整个解析系统的一些数据存储操作 
		 * 此类做为参数跟随整个解析系统传到每个子类中
		 */		
		public function AnalyticalVo()
		{
		}
		public function addVo(key:String,_obj:Object):void{
			vo[key]=_obj;
			if(!obj||!obj["vo"])return;
			if(!obj["vo"][key]){
				obj["vo"][key]=[];
			}
			obj["vo"][key].push(_obj);
		}
		public function addXmlItem(key:String,xml:XML):void{
			if(!xmlItem[key]){
				xmlItem[key]=[];
			}
			xmlItem[key].push(xml);
			if(obj&&obj["xmlItem"])obj["xmlItem"]=xml;
		}
		public function addDisplay(key:String,_obj:Object):void{
			view[key]=_obj;
			if(!obj||!obj["view"])return;
			if(!obj["view"][key]){
				obj["view"][key]=[];
			}
			obj["view"][key].push(_obj);
		}
		public function addResources(url:String,parent:Object,vo:Object):void{
			_resourcesList.push([url,parent,vo]);
			totalNum++;
			if(vo&&vo["key"]&&vo["key"]=="modelResources"){
				resourcesUrl=url;
			}
		}
		public function addResourcesClass(name:String,parent:Object,vo:Object):void{
			_resources.push([name,parent,vo]);
		}
		public function get resourcesList():Array{
			return _resourcesList;
		}
		public function get resourcesClass():Array{
			return _resources;
		}
		public function sendMsg(name:String,_obj:Object=null,type:String=null):void{
			//Facade.getInstance().sendNotification(name,_obj,type);
		}
	}
}