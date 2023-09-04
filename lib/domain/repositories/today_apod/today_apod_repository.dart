import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/apod.dart';

abstract class TodayApodRepository {
  Future<Either<Failure, Apod>> fetchApodToday();
}
