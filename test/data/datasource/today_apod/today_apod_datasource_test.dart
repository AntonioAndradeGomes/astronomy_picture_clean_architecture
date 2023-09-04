import 'dart:convert';
import 'dart:io';

import 'package:astronomy_picture/core/error/failure.dart';
import 'package:astronomy_picture/data/datasources/today_apod/remote/today_apod_datasource_impl.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixtures.dart';
import '../../../mocks/mocks.mocks.dart';
import '../../../test_values.dart';

void main() {
  group('TodayApodDatasourceImpl', () {
    late MockClient client;
    late TodayApodDatasource datasource;

    setUp(() {
      client = MockClient();
      datasource = TodayApodDatasourceImpl(
        client: client,
      );
    });
    test('Deve retornar um Apod model', () async {
      when(client.get(any)).thenAnswer(
        (_) async => http.Response.bytes(
          utf8.encode(
            fixtures("image_response.json"),
          ),
          200,
        ),
      );

      final response = await datasource.fetchTodayApod();
      expect(response, tApodModel());
    });

    test(
        'Deve jogar (throw) uma ApiFailure quando a api retornar um status code diferente de 200',
        () {
      when(client.get(any)).thenAnswer(
        (_) async => http.Response.bytes(
          utf8.encode(
            fixtures("image_response.json"),
          ),
          500,
        ),
      );

      expect(() => datasource.fetchTodayApod(), throwsA(isA<ApiFailure>()));
    });

    test('Deve jogar (throw) uma ApiFailure quando disparar uma exception', () {
      when(client.get(any)).thenThrow(const SocketException('message'));
      expect(() => datasource.fetchTodayApod(), throwsA(isA<ApiFailure>()));
    });
  });
}
