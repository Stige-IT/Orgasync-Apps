import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:orgasync/src/utils/helper/http_provider/http_provider.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage_client.dart';

import '../local_storage/secure_storage.dart';

final httpRequestProvider = Provider<HttpRequest>((ref) {
  return HttpRequest(ref.watch(httpProvider), ref.watch(storageProvider));
});

class HttpRequest {
  final Client _client;
  final SecureStorage storage;

  HttpRequest(this._client, this.storage);

  Future<Either<String, dynamic>> get(String url) async {
    final token = await storage.read("token");
    final response = await _client
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return right(result);
    } else {
      return left("error".tr());
    }
  }

  Future<Either<String, dynamic>> post(String url,
      {required Map<String, dynamic> body}) async {
    final token = await storage.read("token");
    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    final response = await _client.post(Uri.parse(url),
        body: jsonEncode(body), headers: headers);
    if (response.statusCode == 201) {
      return right(true);
    } else {
      return left("error".tr());
    }
  }

  // put
  Future<Either<String, bool>> put(String url,
      {Map<String, dynamic>? data}) async {
    final token = await storage.read("token");
    final response = await _client.put(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return right(true);
    } else {
      return left("error".tr());
    }
  }

  // multipart post / put
  Future<Either<String, bool>> multipart(String method, String url,
      {Map<String, String>? data, File? file, String? fieldFile}) async {
    final token = await storage.read("token");
    final request = MultipartRequest(method, Uri.parse(url));
    request.headers.addAll({"Authorization": "Bearer $token"});
    request.fields.addAll(data!);
    if (file != null) {
      final multipartFile = MultipartFile.fromBytes(
        fieldFile!,
        file.readAsBytesSync(),
        filename: file.path.split("/").last,
      );
      request.files.add(multipartFile);
    }
    final response = await request.send();
    if (kDebugMode) {
      print(await response.stream.bytesToString());
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        return right(true);
      default:
        return left("error".tr());
    }
  }

  // delete
  Future<Either<String, bool>> delete(String url) async {
    final token = await storage.read("token");
    final response = await _client
        .delete(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      return right(true);
    } else if (response.statusCode == 401) {
      return left(jsonDecode(response.body)['message']);
    } else {
      return left("error".tr());
    }
  }
}
