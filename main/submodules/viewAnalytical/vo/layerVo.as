package main.submodules.viewAnalytical.vo
{
	public class layerVo extends DisplayObj
	{
		public var resources:String;
		public var config:String;//解析文件路径，即该对象需要另外解析其它配置文件
		public var mask:String;//是否遮罩，是的话会自动添加滚动条
		public var align:String;
		public var rollOver:String;
		public var rollOut:String;
		public var showTip:String;
		public function layerVo()
		{
		}
	}
}