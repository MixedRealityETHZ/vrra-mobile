/*translate c# class to dart:
public enum AssetStatus
{
    Uploading,
    Ready,
}

public class Asset
{
    public int Id { get; set; }

    public string Name { get; set; } = "";

    public AssetStatus Status { get; set; }

    public DateTime Created { get; set; }

    public DateTime Updated { get; set; }

    public string? Url { get; set; }
    
}

public class AddAssetBody
{
    public string Name { get; set; } = "";
}
*/

import 'package:json_annotation/json_annotation.dart';

part 'asset.g.dart';

enum AssetStatus { uploading, ready }

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
