import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/chat_history_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/market/market_basedata.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

//websocket通道
mixin WebSocketStateModel on Model {
  IOWebSocketChannel channel;
  String sendText;
  //初始化聊天
  void initWebSocket() async {
    if(channel==null){
      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
      var headers = {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        HttpHeaders.authorizationHeader:
        'Bearer ${prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN)}'
      };
//    String url = "ws://3038sf5682.zicp.vip/ubms-customer/ubmsWs";
      String url = HttpOptions.baseUrl.replaceAll("http", "ws")+"ubmsWs";
      channel = await IOWebSocketChannel.connect(url, headers: headers);
      print("连接成功");
      channel.stream.listen((message) {
        _receiveMessage(message?.toString());
      }, onError: (err) {
        print("接收报错" + err?.toString());
        closeWebSocket();
      }, onDone: () {
        closeWebSocket();
        print("连接结束Socket is closed");
      });
      //把之前未发送的数据发送出去
      if(sendText?.isNotEmpty??false){
        channel.sink.add(sendText);
        sendText = null;
      }
    }


  }

  void sendMessage(String message){
    if(channel==null){
      sendText = message;
//      CommonToast.show(msg: "正在初始化聊天，请稍后",type: ToastIconType.INFO);
      initWebSocket();
    }else{
      channel.sink.add(message);
    }
  }

  void _receiveMessage(String message){
    //发送给各个地方
    try{
      if(message?.isNotEmpty??false) {
        ChatHistory info = ChatHistory.fromJson(json.decode(message));
        websocket_bus.emit(websocket_message,info);
      }
    }catch(e){
      LogUtils.printLog(e?.toString()??"");
    }
  }



  void closeWebSocket() {
    //退出页面，关闭
    channel?.sink?.close();
    channel = null;
  }
}