package main.submodules.viewAnalytical
{
	//import com.EventHandle.EventInteraction;
	//import com.greensock.TweenLite;
	
	//import common.ObjectClone;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.Dictionary;
	
	//import main.model.locator.GameEditLocator;
	//import main.submodules.sys.SysType;
	import main.submodules.tools.LoadObj;
	//import main.submodules.tools.SmallTools;
	import main.submodules.viewAnalytical.AnalyticalClass.*;
	import main.submodules.viewAnalytical.vo.AnalyticalVo;
	import main.submodules.tools.XmlUtil;
	
	//import org.puremvc.as3.patterns.facade.Facade;
	
	//import puremvcs.loadings.LoadingVo;

	public class viewAnalytical extends Sprite
	{
		private var loadList:Array=[];
		private var _load:LoadObj=new LoadObj();
		private var loading:Boolean=false;//冒泡加载
		private var av:AnalyticalVo;
		private var analyticalDict:Dictionary=new Dictionary();
		private var loadedNum:int=0;
		public function viewAnalytical(parentObj:Object,url:String=null,_obj:Object=null)
		{
			addAnalyticalClass("button",AnalyticalButton);
			addAnalyticalClass("textField",AnalyticalTextField);
			addAnalyticalClass("textArea",AnalyticalTextArea);
			addAnalyticalClass("label",AnalyticalLabel);
			addAnalyticalClass("resources",AnalyticalResources);
			addAnalyticalClass("checkBox",AnalyticalCheckBox);
			addAnalyticalClass("table",AnalyticalTable);
			addAnalyticalClass("layer",AnalyticalLayer);
			addAnalyticalClass("mask",AnalyticalMask);
			
			addAnalyticalClass("simpleButton", AnalyticalSimpleButton);
			av=new AnalyticalVo();
			av.parent=parentObj;
			av.obj=_obj;
			av.va=this;
			av.load=_load.loader;
			if(url){
				load(url,parentObj);
			}
		}
		public function addAnalyticalClass(item:String,cl:Class):void{
			analyticalDict[item]=new cl();
		}
		public function removeAnalyticalClass(item:String):void{
			delete analyticalDict[item];
		}
		/**
		 *解析配置文件 
		 * @param xml XML数据源
		 * @param _parent 显示窗口
		 * @param view 所有显示对象索引容器
		 * 
		 */		
		public function analyticalXML(xml:XML,parent:Object,v:AnalyticalVo=null):void{
			if(!v)v=av;
			if(!xml)return;
			av.xmlNum++;
			for each(var ixml:XML in xml.children())
			{
				if(!ixml)return;
				var a:IAnalytical=analyticalDict[ixml.name()];
				if(a){
					a.analytical(ixml,parent,v);
				}
			}
			av.xmlNum--;
			if(av.xmlNum==0&&av.configLoadedNum>=av.configTotalNum){
				loadResources();
			}
		} 
		public function load(url:String,parent:Object):void{
			loadList.push(url);
			av.totalNum++;
			av.configTotalNum++;
			_load.load(url,{onComplete:loaded,param:parent});
		}
		public function get avo():AnalyticalVo{
			return av;
		}
		private function loaded(e:*,param:Object):void{
			av.loadedNum++;
			av.configLoadedNum++;
			av.url=loadList[0];
			loadList.shift();
			analyticalXML(new XML(e),param,av);
		}
		private function loadResources():void{
			var n:int=av.resourcesList.length;
			if(n<1){
				allLoaded();
				return;
			}
			for(var i:int=0;i<n;i++){
				var _url:String = av.resourcesList[i][0];
				var _obj:Object = {progressFunc:resourcesLoading,errorFunc:resourcesUnLoaded,onComplete:resourcesLoaded,parent:av.resourcesList[i][1],param:av.resourcesList[i][2]};
				
				//_url = GameEditLocator.getInstance().getGameVersionData(_url);
				
				_load.load(_url,_obj);
			}
			sendLoadingMsg("loadStartData");
		}
		private function resourcesLoading(e:ProgressEvent):void{
			sendLoadingMsg("loadProgressData",e);
			if(av.obj&&av.obj.progressFunc)av.obj.progressFunc(e);
		}
		private function resourcesUnLoaded(e:IOErrorEvent):void{
			loadedNum++;
			allLoaded();
		}
		private function resourcesLoaded(e:Event,param:Object=null):void{
			if(param)fillResources(e.target.content,param);
			//TweenLite.from(e.target.content,0.8,{alpha:0});
			loadedNum++;
			allLoaded();
		}
		private function fillResources(obj:Object,param:Object):void{
			if(param["width"])obj["width"]=param["width"];
			if(param["height"])obj["height"]=param["height"];
		}
		private function allLoaded():void{
			if(loadedNum<av.resourcesList.length)return;
			showResources();
			//sendLoadingMsg(SysType.analyticalEnd);
			//sendMsg(SysType.analyticalEnd,av);
			if(av.obj&&av.obj["onComplete"]){
				av.obj["onComplete"]();
			}
		}
		private function showResources():void{
			var n:int=av.resourcesClass.length;
			for(var i:int=0;i<n;i++){
				if(getClass(av.resourcesClass[i][0]) is BitmapData){
					av.resourcesClass[i][1].addChild(new Bitmap(getClass(av.resourcesClass[i][0]) as BitmapData));
				}else{
					av.resourcesClass[i][1].addChild(getClass(av.resourcesClass[i][0]) as DisplayObject);
				}
			}
		}
		private function getClass(name:String):Object{
			var cl:Class=_load.loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
			var _target:Object = new cl();
			return _target;
		}
		private function sendMsg(type:String,obj:Object=null):void{
			if(av.obj&&av.obj["header"]){
				av.sendMsg(av.obj["header"],obj,type);
			}
		}
		private function sendLoadingMsg(type:String,obj:Object=null):void
		{
			//this.dispatchEvent(new EventInteraction(type , obj));
		}
	}
}