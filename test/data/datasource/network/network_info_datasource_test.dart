import 'package:astronomy_picture/data/datasources/network/network_info_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
void main() {
  group('NetworkInfoDatasource', () {
    late InternetConnectionChecker internetConnectionChecker;
    late NetworkInfoDatasource datasource;

    setUp(() {
      internetConnectionChecker = MockInternetConnectionChecker();
      datasource = NetworkInfoDatasourceImpl(
        internetConnectionChecker: internetConnectionChecker,
      );
    });

    test('Deve retornar um true quando houver conexão', () async {
      when(internetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);

      final result = await datasource.isConnected;

      expect(result, true);
    });

    test('Deve retornar um false quando não houver conexão', () async {
      when(internetConnectionChecker.hasConnection)
          .thenAnswer((_) async => false);

      final result = await datasource.isConnected;

      expect(!result, true);
    });
  });
}
