package main.submodules.tools
{
	import LoadObj;
	import flash.utils.Dictionary;
	import flash.events.MouseEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import fl.events.ColorPickerEvent;
	public class loadKey
	{
		var urlList:Array=[];
		var xmlload:LoadObj=new LoadObj();
		var ConfigDict:Dictionary=new Dictionary();
		var obj:Object={};
		var _url:String="";
		public function loadKey()
		{
			loadConfigData();
		}
		public function getKey(key:String):String{
			return ConfigDict[key];
		}
		private function loadConfigData():void{
			xmlload.load("assets/locale/zh_CN/URL.XML",{onComplete:urlLoaded,errorFunc:loadError,errorType:typeError});
		}
		private function urlLoaded(e:String):void{
			var xml:XML = new XML(e);
			for each(var ixml:XML in xml.item)
			{
				urlList.push(ixml.attribute("url"));
			}
			loadConfig();
		}
		private function loadError(e:IOErrorEvent):void{
			
		}
		private function typeError(e:String):void{
			loadNext();
		}
		private function loadConfig():void{
			var url:String=urlList[urlList.length-1];
			_url=url;
			if(url.length<3){
				urlList.pop();
				loadNext();
				return;
			}
			xmlload.load(url,{onComplete:loaded,errorFunc:xmlError,errorType:typeError});
			urlList.pop();
		}
		private function loaded(e:String):void{
			try{
				var xml:XML = new XML(e);
				for each(var ixml:XML in xml.children())
				{
					var v:Object={};
					v.key = ixml.attribute("key");
					v.info=ixml.attribute("info");
					v.val=ixml;
					v.url=_url;
					ConfigDict[v.key]=v.val;
				}
				loadNext();
			}catch(e){}
		}
		private function xmlError(e:IOErrorEvent):void{
			loadNext()
		}
		private function loadNext():void{
			if(urlList.length>0){
				loadConfig();
			}
		}
	}
}