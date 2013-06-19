package main.submodules.tools
{
	import com.TipBG.TipBackFrame;
	
	import common.ColorValue;
	import common.Common;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import main.submodules.tools.LoadObj;
	import main.view.windows.Structure;
	import main.view.windows.tools.CommonTextField;

	public class Tip extends Sprite
	{
		private static var _instance:Tip = null;
		public var _w:int=200;
		public var _bgColor:uint=0x000000;
		public var data:Object={};
		public var _l:int=5;
		public var _t:int=5;
		private var _h:int=5;
		private var textSize:int=12;
		private var textColor:String="#FFFFFF";
		private var txt:TextField=new TextField();
		private var load:LoadObj=new LoadObj();
		private var str:String="";
		private var targetObj:Object;
		
		/**
		 *提示框 
		 *@param 使用说明： 直接new Tip().bindData(param);即可，无需addChild和设置X,Y
		 *@param 详细参数见bindData方法说明
		 */		
		public function Tip()
		{
			super();
		}
		public static function getInstance():Tip
		{
			if(_instance == null)
			{
				_instance = new Tip();
			}
			return _instance;
		}
		/**
		 *绑定数据 
		 * @param obj
		 * @param img 要显示的图片路径
		 * @param imgW 图片宽度
		 * @param imgH 图片高度
		 * @param htmlText 自定义htmlText文本内容，与text二选一，示例：new Tip().bindData({htmlText:"<font color='#ffffff'>显示的文字</font>"});
		 * @param text 格式[["显示的文本内容",12,"#ffffff",true],["显示的文本内容",字体大小,字体颜色,是否多行显示（默认为false）],[...]...]
		 * @param 示例：new Tip().bindData({img:"assets/images/sword/10000001.jpg",imgHeight:100,text:[["无双剑",14,"#FF000000"],["无双剑，天下无双。。。",12,"#FFFFFF",true]]});
		 * @param target 鼠标跟随对象，如果TIP需要跟随鼠标移动则需要将所触发的对象传进来
		 * @param
		 */		
		public function bindData(obj:Object,target:Object=null):void{
			clearThis();
			
			setTextField();
			if(obj.width){
				_w=obj.width;
			}
			this.width=_w;
			data=obj;
			if(obj.img){
				load.load(data.img,{onComplete:completeHandler});
			}
			if(obj.htmlText){
				txt.htmlText=obj.htmlText;
			}else if(obj.text){
				var n:int=obj.text.length;
				if(n<1){
					return;
				}
				for(var i:int=0;i<n;i++){
					showText(obj.text[i]);
				}
				txt.htmlText = str;
			}else{
				return;
			}
			if(target)targetObj=target;
			super.setBackGround(200 ,txt.y+txt.textHeight+20);
			
			showTip();
		}
		/**
		 *设置文本默认属性 
		 * 
		 */		
		private function setTextField():void{
			txt.x = _l;
			txt.y = _t;
			txt.width=_w-10;
			Common.setTextFilters(txt)
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.selectable = false;			
			txt.multiline=true;
			txt.wordWrap=true;
			txt.mouseEnabled=false;
			txt.textColor=0xffffff;
			this.addChild(txt);
		}
		/**
		 *显示提示 
		 * 
		 */		
		public function showTip():void{
			if(!Structure.getInstance().stage.contains(this)){
				Structure.getInstance().stage.addChild(this);
				MoveTip.getThis().checkMove(this);
				if(targetObj)targetObj.addEventListener(MouseEvent.MOUSE_MOVE,moveTip);
			}
		}
		/**
		 *隐藏提示 
		 * 
		 */		
		public function removeTip():void{
			if(Structure.getInstance().stage.contains(this)){
				Structure.getInstance().stage.removeChild(this);
				clearThis();
			}
		}
		private function moveTip(e:MouseEvent):void{
			MoveTip.getThis().checkMove(this);
		}
		/**
		 *加载图片
		 * @param e
		 * 
		 */		
		private function completeHandler(e:Event):void {
			if(data.imgW){
				e.currentTarget.content.width=data.imgW;
			}
			if(data.imgH){
				e.currentTarget.content.height=data.imgH;
			}
			e.currentTarget.content.x=_l;
			e.currentTarget.content.y=_t;
			this.addChild(e.target.content);
			txt.y=_t+e.target.content.height;
			_h=_t+e.target.content.height;
			
			super.setBackGround(200 ,txt.textHeight+_h+20 );
		}
		/**
		 * 设置文本
		 * @param arr
		 * 
		 */		
		private function showText(arr:Array):void{
			if(arr[1]!=null){
				textSize=arr[1];
			}
			if(arr[2]!=null){
				textColor=arr[2];
			}
			str+="<font color='"+textColor+"' size='"+textSize+"'>"+arr[0]+"</font><br>";
		}
		
		/**
		 *重置提示框 
		 * 
		 */		
		public function clearThis():void{
			_h=5;
			textSize=12;
			textColor="#ffffff";
			str="";
			txt.htmlText="";
			while(this.numChildren>0){
				this.removeChildAt(0);
			}
			if(targetObj)targetObj.removeEventListener(MouseEvent.MOUSE_MOVE,moveTip);
			targetObj=null;
		}
	}
}