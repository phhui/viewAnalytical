package main.submodules.tools
{	
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.*;
	import flash.system.LoaderContext;
	
	/** 本类封装 ， 主要用来加载图片 */
	public class ClassLoadImage extends Sprite
	{
		/** 加载的是外部的图片， 用来显示这个任务的图标是什么*/
		public var load_image:Loader ;
		
		var ClientContent ;
		
		var set_width :int = 60;
		var set_height:int = 60 ;
		
		var _Data; 
		
		public function ClassLoadImage(image_string:String, _width :int = 0 , _height:int=0 ,eFlag:Boolean = false,_data=null)
		{
			_Data = _data ;
			
			set_width = _width;
			set_height = _height;
			
			load_image = new Loader();
			load_image.contentLoaderInfo.addEventListener(Event.COMPLETE, load_complete);
			load_image.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR ,ioErrorHandler);
			load_image.contentLoaderInfo.addEventListener(Event.OPEN, openHandler);
			load_image.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			
		
			
			var lc:LoaderContext = new LoaderContext();
			lc.checkPolicyFile = true;
			
			
			load_image.load(new URLRequest(image_string),lc);	
		}
		
		public function get getData(){
			return _Data; 
		}
		
		private function load_complete(event:Event):void {
			if(ClientContent!=null){
				removeChild(ClientContent);
				ClientContent = null ;
			}
			
			ClientContent = load_image.content ;
			ClientContent.x = 0 ;
			ClientContent.y = 0 ;
			
			addChild(ClientContent);
			
			if(set_width !=0 && set_height!=0){
				this.width = set_width;
				this.height = set_height ;
			}
			if(!_Data){
				this.dispatchEvent(new Event("load_complete"));
			}else{
				//this.dispatchEvent(new EventInteraction("load_complete", _Data));
			}
		}
		public function get getLoadContent(){
			return ClientContent;
		}
		private function progressHandler(event:ProgressEvent):void {
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			
		}
		
		private function openHandler(event:Event):void {}	
	}
}