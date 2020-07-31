// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_release_detail_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorReleaseDetailListModel _$VisitorReleaseDetailListModelFromJson(
    Map<String, dynamic> json) {
  return VisitorReleaseDetailListModel(
    code: json['code'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : VisitorReleaseDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VisitorReleaseDetailListModelToJson(
        VisitorReleaseDetailListModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'data': instance.data,
    };
