import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  Room(this.id, this.name, this.thumbnailAssetId);

  int id;
  String name;
  int? thumbnailAssetId;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}