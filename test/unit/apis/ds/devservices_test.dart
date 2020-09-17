import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/apis/ds/decrypt_response.dart';
import 'package:myapp/apis/ds/devservices.dart';

import '../../mocks.dart';

main() {
  final faker = Faker();

  Dio client;
  String endpoint;

  setUp(() {
    client = DioMock();
    endpoint = faker.internet.domainName();
  });

  group('Event decryption', () {
    test('should return null when http code is not 200', () async {
      var event = faker.lorem.word();

      when(client.post('$endpoint/process_log2', data: event)).thenAnswer(
        (_) async => Response(data: 'Internal Server Error', statusCode: 500),
      );

      expect(
        await decryptEvent(client: client, endpoint: endpoint, event: event),
        equals(null),
      );

      verify(
        client.post(
          '$endpoint/process_log2',
          data: event,
          queryParameters: null,
          options: null,
          cancelToken: null,
          onSendProgress: null,
          onReceiveProgress: null,
        ),
      ).called(1);
    });

    test('should return the decrypted event response when http code is 200',
        () async {
      var event = faker.lorem.word();
      var jsonResponse = {
        'name': faker.lorem.word(),
        'extension': faker.lorem.word(),
        'content': faker.lorem.word()
      };

      when(client.post('$endpoint/process_log2', data: event)).thenAnswer(
        (_) async => Response(data: jsonResponse, statusCode: 200),
      );

      final result = await decryptEvent(
        client: client,
        endpoint: endpoint,
        event: event,
      );

      expect(result, isA<DecryptResponse>());
      verify(
        client.post(
          '$endpoint/process_log2',
          data: event,
          queryParameters: null,
          options: null,
          cancelToken: null,
          onSendProgress: null,
          onReceiveProgress: null,
        ),
      ).called(1);
    });
  });

  group('File decryption', () {
    Options options = Options(contentType: Headers.formUrlEncodedContentType);

    test('should return the decrypted file response when http code is 200',
        () async {
      final data = FormData.fromMap({'key': 'value'});
      final jsonResponse = {
        'name': faker.lorem.word(),
        'extension': faker.lorem.word(),
        'content': faker.lorem.word()
      };

      when(client.post('$endpoint/upload', data: data, options: options))
          .thenAnswer(
        (_) async => Response(data: jsonResponse, statusCode: 200),
      );

      final result = await decryptFile(
        client: client,
        endpoint: endpoint,
        data: data,
        options: options,
      );

      expect(result, isA<DecryptResponse>());
      verify(
        client.post(
          '$endpoint/upload',
          data: data,
          options: options,
          queryParameters: null,
          cancelToken: null,
          onSendProgress: null,
          onReceiveProgress: null,
        ),
      ).called(1);
    });

    test('should return null when http code is not 200', () async {
      final data = FormData.fromMap({'key': 'value'});

      when(client.post('$endpoint/upload', data: data, options: options))
          .thenAnswer(
        (_) async => Response(data: 'Internal Server Error', statusCode: 500),
      );

      expect(
        await decryptFile(
          client: client,
          endpoint: endpoint,
          data: data,
          options: options,
        ),
        equals(null),
      );
      verify(
        client.post(
          '$endpoint/upload',
          data: data,
          options: options,
          queryParameters: null,
          cancelToken: null,
          onSendProgress: null,
          onReceiveProgress: null,
        ),
      ).called(1);
    });
  });

  group('F10 decryption', () {
    test('should return the decrypted F10 response when http code is 200',
        () async {
      final data = {'key': 'value'};
      final fakeOutput = {'returned': 'value'};

      when(client.post('$endpoint/decrypt_f10', data: data)).thenAnswer(
        (_) async => Response(data: fakeOutput, statusCode: 200),
      );

      expect(
        await decryptF10(
          client: client,
          data: data,
          endpoint: endpoint,
        ),
        equals(fakeOutput),
      );

      verify(
        client.post(
          '$endpoint/decrypt_f10',
          data: data,
          queryParameters: null,
          options: null,
          cancelToken: null,
          onSendProgress: null,
          onReceiveProgress: null,
        ),
      ).called(1);
    });

    test('should return null when http code is not 200', () async {
      final data = {'key': 'value'};

      when(client.post('$endpoint/decrypt_f10', data: data)).thenAnswer(
        (_) async => Response(data: 'Internal Server Error', statusCode: 500),
      );

      expect(
        await decryptF10(
          client: client,
          data: data,
          endpoint: endpoint,
        ),
        equals(null),
      );

      verify(
        client.post(
          '$endpoint/decrypt_f10',
          data: data,
          queryParameters: null,
          options: null,
          cancelToken: null,
          onSendProgress: null,
          onReceiveProgress: null,
        ),
      ).called(1);
    });
  });
}
