/**
 * Created by Mr.zheng on 15-2-13.
 */
package com.bit101.components{
import com.bit101.components.List;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;

public class Tree extends List {
    public function Tree(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, items:Array = null) {
        super(parent, xpos, ypos, items);
        listItemClass=TreeItem;
        autoHideScrollBar=true;
    }

    override protected function init():void {
        super.init();
        setSize(100, 100);
        addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
        addEventListener(Event.RESIZE, onResize);
        addEventListener(Event.SELECT, function (e) {
            if(selectedItem.isExpand){
                collapse(selectedItem);
            }else{
                expand(selectedItem);
            }
        });
        makeListItems();
        fillItems();
    }

    /**
     * 展开，添加新的listItem*
     * @param data
     */
    public function expand(data):void {
        if(data.isExpand){
            return ;
            
        }else{
            data.isExpand=true;
            
        }
        
        var index = items.indexOf(data);
        var x:XML=data.data as XML;
        var xl:XMLList=x.children();
        var len:int=xl.length();
        var itemData:ItemData;
        var space:String="";
        var depth=data.depth;
        var a:Array = [];
        var refresh:Boolean=false;
        for(var i:int=0;i<len;i++){
            itemData=new ItemData();
            itemData.data = xl[i];
            itemData.parent=data;
            itemData.depth=depth+1;

            x = xl[i];
            
            var j=0;
            space="";
            while(j<itemData.depth){
                space+="      ";
                j++;
            }
            itemData.label=space+x.@label;
            a.push(itemData);
        }
        var b = [index+1,0];
        if(a.length>0)refresh=true;
        for(var k=0;k<a.length;k++) {
            b.push(a[k]);
        }
        _items.splice.apply(null, b);
        items.concat();
        if(refresh) {
            invalidate();
            makeListItems();
            fillItems();
        }
    }

    /**
     * 收缩，删除该节点的子*
     * @param item
     */
    public function collapse(item):void {
        item.isExpand=false;
        var index = _items.indexOf(item);
        var data;
        var len:int=_items.length;
        var refresh:Boolean=false;//是否需要刷新
        index++;
        while(index<len){
            data = _items[index];
            if(data.isTargetChild(item)){
                _items.splice(index, 1);
                len--;
                refresh=true;
            }else{
                break;
            }
            
        }
        if(refresh) {
            invalidate();
            makeListItems();
            fillItems();
        }
    }
}
}
