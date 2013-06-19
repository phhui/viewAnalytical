package main.submodules.tools
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class ObjectClone
	{
		public static function cloneObject(source:Object):*
		{
			var typeName:String = getQualifiedClassName(source); //获取全名
			var packageName:String = typeName.split("::")[0]; //切出包名
			var type:Class = getDefinitionByName(typeName) as Class; //获取Class
			registerClassAlias(packageName, type); //注册Class

			//复制对象
			var copier:ByteArray = new ByteArray();
			copier.writeObject(source);
			copier.position = 0;
			return copier.readObject();
		}

		public static function copy(fObject:Object, tObject:*):*
		{
			for (var key:String in fObject)
			{
				if (tObject.hasOwnProperty(key))
				{
					if (fObject[key] is Number || fObject[key] is String || fObject[key] is Boolean || fObject[key] is Array)
					{
						tObject[key] = fObject[key];
					}
					else if (fObject[key] is Object)
					{
						tObject[key] = copy(fObject[key], tObject[key]);
					}
				}
			}
			return tObject;
		}
		/**
		 *合并两个对象并返回合并后的对象 
		 * @param fobj
		 * @param tobj
		 * @return 
		 * 
		 */		
		public static function joinObj(fobj:Object,tobj:Object):Object{
			for(var i in fobj){
				tobj[i]=fobj[i];
			}
			return tobj;
		}
		public static function transObj2Dict(obj:Object,dict:Dictionary){
			for (var key in obj){
				dict[key] = obj[key];
			}
		}
		public static function fillObj(fromObj:Object,toObj:Object):void{
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(fromObj);
			bytes.position = 0;
			var obj:Object = bytes.readObject();//将对象转换为原生Object，否则无法遍历
			for(var i in obj){
				if(toObj.hasOwnProperty(i)){
					if(obj[i]==null)continue;//如果值为空则继续下一循环
					if(toObj.hasOwnProperty("numChildren")&&toObj["numChildren"]<1&&(i=="width"||i=="height"))continue;//如果填充对象是空sprite而且填充的属性是宽高则不执行继续下一循环
					if(i=="width"&&obj[i].toString()=="0")continue;//如果设置的是宽高且值为0则不填充，继续下一循环
					if(i=="height"&&obj[i].toString()=="0")continue;
					if(obj[i].toString()=="NaN")continue;
					toObj[i]=obj[i];
					//trace("对象填充-->填充属性:"+i+"  填充值："+obj[i]+"  填充后值为："+toObj[i]);
				}
			}
		}
		
		
	}
}