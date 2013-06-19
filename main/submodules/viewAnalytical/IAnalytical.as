package main.submodules.viewAnalytical
{
	import flash.utils.Dictionary;
	
	import main.submodules.viewAnalytical.vo.AnalyticalVo;

	/**
	 *视图解析接口 
	 * @author phhui
	 * 
	 */	
	public interface IAnalytical
	{
		/**
		 * 
		 * @param ixml XML数据源 
		 * @param _parent 显示容器
		 * @param view 显示对象容器
		 * @param func 回调方法
		 * 
		 */		
		function analytical(ixml:XML,parent:Object,av:AnalyticalVo):void
	}
}