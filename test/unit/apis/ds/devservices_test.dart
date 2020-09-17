import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/apis/ds/decrypt_response.dart';
import 'package:myapp/apis/ds/devservices.dart';

class DioMock extends Mock implements Dio {}

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
    });

    test('should return the decrypt response when http code is 200', () async {
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

      expect(result, allOf([isA<DecryptResponse>()]));
    });
  });

  group('File decryption', () {
    test('should return the decrypt response when http code is 200', () async {
      final data = FormData.fromMap({'key': 'value'});
      var jsonResponse = {
        'name': faker.lorem.word(),
        'extension': faker.lorem.word(),
        'content': faker.lorem.word()
      };

      when(client.post('$endpoint/upload', data: data)).thenAnswer(
        (_) async => Response(data: jsonResponse, statusCode: 200),
      );

      final result = await decryptFile(
        client: client,
        endpoint: endpoint,
        data: data,
      );
      expect(result, isA<DecryptResponse>());
    });

    test('should return null when http code is not 200', () async {
      final data = FormData.fromMap({'key': 'value'});

      when(client.post('$endpoint/upload', data: data)).thenAnswer(
        (_) async => Response(data: 'Internal Server Error', statusCode: 500),
      );

      expect(
        await decryptFile(
          client: client,
          endpoint: endpoint,
          data: data,
        ),
        equals(null),
      );
    });
  });
}
