import 'package:astronomy_picture/core/error/failure.dart';
import 'package:astronomy_picture/data/datasources/network/network_info_datasource.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_datasource.dart';
import 'package:astronomy_picture/data/repositories/today_apod/today_apod_repository_impl.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../test_values.dart';
import 'today_apod_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TodayApodDatasource>(),
  MockSpec<NetworkInfoDatasource>(),
])
void main() {
  group('TodayApodRepositoryImpl', () {
    late TodayApodDatasource datasource;
    late NetworkInfoDatasource networkInfoDatasource;
    late TodayApodRepository repository;

    setUp(() {
      datasource = MockTodayApodDatasource();
      networkInfoDatasource = MockNetworkInfoDatasource();
      repository = TodayApodRepositoryImpl(
        datasource: datasource,
        datasourceNetworkInfo: networkInfoDatasource,
      );
    });

    /*
    *sem conexão = falhar
    *com internet:
    *  executar TodayApodDatasource -> sucesso ou falha
    */

    group('function fetchTodayApod', () {
      test('Deve retornar uma entidade Apod no lado direito', () async {
        when(networkInfoDatasource.isConnected).thenAnswer(
          (_) async => true,
        );
        when(datasource.fetchTodayApod()).thenAnswer(
          (_) async => tApodModel(),
        );

        final result = await repository.fetchApodToday();

        expect(result, Right<Failure, Apod>(tApodModel()));
      });

      test('Deve retornar um Failure no lado esquerdo vindo do datasource',
          () async {
        when(networkInfoDatasource.isConnected).thenAnswer(
          (_) async => true,
        );
        when(datasource.fetchTodayApod()).thenThrow(
          ApiFailure(),
        );

        final result = await repository.fetchApodToday();

        expect(result, Left<Failure, Apod>(ApiFailure()));
      });

      test(
          'Deve retornar um Failure no lado esquerdo vindo do datasource de internet',
          () async {
        when(networkInfoDatasource.isConnected).thenAnswer(
          (_) async => false,
        );

        final result = await repository.fetchApodToday();

        verifyNever(datasource.fetchTodayApod());

        expect(result, Left<Failure, Apod>(NoConnection()));
      });
    });
  });
}
