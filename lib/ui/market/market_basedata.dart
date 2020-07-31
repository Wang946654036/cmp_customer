import 'dart:ui';

import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';

const Map<String, String> MarketTypeMap = {
  'XSY': '小生意',
  'ES': '二手',
  'ZJ': '租借',
  'ZS': '赠送',
};

Color getMarketTypeColor(String type){
  Color color = UIData.greenColor;
  switch(type){
    case "XSY":
      color = UIData.marketOrangeColor;
      break;
    case "ES":
      color = UIData.marketGreenColor;
      break;
    case "ZJ":
      color = UIData.marketBlueColor;
      break;
    case "ZS":
      color = UIData.marketVioletColor;
      break;
  }
  return color;
}

enum MarketType {
  XSY, //小生意
  ES, //二手
  ZJ, //租借
  ZS //赠送
}

MarketType getEnumMarket(String type){
  MarketType marketType = MarketType.XSY;
  switch(type){
    case "XSY":
      marketType = MarketType.XSY;
      break;
    case "ES":
      marketType = MarketType.ES;
      break;
    case "ZJ":
      marketType = MarketType.ZJ;
      break;
    case "ZS":
      marketType = MarketType.ZS;
      break;
  }
  return marketType;
}

//获取项目名称和城市
String getProjectAndCity(String projectName,String city){
  StringBuffer _buffer = new StringBuffer();
  if(StringsHelper.isNotEmpty(projectName)){
    _buffer.write(projectName);
    if(StringsHelper.isNotEmpty(city)){
      _buffer.write('（${city??""}）');
    }
  }
  return _buffer.toString();
}
//获取价格和单位
String getPriceAndUnit(String price,String unit){
  StringBuffer _buffer = new StringBuffer();
  if(StringsHelper.isNotEmpty(price)){
    _buffer.write('￥${StringsHelper.validDecimalFormat(price)??""}');
    if(StringsHelper.isNotEmpty(unit)){
      _buffer.write('/${unit??""}');
    }
  }
  return _buffer.toString();
}


const String websocket_message = "websocket_message";


