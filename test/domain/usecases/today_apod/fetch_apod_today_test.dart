import 'package:astronomy_picture/core/error/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/usecases/today_apod/fetch_apod_today.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../test_values.dart';
import 'fetch_apod_today_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodayApodRepository>()])
Future<void> main() async {
  group('FetchApodTodayUseCase', () {
    late TodayApodRepository repository;
    late FetchApodToday usecase;

    setUp(() {
      repository = MockTodayApodRepository();
      usecase = FetchApodToday(
        repository: repository,
      );
    });

    test('Deve retornar uma entidade Apod no lado direito', () async {
      when(repository.fetchApodToday()).thenAnswer(
        (_) async => Right<Failure, Apod>(
          tApod(),
        ),
      );

      final result = await usecase.call(NoParameter());

      expect(
        result,
        Right<Failure, Apod>(
          tApod(),
        ),
      );
    });

    test('Deve retornar um Failure no lado esquerdo', () async {
      when(repository.fetchApodToday()).thenAnswer(
        (_) async => Left<Failure, Apod>(
          tNoConnection(),
        ),
      );

      final result = await usecase.call(NoParameter());

      expect(
        result,
        Left<Failure, Apod>(
          tNoConnection(),
        ),
      );
    });
  });
}
