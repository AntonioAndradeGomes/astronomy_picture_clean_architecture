import 'package:astronomy_picture/core/error/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchApodToday extends Usecase<Apod, NoParameter> {
  final TodayApodRepository repository;

  FetchApodToday({
    required this.repository,
  });

  @override
  Future<Either<Failure, Apod>> call(NoParameter parameter) async {
    return await repository.fetchApodToday();
  }
}
