// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      json['id'] as int,
      json['name'] as String,
      json['thumbnailAssetId'] as int?,
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnailAssetId': instance.thumbnailAssetId,
    };
