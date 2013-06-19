package main.submodules.viewAnalytical.vo
{
	import flash.text.TextFormatAlign;
	
	import main.submodules.tools.ConfigTools;

	public class textVo extends DisplayObj
	{
		//自定义属性
		public var strokes:String;//是否描边
		public var textEvent:String;//在输入的时候是否实时实时监听
		public var clickEvent:String;//是否监听点击事件
		
		
		//格式属性
		//public var blockIndent:Object;//指示块缩进，以像素为单位。
		public var bold:Object;//指定文本是否为粗体字。
		//public var bullet:Object;//指示文本为带项目符号的列表的一部分。
		private var _color:uint=0xffffff;//指示文本的颜色。
		//public var constructor:Object;//对类对象或给定对象实例的构造函数的引用。Object
		public var font:String;//使用此文本格式的文本的字体名称，以字符串形式表示。
		//public var indent:Object;//指示从左边距到段落中第一个字符的缩进。
		//public var italic:Object;//指示使用此文本格式的文本是否为斜体。
		//public var kerning:Object;//一个布尔值，指示是启用(true)还是禁用(false)字距调整。
		public var leading:Object;//一个整数，表示行与行之间的垂直间距（称为前导）量。
		//public var leftMargin:Object;//段落的左边距，以像素为单位。
		//public var letterSpacing:Object;//一个整数，表示在所有字符间统一分配的空格量。
		//public var rightMargin:Object;//段落的右边距，以像素为单位。
		public var size:Object;//使用此文本格式的文本的磅值。
		//public var tabStops:Array;//将自定义Tab停靠位指定为一个非负整数的数组。
		//public var target:String;//指示显示超链接的目标窗口。
		public var underline:Object;//指示使用此文本格式的文本是带下划线(true)还是不带下划线(false)。
		//public var url:String;//指示使用此文本格式的文本的目标URL。
		
		//控件自带属性
		//public var antiAliasType:String;//用于此文本字段的消除锯齿类型。
		//public var background:Boolean;//指定文本字段是否具有背景填充。
		//public var backgroundColor:uint;//文本字段背景的颜色。
		public var border:Boolean;//指定文本字段是否具有边框。
		public var borderColor:uint;//文本字段边框的颜色。
		//public var displayAsPassword:Boolean;//指定文本字段是否是密码文本字段。
		private var _htmlText:String;//包含文本字段内容的HTML表示形式。
		//public var mouseWheelEnabled:Boolean;//一个布尔值，指示当用户单击某个文本字段且用户滚动鼠标滚轮时，FlashPlayer是否应自动滚动多行文本字段。
		public var multiline:Boolean;//指示文本字段是否为多行文本字段。
		public var scaleX:Object;//指示从注册点开始应用的对象的水平缩放比例（百分比）。
		public var scaleY:Object;//指示从对象注册点开始应用的对象的垂直缩放比例（百分比）。
		private var _text:String;//作为文本字段中当前文本的字符串。
		public var textColor:uint;//文本字段中文本的颜色（采用十六进制格式）。
		public var wordWrap:Boolean=false;//一个布尔值，指示文本字段是否自动换行。
		//public var alwaysShowSelection:Boolean;//如果设置为true且文本字段没有焦点，FlashPlayer将以灰色突出显示文本字段中的所选内容。
		//public var blendMode:String;//BlendMode类中的一个值，用于指定要使用的混合模式。
		//public var cacheAsBitmap:Boolean;//如果设置为true，则FlashPlayer将缓存显示对象的内部位图表示形式。
		//public var condenseWhite:Boolean;//一个布尔值，它指定是否应删除具有HTML文本的文本字段中的额外空白（空格、换行符等）。
		//public var defaultTextFormat:TextFormat;//指定应用于新插入文本（例如，使用replaceSelectedText()方法插入的文本或用户输入的文本）的格式。
		//public var embedFonts:Boolean;//指定是否使用嵌入字体轮廓进行呈现。
		//public var filters:Array;//包含当前与显示对象关联的每个滤镜对象的索引数组。
		//public var focusRect:Object;//指定此对象是否显示焦点矩形。
		//public var gridFitType:String;//用于此文本字段的网格固定类型。
		//public var mouseEnabled:Boolean;//指定此对象是否接收鼠标消息。
		//public var name:String;//指示的实例名称。
		//public var opaqueBackground:Object;//指定显示对象是否由于具有某种背景颜色而不透明。
		//public var restrict:String;//指示用户可输入到文本字段中的字符集。
		//public var rotation:Number;//指示实例距其原始方向的旋转程度，以度为单位。
		//public var scrollH:int;//当前水平滚动位置。
		//public var scrollV:int;//文本在文本字段中的垂直位置。
		//public var sharpness:Number;//此文本字段中字型边缘的清晰度。
		//public var styleSheet:StyleSheet;//将样式表附加到文本字段。
		//public var tabEnabled:Boolean;//指定此对象是否遵循Tab键顺序。
		//public var tabIndex:int;//指定SWF文件中的对象按Tab键顺序排列。
		//public var thickness:Number;//此文本字段中字型边缘的粗细。
		//public var useRichTextClipboard:Boolean;//指定在复制和粘贴文本时是否同时复制和粘贴其格式。
		//public var visible:Boolean;//显示对象是否可见。
		public function textVo()
		{
			super();
		}
		public function set text(value:String):void{
			_text=ConfigTools.getConfig(value);
		}
		public function get text():String{
			return _text;
		}
		public function set htmlText(value:String):void{
			_htmlText=ConfigTools.getConfig(value);
		}
		public function get htmlText():String{
			return _htmlText;
		}
		public function set color(value:String):void{
			_color=uint(value);
		}
		public function get color():String{
			return _color.toString();
		}
	}
}