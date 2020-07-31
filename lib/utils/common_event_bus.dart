//全局事件总线

//订阅者回调签名
typedef void EventCallBack(arg);

class CommonEventBus{
  //私有函数构造
  CommonEventBus._internal();
  //保存单例
  static CommonEventBus _singleBus = new CommonEventBus._internal();
  //工厂构造函数
  factory CommonEventBus()=>_singleBus;
  //保存事件订阅者，key：事件名（id）,value:对应事件的订阅者队列
  var _emap = new Map<Object,List<EventCallBack>>();
  //添加队列
  void on(eventName,EventCallBack f){
    if(eventName==null||f==null) return;
    _emap[eventName]??=new List<EventCallBack>();
    _emap[eventName].add(f);
  }

  //移除订阅者
  void off(eventName,[EventCallBack f]){
    var list = _emap[eventName];
    if(eventName==null||list==null) return;
    if(f!=null){
      list.remove(f);
    }else{
      _emap.remove(eventName);//移除当前实践所有订阅者
    }
  }

  //触发事件，事件触发后该事件所有订阅者都会被调用
  void emit(eventName,[arg]){
    var list = _emap[eventName];
    if(eventName==null||list==null) return;
    int len=list.length-1;
    //反向遍历，防止订阅者在回调中移除自身带来的下标错误
    for(int i=len;i>=0;i--){
      list[i](arg);
    }
  }
}
//定义一个top-level变量，页面引入该文件后可以直接使用bus
var parking_card_bus = new  CommonEventBus();
var entrance_card_bus = new  CommonEventBus();
var websocket_bus = new  CommonEventBus();