package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class SmileBtn extends MovieClip
	{
		private var btnText:TextField=new TextField();
		private var btnSelect:Boolean=false;
		private var _autoChange:Boolean=false;
		public function SmileBtn()
		{
			intoBtn();
		}
		public function intoBtn():void{
			this.buttonMode=true;
			this.gotoAndStop(1);
			this.addEventListener(MouseEvent.ROLL_OVER,btnOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT,btnOutHandler);
			this.addEventListener(MouseEvent.ROLL_OUT,btnDownHandler);
			this.addEventListener(MouseEvent.ROLL_OUT,btnUpHandler);
			this.addEventListener(MouseEvent.MOUSE_UP,btnClickHandler);
		}
		private function btnOverHandler(e:MouseEvent):void{
			e.target.gotoAndStop(2);
		}
		private function btnOutHandler(e:MouseEvent):void{
			if(!btnSelect&&e.target.currentFrame!=4){
				e.target.gotoAndStop(1);
			}else{
				btnSelect=false;
			}
		}
		private function btnDownHandler(e:MouseEvent):void{
			e.target.gotoAndStop(3);
		}
		private function btnUpHandler(e:MouseEvent):void{
			e.target.gotoAndStop(1);
		}
		private function btnClickHandler(e:MouseEvent):void{
			if(!_autoChange){
				return;
			}
			btnSelect=true;
			this.changeFlag=true;
			e.target.gotoAndStop(4);
			if(e.target.currentFrame<4){
				e.target.gotoAndStop(1);
			}
		}
		/**
		 * 设置是否选中状态
		 * */
		public function set changeFlag(bl:Boolean):void{
			if(bl){
				this.gotoAndStop(4);
			}else{
				this.gotoAndStop(1);
				btnSelect=false;
			}
		}
		/**
		 * 设置是否可用
		 * */
		public function set enableFlag(bl:Boolean):void{
			if(bl){
				this.gotoAndStop(5);
				this.mouseEnabled=false;
				this.mouseChildren=false;
			}else{
				this.gotoAndStop(1);
				this.mouseEnabled=true;
				this.mouseChildren=true;
				btnSelect=false;
			}
		}
		public function set autoChange(bl:Boolean):void{
			_autoChange=bl;
		}
		/**
		 * 设置按钮是否可见
		 *  
		 * */
		public function set visibleFlag(bl:Boolean):void{
			this.visible=bl;	
		}
		/**
		 * 设置是否启用鼠标事件
		 * 
		 * */
		public function set buttonModes(bl:Boolean):void{
			this.buttonMode=bl;
			if(!bl){
				this.removeEventListener(MouseEvent.ROLL_OVER,btnOverHandler);
				this.removeEventListener(MouseEvent.ROLL_OUT,btnOutHandler);
			}
		}
		/**
		 * 设置按钮文字
		 * */
		public function set labelValue(str:String):void{
			this.addChild(btnText);
			btnText.htmlText=str;
			btnText.defaultTextFormat=new TextFormat("宋体",14,0xffffff);
			btnText.textColor=0xffffff;
			btnText.autoSize = TextFieldAutoSize.CENTER;
			btnText.mouseEnabled=false;
			btnText.x=this.width/2-btnText.width/2;
			btnText.y=this.height/2-btnText.height/2;
		}
		public function get labelValue():String{
			return btnText.htmlText;
		}
	}
}