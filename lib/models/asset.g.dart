// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      json['id'] as int,
      json['name'] as String,
      $enumDecode(_$AssetStatusEnumMap, json['status']),
      DateTime.parse(json['created'] as String),
      DateTime.parse(json['updated'] as String),
      json['url'] as String?,
    );

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': _$AssetStatusEnumMap[instance.status]!,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
      'url': instance.url,
    };

const _$AssetStatusEnumMap = {
  AssetStatus.uploading: 'uploading',
  AssetStatus.ready: 'ready',
};

AddAssetBody _$AddAssetBodyFromJson(Map<String, dynamic> json) => AddAssetBody(
      json['name'] as String,
    );

Map<String, dynamic> _$AddAssetBodyToJson(AddAssetBody instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
