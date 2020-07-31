import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

//物业通知紧急程度（0-一般 1-重要 2-紧急）
const Map<int, String> urgentDegreeMap = {
  0: '一般',
  1: '重要',
  2: '紧急',
  null: '',
};
//物业通知紧急程度颜色（0-一般 1-重要 2-紧急）
const Map<int, Color> urgentDegree2ColorMap = {
  0: UIData.lightGreyColor,
  1: UIData.yellowColor,
  2: UIData.redColor,
  null: UIData.lightGreyColor,
};


const String messageTypeJSLT = 'JSLT';//集市聊天消息
const String messageTypeHDXX = 'HDXX';//互动消息
const String messageSubTypeREPLY = 'REPLY';//消息子类型：REPLY-评论/回复
const String messageSubTypeLIKE = 'LIKE';//消息子类型：LIKE-点赞
const String messageSubTypeWAREREPLY = 'WAREREPLY';//消息子类型：集市的评论/回复
const String messageSubTypeWARELIKE = 'WARELIKE';//消息子类型：集市的-点赞
const String messageSubTypeTOPICCOMMENT = 'TOPICCOMMENT';//消息子类型：话题的评论/回复
const String messageSubTypeTOPICLIKE = 'TOPICLIKE';//消息子类型：话题的-点赞
const String messageSubTypeTALKCOMMENT = 'TALKCOMMENT';//消息子类型：说说的评论/回复
const String messageSubTypeTALKLIKE = 'TALKLIKE';//消息子类型：说说的-点赞

//消息类型： GDXX:工单消息 YWBL:业务办理消息 QTXX:其他消息
const Map<String, String> messageCenterMap = {
  'GDXX': '工单消息',
  'YWBL': '业务办理消息',
  'QTXX': '其他消息',
  messageTypeHDXX: '互动消息',
  messageTypeJSLT: '集市聊天',
  '': '',
  null: '',
};
//消息类型对应图标： GDXX:工单消息 YWBL:业务办理消息 QTXX:其他消息
Map<String, Widget> messageCenter2IconMap = {
  'GDXX': UIData.iconMessageWorkOrder,
  'YWBL': UIData.iconMessageBusiness,
  'QTXX': UIData.iconMessageOther,
  messageTypeHDXX: UIData.iconMessageInteraction,
  messageTypeJSLT: UIData.iconMessageMarket,
  '': Container(),
  null: Container(),
};

////接收者是客户id的消息子类型
//const customerIdSubTypeList = [
//  messageSubTypeREPLY,
//  messageSubTypeLIKE
//];
//
////接收者是账号id的消息子类型
//const accountIdSubTypeList = [
//  messageSubTypeWAREREPLY,
//  messageSubTypeWARELIKE
//];

////互动消息子类型评论和回复
//const HDXXREPLYSubTypeList = [
//  messageSubTypeREPLY,
//  messageSubTypeWAREREPLY
//];
//
////互动消息子类型点赞
//const HDXXLIKESubTypeList = [
//  messageSubTypeLIKE,
//  messageSubTypeWARELIKE,
//];