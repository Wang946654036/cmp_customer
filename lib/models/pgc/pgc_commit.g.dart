// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgc_commit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PgcCommit _$PgcCommitFromJson(Map<String, dynamic> json) {
  return PgcCommit(
    json['deleteReason'] as String,
    json['like'] as String,
    json['pgcCommentId'] as int,
    json['reply'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$PgcCommitToJson(PgcCommit instance) => <String, dynamic>{
      'deleteReason': instance.deleteReason,
      'like': instance.like,
      'pgcCommentId': instance.pgcCommentId,
      'reply': instance.reply,
      'type': instance.type,
    };
