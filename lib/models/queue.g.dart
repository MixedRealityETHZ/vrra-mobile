// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueueItem _$QueueItemFromJson(Map<String, dynamic> json) => QueueItem(
      json['id'] as int,
      json['name'] as String,
      $enumDecode(_$QueueItemStatusEnumMap, json['status']),
      DateTime.parse(json['created'] as String),
      json['completed'] == null
          ? null
          : DateTime.parse(json['completed'] as String),
      json['started'] == null
          ? null
          : DateTime.parse(json['started'] as String),
      json['message'] as String,
      json['assetId'] as int,
      json['path'] as String,
    );

Map<String, dynamic> _$QueueItemToJson(QueueItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': _$QueueItemStatusEnumMap[instance.status]!,
      'created': instance.created.toIso8601String(),
      'completed': instance.completed?.toIso8601String(),
      'started': instance.started?.toIso8601String(),
      'message': instance.message,
      'assetId': instance.assetId,
      'path': instance.path,
    };

const _$QueueItemStatusEnumMap = {
  QueueItemStatus.pending: 'pending',
  QueueItemStatus.inProgress: 'inProgress',
  QueueItemStatus.completed: 'completed',
  QueueItemStatus.failed: 'failed',
};

PushQueueBody _$PushQueueBodyFromJson(Map<String, dynamic> json) =>
    PushQueueBody(
      json['name'] as String,
      json['assetId'] as int,
      json['path'] as String,
    );

Map<String, dynamic> _$PushQueueBodyToJson(PushQueueBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'assetId': instance.assetId,
      'path': instance.path,
    };
