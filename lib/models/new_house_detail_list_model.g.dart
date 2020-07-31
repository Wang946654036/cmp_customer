// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_house_detail_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewHouseDetailListModel _$NewHouseDetailListModelFromJson(
    Map<String, dynamic> json) {
  return NewHouseDetailListModel(
    code: json['code'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : NewHouseDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NewHouseDetailListModelToJson(
        NewHouseDetailListModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'data': instance.data,
    };
