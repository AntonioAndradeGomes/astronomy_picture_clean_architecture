import 'dart:async';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/usecases/today_apod/fetch_apod_today.dart';
import 'package:equatable/equatable.dart';
part 'today_apod_event.dart';
part 'today_apod_state.dart';

class TodayApodBloc {
  FetchApodToday fetchApodTodayUsecase;

  TodayApodBloc({
    required this.fetchApodTodayUsecase,
  }) {
    _inputController.stream.listen(_blocEventController);
  }

  final StreamController<TodayApodEvent> _inputController = StreamController();
  final StreamController<TodayApodState> _outputController = StreamController();

  Sink<TodayApodEvent> get input => _inputController.sink;
  Stream<TodayApodState> get stream => _outputController.stream;

  void _blocEventController(TodayApodEvent event) {
    _outputController.add(LoadingTodayApodState());
    if (event is FetchApodTodayEvent) {
      fetchApodTodayUsecase.call(NoParameter()).then(
            (value) => value.fold(
              (l) => _outputController.add(
                ErrorTodayApodState(
                  msg: l.message,
                ),
              ),
              (r) => _outputController.add(
                SuccessTodayApodState(
                  apod: r,
                ),
              ),
            ),
          );
    }
  }
}
