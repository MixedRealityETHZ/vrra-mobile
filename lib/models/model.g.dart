// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$ModelFromJson(Map<String, dynamic> json) => Model(
      json['id'] as int,
      json['name'] as String,
      json['path'] as String,
      json['assetId'] as int,
      json['thumbnailAssetId'] as int?,
    );

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'path': instance.path,
      'assetId': instance.assetId,
      'thumbnailAssetId': instance.thumbnailAssetId,
    };
