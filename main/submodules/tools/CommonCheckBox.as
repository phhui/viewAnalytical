package main.submodules.tools
{
	import fl.controls.CheckBox;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextFormat;

	/**
	 * 复选框按钮
	 */
	public class CommonCheckBox extends CheckBox
	{
		public function CommonCheckBox()
		{
			var tfNormal:TextFormat = new TextFormat();
			tfNormal.font = "宋体";
			tfNormal.size = 12;
			tfNormal.color = 0xffffff;
			
			var tfDisabled:TextFormat = new TextFormat();
			tfDisabled.font = "宋体";
			tfDisabled.size = 12;
			tfDisabled.color = 0xcccccc;
			
			this.width = 16;
			this.height = 16;
		}
		override protected function configUI():void {
			super.configUI();
			textField.width = 20;
			textField.height = 20;
			background.width = 20;
			background.height = 20;
		}
	}
}