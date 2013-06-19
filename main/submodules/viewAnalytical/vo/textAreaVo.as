package main.submodules.viewAnalytical.vo
{
	import fl.controls.ScrollPolicy;
	
	import flash.text.TextFormatAlign;

	public class textAreaVo extends textVo
	{		
		//控件自带属性
		public var align:String=TextFormatAlign.CENTER;//指示段落的对齐方式。
		public var doubleClickEnabled:Boolean;//指定此对象是否接收doubleClick事件。
		public var maxChars:int=20;//文本字段中最多可包含的字符数（即用户输入的字符数）。
		public var editable:Boolean = false ;//获取或设置一个布尔值，指示用户能否编辑组件中的文本。
		public var horizontalScrollPolicy:String=ScrollPolicy.OFF;//获取或设置水平滚动条的滚动策略。
		public var horizontalScrollPosition:Object;//获取或设置用户水平滚动文本字段后滚动条滑块位置的变化，以像素为单位。
		public var mouseChildren:Boolean=true;//确定对象的子项是否支持鼠标。
		public var useHandCursor:Boolean;//布尔值，指示当鼠标滑过其buttonMode属性设置为true的时是否显示手指形（手形光标）。
		public var verticalScrollPolicy:String=ScrollPolicy.OFF;//获取或设置垂直滚动条的滚动策略。
		public var verticalScrollPosition:Object;//获取或设置用户垂直滚动文本字段后滚动条滑块位置的变化，以像素为单位。
		
		public var selectable:Boolean=false;//一个布尔值，指示文本字段是否可选。
		public function textAreaVo()
		{
			super();
		}
	}
}