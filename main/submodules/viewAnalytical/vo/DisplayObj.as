package main.submodules.viewAnalytical.vo
{
	public class DisplayObj
	{
		public var id:String;
		public var name:String;
		public var x:int;
		public var y:int;
		public var width:Number;
		public var height:Number;
		public var mouseEnabled:int=1;
		public var index:int=0;
		public var visible:int=1;
		public var alpha:Number=1;
		private var _key:String;
		
		public var buttonMode:Boolean ;
		
		public function DisplayObj()
		{
			
		}
		public function set key(value:String):void{
			_key=value;
		}
		public function get key():String{
			return _key;
		}
	}
}