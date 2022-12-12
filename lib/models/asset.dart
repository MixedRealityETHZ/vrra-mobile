import 'package:json_annotation/json_annotation.dart';

part 'asset.g.dart';

enum AssetStatus {
  @JsonValue('Uploading')
  uploading,
  @JsonValue('Ready')
  ready
}

@JsonSerializable()
class Asset {
  Asset(this.id, this.name, this.status, this.created, this.updated, this.url);

  int id;
  String name;
  AssetStatus status;
  DateTime created;
  DateTime updated;
  String? url;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);
}

@JsonSerializable()
class AddAssetBody {
  AddAssetBody(this.name);

  String name;

  factory AddAssetBody.fromJson(Map<String, dynamic> json) =>
      _$AddAssetBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddAssetBodyToJson(this);
}
