// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webview_call_native.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebViewCallNative _$WebViewCallNativeFromJson(Map<String, dynamic> json) {
  return WebViewCallNative()
    ..functionName = json['functionName'] as String
    ..data = json['data']
    ..successCallback = json['successCallback'] as String
    ..errorCallback = json['errorCallback'] as String;
}

Map<String, dynamic> _$WebViewCallNativeToJson(WebViewCallNative instance) =>
    <String, dynamic>{
      'functionName': instance.functionName,
      'data': instance.data,
      'successCallback': instance.successCallback,
      'errorCallback': instance.errorCallback,
    };
