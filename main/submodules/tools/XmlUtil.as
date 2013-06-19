package main.submodules.tools
{
	import flash.xml.XMLDocument;
	
	public class XmlUtil
	{
		/** XML属性值列表XMLList 转为 Object对象 */
		public static function AttributeToObject(xml:XML):Object {
			var actiondata:Object = new Object();
			var attNamesList:XMLList = xml.@*;	
			for (var i:int = 0; i < attNamesList.length(); i++)
				actiondata[String(attNamesList[i].name())] = attNamesList[i].toString();
			return actiondata;
		}
		
        
		/** xml 转换为 object 对象 **/
		public static function xmlToObj(el:XML,obj:Object):Object {
			for each(var item:XML in el.elements())
			    if(obj.hasOwnProperty(item.name()))
					obj[item.name()] = item;
			return obj;
		}
		
		/** xml属性值列表xmllist转为指定对象 */
		public static function AbtToObject(xml:XML,obj:Object):Object {
			var attNamesList:XMLList = xml.@*;	
			for (var i:int = 0; i < attNamesList.length(); i++)
				if(obj.hasOwnProperty(String(attNamesList[i].name())))
					obj[String(attNamesList[i].name())] = attNamesList[i].toString();
			return obj;
		}        	
	}
}