import 'package:astronomy_picture/domain/usecases/today_apod/fetch_apod_today.dart';
import 'package:astronomy_picture/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_values.dart';
import 'today_apod_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchApodToday>()])
void main() {
  late MockFetchApodToday fetchApodTodayUsecase;
  late TodayApodBloc bloc;

  setUp(() {
    fetchApodTodayUsecase = MockFetchApodToday();
    bloc = TodayApodBloc(
      fetchApodTodayUsecase: fetchApodTodayUsecase,
    );
  });

  group('TodayApodBloc', () {
    test('Deve emitir o estado de loading e em seguida o de sucesso', () async {
      when(fetchApodTodayUsecase(any)).thenAnswer((_) async => Right(tApod()));
      bloc.input.add(FetchApodTodayEvent());
      expect(
        bloc.stream,
        emitsInOrder(
          [
            LoadingTodayApodState(),
            SuccessTodayApodState(
              apod: tApod(),
            ),
          ],
        ),
      );
    });

    test('Deve emitir o estado de loading e em seguida o estado de erro',
        () async {
      when(fetchApodTodayUsecase(any))
          .thenAnswer((_) async => Left(tNoConnection()));
      bloc.input.add(FetchApodTodayEvent());
      expect(
        bloc.stream,
        emitsInOrder(
          [
            LoadingTodayApodState(),
            ErrorTodayApodState(
              msg: tNoConnection().message,
            ),
          ],
        ),
      );
    });
  });
}
