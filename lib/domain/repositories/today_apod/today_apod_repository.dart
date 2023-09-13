import 'package:astronomy_picture/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../entities/apod.dart';

abstract class TodayApodRepository {
  Future<Either<Failure, Apod>> fetchApodToday();
}
