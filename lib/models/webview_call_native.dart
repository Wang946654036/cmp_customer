import 'package:json_annotation/json_annotation.dart';

part 'webview_call_native.g.dart';


@JsonSerializable()
class WebViewCallNative extends Object {


  @JsonKey(name: 'functionName')
  String functionName;

  @JsonKey(name: 'data')
  var data;

  @JsonKey(name: 'successCallback')
  String successCallback;

  @JsonKey(name: 'errorCallback')
  String errorCallback;

  WebViewCallNative();

  factory WebViewCallNative.fromJson(Map<String, dynamic> srcJson) => _$WebViewCallNativeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WebViewCallNativeToJson(this);

}
