import 'package:json_annotation/json_annotation.dart';

part 'high_frequency_words_model.g.dart';

///flutter packages pub run build_runner watch
@JsonSerializable()
class HighFrequencyWorks extends Object {

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'data')
  List<Data> datas;

  HighFrequencyWorks(this.code,this.message,this.datas,);

  factory HighFrequencyWorks.fromJson(Map<String, dynamic> srcJson) => _$HighFrequencyWorksFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HighFrequencyWorksToJson(this);

}


@JsonSerializable()
class Data extends Object {

  @JsonKey(name: 'attachmentId')
  int attachmentId;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'attachmentName')
  String attachmentName;



  Data(this.attachmentId,this.status,this.attachmentName,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}


