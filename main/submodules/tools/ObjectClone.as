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
			var typeName:String = getQualifiedClassName(source); //��ȡȫ��
			var packageName:String = typeName.split("::")[0]; //�г�����
			var type:Class = getDefinitionByName(typeName) as Class; //��ȡClass
			registerClassAlias(packageName, type); //ע��Class

			//���ƶ���
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
		 *�ϲ��������󲢷��غϲ���Ķ��� 
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
			var obj:Object = bytes.readObject();//������ת��Ϊԭ��Object�������޷�����
			for(var i in obj){
				if(toObj.hasOwnProperty(i)){
					if(obj[i]==null)continue;//���ֵΪ���������һѭ��
					if(toObj.hasOwnProperty("numChildren")&&toObj["numChildren"]<1&&(i=="width"||i=="height"))continue;//����������ǿ�sprite�������������ǿ����ִ�м�����һѭ��
					if(i=="width"&&obj[i].toString()=="0")continue;//������õ��ǿ����ֵΪ0����䣬������һѭ��
					if(i=="height"&&obj[i].toString()=="0")continue;
					if(obj[i].toString()=="NaN")continue;
					toObj[i]=obj[i];
					//trace("�������-->�������:"+i+"  ���ֵ��"+obj[i]+"  ����ֵΪ��"+toObj[i]);
				}
			}
		}
		
		
	}
}