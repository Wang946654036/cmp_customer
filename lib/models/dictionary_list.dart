import 'package:json_annotation/json_annotation.dart';

part 'dictionary_list.g.dart';


@JsonSerializable()
class DictionaryList extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<Dictionary> data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  DictionaryList(this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory DictionaryList.fromJson(Map<String, dynamic> srcJson) => _$DictionaryListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DictionaryListToJson(this);

}


@JsonSerializable()
class Dictionary extends Object {

  @JsonKey(name: 'dataCode')
  String dataCode;

  @JsonKey(name: 'dataDesc')
  String dataDesc;

  @JsonKey(name: 'dataName')
  String dataName;

  @JsonKey(name: 'dataSubType')
  String dataSubType;

  @JsonKey(name: 'dataType')
  String dataType;

  @JsonKey(name: 'dictionaryId')
  int dictionaryId;

  @JsonKey(name: 'sortNo')
  int sortNo;

  @JsonKey(name: 'specialInfo')
  String specialInfo;

  @JsonKey(name: 'validFlag')
  String validFlag;

  Dictionary(this.dataCode,this.dataDesc,this.dataName,this.dataSubType,this.dataType,this.dictionaryId,this.sortNo,this.specialInfo,this.validFlag,);

  factory Dictionary.fromJson(Map<String, dynamic> srcJson) => _$DictionaryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DictionaryToJson(this);

}


