package main.submodules.viewAnalytical.AnalyticalClass
{
	import main.submodules.tools.ButtonImageData;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class SimpleButton extends Sprite
	{	
		/** 一般状态*/
		public static const upSkin:String 		= "upSkin";
		/** 鼠标经过*/
		public static const overSkin:String 		= "overSkin";
		/** 鼠标点击*/
		public static const downSkin:String 		= "downSkin";
		/** 不可点击*/
		public static const disabledSkin:String 	= "disabledSkin";
		/** 点击后， 停留在该图*/
		public static const clickSkin:String 		= "clickSkin";
	
		var sp_image:ButtonImageData ;
		
		var image_arr:Array ;
		
		/** 点击后， 是否停止在点击图片状态*/
		var is_leave_click:Boolean = false ;
		
		/** 图片是否是可以点击的*/
		var clickAble:Boolean = true ;
		
		var btnText:TextField;
		
		/** 当前的状态是否为选中状态*/
		var current_state:Boolean = false ;
		
		public function SimpleButton(_is_leave_click:int = 0 )
		{
			if(_is_leave_click == 1){
				is_leave_click = true ;
			}else{
				is_leave_click = false ;
			}
			
			sp_image = new ButtonImageData();
			
			image_arr = new Array();
			
			this.buttonMode = true ;
		}
		/** 初始化按钮的图片 */
		public function setButtonStyle(action:String , _image:Sprite):void
		{
			if(!_image){
				return ;
			}
			if(sp_image[action]){
				
				if(this.contains(sp_image[action])){
					
					this.removeChild(sp_image[action]);
				}
			}
			image_arr.push(_image);
			sp_image[action] = _image;
			this.addChild(sp_image[action]);
			
			updateButtonState(upSkin);
		}
		/** 设置按钮是否变灰 */
		public function set setDisAble(eFlag:Boolean){
			clickAble = eFlag;
			if(clickAble){//可用
				updateButtonState(upSkin);
			}else{//不可用
				updateButtonState(disabledSkin);
			}
		}
		/**
		 *名字不一样导致在判断是否存在某属性时会报错说只写属性 
		 * @return 
		 * 
		 */		
		public function get setDisAble():Boolean{
			return clickAble;
		}
		/** 返回此按钮当前的状态*/
		public function get getDisAble():Boolean
		{
			return clickAble ;
		}
		/** 获取当前有活动的对象*/
		public function get getActionImage():Sprite
		{
			if(sp_image[upSkin]){
				return sp_image[upSkin];
			}
			return null ;
		}
		
		public function onMouseClick(){			
	
			if(is_leave_click){//可以停留在选中状态
				current_state = true ;
			}
						
			updateButtonState(clickSkin);			
		}
		public function onMouseMoves(){
			if(current_state){
				return ;
			}
			updateButtonState(overSkin);
			
		}
		public function onMouseOut(){
			if(current_state){
				return ;
			}
			updateButtonState(upSkin);
			
		}
		/** 显示按钮的指定*/
		public function showSpecImage(show_image:String="clickSkin"):void
		{
			if(show_image!=clickSkin){
				current_state = false ;
			}else{
				current_state = true ;
			}
			
			updateButtonState(show_image);
		}
		/** 改变按钮的状态 */
		private function updateButtonState(show_image:String):void
		{	
			if(btnText){
				this.addChild(btnText);
			}
			
			for each(var _obj in image_arr){
				if(_obj){
					_obj.visible = false ;
					
				}
			}
			if(!clickAble){//变灰， 不能有任何效果				
				sp_image[upSkin].visible = true ;
				if(sp_image[disabledSkin]){
					addChild(sp_image[disabledSkin]);
					sp_image[disabledSkin].visible = true ;
				}
				
				return ;
			}
			sp_image[upSkin].visible = true ;
			
			if(current_state){//如果当前状态是“选中状态”， 就显示选中的图片
				if(sp_image[clickSkin]){
					sp_image[clickSkin].visible = true ;
					return ;
				}
			}
			if(!sp_image[show_image]){//当前要显示的图片是否存在， 不存在就直接显示一般状态
//				sp_image[upSkin].visible = true ;
				return ;
			}
			sp_image[show_image].visible = true ;
		}
		
		//public function setLabel(eValue:String, _width:Number =100, _height:Number):void
		public function set setLabel(eValue:String):void	
		{
			if(!btnText){
				btnText = new TextField();
				
				
				btnText.defaultTextFormat=new TextFormat("宋体",14,0xffffff);
				btnText.textColor=0xffffff;
//				btnText.autoSize = TextFieldAutoSize.CENTER;
				btnText.mouseEnabled=false;
				
				btnText.x= 0 ;
				btnText.y= 150;
				
				btnText.x=this.width/2-btnText.width/2;
				btnText.y=this.height/2-btnText.height/2;
				
				var gf:GlowFilter = new GlowFilter();
				gf.color = 0x000000;
				gf.alpha = 1;
				gf.blurX = 3.5;
				gf.blurY = 3.5;
				gf.strength = 5;
				
				btnText.filters = [gf];
			}
			this.addChild(btnText);
			btnText.htmlText=eValue;
		}
	}
}