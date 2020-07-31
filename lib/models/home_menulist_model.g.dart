// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_menulist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeMenuListModel _$HomeMenuListModelFromJson(Map<String, dynamic> json) {
  return HomeMenuListModel(
    menuList: (json['customerMenuVoList'] as List)
        ?.map((e) =>
            e == null ? null : MenuInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeMenuListModelToJson(HomeMenuListModel instance) =>
    <String, dynamic>{
      'customerMenuVoList': instance.menuList,
    };
