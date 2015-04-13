/**
 * Created by Mr.zheng on 15-2-14.
 */
package com.bit101.components{
public class ItemData {
    public var depth:int;//深度
    public var parent:Object;//父节点
    public var data:Object;
    public var label:String;
    public var isExpand:Boolean=false;//已经展开
    public static function packItemData(xml:XML,parent,depth):ItemData {
        var item:ItemData=new ItemData();
        item.data=xml;
        item.depth=depth;
        item.parent=parent;
        item.label=xml.@label;
        
        if(xml.children()<1){
            item.isExpand=true;
            
        }
        
        var space:String = "";
        var i=0;
        while(i<depth){
            space+="      ";
            i++;
        }
        item.label=space+item.label;
        return item;
    }

    /**
     * 是否目标对象的子孙*
     * @param target
     * @return
     */
    public function isTargetChild(target:ItemData):Boolean {
        var p=parent;
        while(p) {
            if(p==target)return true;
            p=p.parent;
        }
        return false;
    }

    /**
     * 根据xml生成items
     * @param xml
     * @return
     * @param parent
     * @param depth
     */
    public static function parseXml(xml:XML,parent=null,depth=0):Array {

        var a:Array = [];
        var xl:XMLList=xml.children();
        var item:ItemData;
        var len:int=xl.length();
        var x:XML;
        for(var i:int=0;i<len;i++){
            x = xl[i];
            item=packItemData(x,parent,depth);
            a.push(a);
        }
        return a;

    }
}
}
