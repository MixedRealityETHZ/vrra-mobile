import 'package:json_annotation/json_annotation.dart';

part 'queue.g.dart';

enum QueueItemStatus { pending, inProgress, completed, failed }

@JsonSerializable()
class QueueItem {
  QueueItem(this.id, this.name, this.status, this.created, this.completed,
      this.started, this.message, this.assetId, this.path);

  int id;
  String name;
  QueueItemStatus status;
  DateTime created;
  DateTime? completed;
  DateTime? started;
  String message;
  int assetId;
  String path;

  factory QueueItem.fromJson(Map<String, dynamic> json) =>
      _$QueueItemFromJson(json);

  Map<String, dynamic> toJson() => _$QueueItemToJson(this);
}

@JsonSerializable()
class PushQueueBody {
  PushQueueBody(this.name, this.assetId, this.path);

  String name;
  int assetId;
  String path;

  factory PushQueueBody.fromJson(Map<String, dynamic> json) =>
      _$PushQueueBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PushQueueBodyToJson(this);
}
