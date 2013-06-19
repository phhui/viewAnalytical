package main.submodules.viewAnalytical.vo
{
	public class simpleButtonVo extends DisplayObj
	{
		public var resources:String;
		public var text:String;
		public var rollOver:String;
		public var rollOut:String;
		public var mouseMove:String;
		public var mouseChildren:int=1;
		public var showTip:String;
		
		/** 一般状态*/
		public var upSkin:String ;
		/** 鼠标经过*/
		public var overSkin:String;
		/** 鼠标点击*/
		public var downSkin:String ;
		/** 不可点击*/
		public var disabledSkin:String ;
		/** 点击后， 停留在该图*/
		public var clickSkin:String 	;
		
		public var isClick:int ;
		
		public function simpleButtonVo()
		{
			
		}
	}
}