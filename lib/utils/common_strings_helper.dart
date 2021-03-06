import 'dart:convert';

import 'package:intl/intl.dart';


class StringsHelper {
  static final formatterMD = new DateFormat('MM-dd');
  static final formatterYMD = new DateFormat('yyyy-MM-dd');
  static final formatterYMDHms = new DateFormat('yyyy-MM-dd HH:mm:ss');

//  static final formatterYMDHMS = new DateFormat('yyyy-MM-dd HH:mm:ss');
  static final formatterMoney = new NumberFormat("#0.##");

  static final hotline = '400-882-1872';

//省份简称列表
  static List<String> provinceAbbrList = [
    '京',
    '津',
    '沪',
    '渝',
    '冀',
    '豫',
    '鲁',
    '晋',
    '陕',
    '皖',
    '苏',
    '浙',
    '鄂',
    '湘',
    '赣',
    '闽',
    '粤',
    '桂',
    '琼',
    '川',
    '贵',
    '云',
    '辽',
    '吉',
    '黑',
    '蒙',
    '甘',
    '宁',
    '青',
    '新',
    '藏',
    '港',
    '澳',
    '台',
  ];

//字母和数字列表
  static List<String> letterList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
    'M',
    'N',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];

  //计量方式：0-理重，1-称重
//  static Map<String, String> calMethodMap = {
//    '0': '理重',
//    '1': '称重',
//    '': '',
//    null: '',
//  };


//保留两位有效小数（防止小数点后两位都为0的情况）
  static String validDecimalFormat(value) {
    double doubleValue;
    if (value is String && value != null && value.isNotEmpty) {
      doubleValue = double.parse(value);
//      if (doubleValue > 1) {
      return moneyFormat(doubleValue);
//      } else {
////      MathContext mc = new MathContext(3);//所有数字的长度不大于2
////      BigDecimal bd = new BigDecimal(value, mc);
////      NumberFormat nf = NumberFormat.getInstance();
////      nf.setMaximumFractionDigits(8);//最大小数位数
//
//        return nf.format(bd);
//      }
    } else if (value is double && value != null) {
      return moneyFormat(value);
    } else
      return '';
  }

  static String moneyFormat(double obj) {
    return formatterMoney.format(obj);
  }

  // md5 加密
//  static String generateMd5(String data) {
//    var content = new Utf8Encoder().convert(data);
//    var digest = md5.convert(content);
//    // 这里其实就是 digest.toString()
//    return hex.encode(digest.bytes);
//  }



  static bool isEmpty(String content) {
    return content==null||content.trim().length==0;
  }

  static bool isNotEmpty(String content) {
    return content!=null&&content.trim().length>0;
  }

  //获取字符串
  static String getStringValue(value) {
    if(value==null){
      return "";
    }else{
      return value.toString();
    }
  }

  //获取字符串(优先选第一个)
  static String getValidStringValue(String value1,String value2) {
    if(value1==null||value1.isEmpty){
      if(value2==null){
        return "";
      }else{
        return value2.toString();
      }
    }else{
      return value1.toString();
    }
  }

  //获取整数
  static int getIntValue(value) {
    int reValue=0;
    try{
      reValue =int.parse(value);
    }catch(e){

    }
    return reValue;
  }

  //字符串转double
  static double getStringToDoubleValue(value) {
    double reValue=0;
    try{
      reValue =double.parse(value);
    }catch(e){

    }
    return reValue;
  }

  //double转字符串
  static String getDoubleToStringValue(double value) {
    if(value==null){
      return "0";
    }else{
      return value.toString();
    }
  }

  //判断是否是手机号码（以1开头的11位）
  static bool isPhone(String str) {
    if(str==null) return false;
    else return new RegExp('^1\\d{10}\$').hasMatch(str);
  }

  ///
  /// 判断是否车牌号，只判断是否7位数
  ///
  static bool isCarNo(String carNo) {
    return carNo != null && (carNo.length == 7 || carNo.length == 8);
  }

  //判断是否是邮箱
  static bool isEMail(String str) {
    if (str == null)
      return false;
    else
//      return new RegExp(r"^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$").hasMatch(str);
      return new RegExp(r"^\w+@[a-z0-9]+\.[a-z]{2,4}$").hasMatch(str);
  }

  ///
  /// 枚举类型转换成String
  ///
  static String enum2String(var data){
    return data.toString().split('.')[1];
  }

  //判断是否是纯数字
  static bool isNumber(String str) {
    if(str==null) return false;
    else return new RegExp('^\\d').hasMatch(str);
  }

  //判断是否是图片上传返回的uuid
  static bool isUuid(String str) {
    if (str == null)
      return false;
    else
      return new RegExp(r'^[a-z0-9\-]+$').hasMatch(str);
  }

  /*
  * Base64加密
  */
  static String encodeBase64(String data){
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /*
  * Base64解密
  */
  static String decodeBase64(String data){
    return String.fromCharCodes(base64Decode(data));
  }

  /*
  * 截取年月日时分
  */
  static String subString2YMDHM(String date){
    if(StringsHelper.isNotEmpty(date) && date.length == 19){
      date = date.substring(0, 16);
    }
    return date;
  }

  //判断是否包含特殊字符
  static bool isSpecialChar(String str) {
    RegExp regEx = RegExp("[\$()（）”“‘’\'\"]|-");
//    LogUtils.printLog('包含非法字符:${regEx.hasMatch(str)}');
    return regEx.hasMatch(str);
  }

}

