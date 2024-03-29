import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models/asset.dart';
import 'models/model.dart';
import 'models/queue.dart';
import 'models/room.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, this.statusCode);
}

abstract class JsonDeserializable {
  factory JsonDeserializable.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

class Api {
  static final baseUrl = Uri.https("vrra.howyoung.dev");
  final client = http.Client();

  static final instance = Api();

  Future<dynamic> apiCall(String method, String path, Object? body) async {
    var req = http.Request(method, baseUrl.resolve(path));
    if (body != null) {
      req.headers['Content-Type'] = 'application/json';
      req.body = jsonEncode(body);
    }
    var res = await client.send(req);
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw ApiException(await res.stream.bytesToString(), res.statusCode);
    }
    if (res.contentLength == 0) {
      return null;
    }
    var str = await res.stream.bytesToString();
    if (str.isEmpty) return null;
    return jsonDecode(str);
  }

  Future<List<QueueItem>> getQueue() async {
    var res = await apiCall('GET', '/queue', null);
    if (res is List) {
      return res.map((e) => QueueItem.fromJson(e)).toList();
    }
    throw TypeError();
  }

  Future<QueueItem> pushQueue(PushQueueBody body) async {
    var res = await apiCall('POST', '/queue', body);
    return QueueItem.fromJson(res);
  }

  Future<List<Room>> getRooms() async {
    var res = await apiCall('GET', '/rooms', null);
    if (res is List) {
      return res.map((e) => Room.fromJson(e)).toList();
    }
    throw TypeError();
  }

  Future<List<Model>> getModels() async {
    var res = await apiCall('GET', '/models', null);
    if (res is List) {
      return res.map((e) => Model.fromJson(e)).toList();
    }
    throw TypeError();
  }

  Future<Asset> getAsset(int id) async {
    var res = await apiCall('GET', '/assets/$id', null);
    return Asset.fromJson(res);
  }

  Future<Asset> addAsset(AddAssetBody body) async {
    var res = await apiCall('POST', '/assets', body);
    return Asset.fromJson(res);
  }

  Future setAssetUploaded(int id) async {
    await apiCall('POST', '/assets/$id/uploaded', null);
  }

  Future<Asset> uploadAsset(String name, Uint8List data) async {
    var asset = await addAsset(AddAssetBody(name));
    assert(asset.url != null);
    var url = Uri.parse(asset.url!).replace(scheme: 'https');
    var req = http.Request('PUT', url);
    req.headers['Content-Type'] = 'application/zip';
    req.bodyBytes = data;
    var res = await client.send(req);
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw ApiException(await res.stream.bytesToString(), res.statusCode);
    }
    await setAssetUploaded(asset.id);
    return asset;
  }
}
