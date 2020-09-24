import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'decrypt_response.dart';

/// Descriptografa um evento.
Future<DecryptResponse> decryptEvent({
  @required Dio client,
  @required String event,
  @required String endpoint,
}) async {
  final response = await client.get(
    '$endpoint/process_log/$event',
  );

  if (response.statusCode == 200)
    return DecryptResponse.fromJson(response.data);

  return null;
}

/// Descriptografa um arquivo.
Future<DecryptResponse> decryptFile({
  @required Dio client,
  @required FormData data,
  @required String endpoint,
  Options options,
}) async {
  if (options == null)
    options = Options(contentType: Headers.formUrlEncodedContentType);

  final response = await client.post(
    '$endpoint/upload',
    data: data,
    options: options,
  );

  if (response.statusCode == 200)
    return DecryptResponse.fromJson(response.data);

  return null;
}

/// Descriptografa um arquivo.
Future<Map<String, dynamic>> decryptF10({
  @required Dio client,
  @required Map<String, dynamic> data,
  @required String endpoint,
}) async {
  final response = await client.post('$endpoint/decrypt_f10', data: data);

  return response.statusCode == 200 ? response.data : null;
}
