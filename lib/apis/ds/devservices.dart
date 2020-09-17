import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'decrypt_response.dart';

/// Descriptografa um evento.
Future<DecryptResponse> decryptEvent({
  @required Dio client,
  @required String event,
  @required String endpoint,
}) async {
  final response = await client.post('$endpoint/process_log2', data: event);

  if (response.statusCode == 200)
    return DecryptResponse.fromJson(response.data);

  return null;
}

/// Descriptografa um arquivo.
Future<DecryptResponse> decryptFile({
  @required Dio client,
  @required FormData data,
  @required String endpoint,
}) async {
  final response = await client.post('$endpoint/upload', data: data);

  if (response.statusCode == 200)
    return DecryptResponse.fromJson(response.data);

  return null;
}
