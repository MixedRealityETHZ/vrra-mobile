import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Model {
  Model(this.id, this.name, this.path, this.assetId, this.thumbnailAssetId);

  int id;
  String name;
  String path;
  // List<double>? bounds;
  int assetId;
  int? thumbnailAssetId;

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModelToJson(this);
}
