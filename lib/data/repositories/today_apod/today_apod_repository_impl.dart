import 'package:astronomy_picture/core/error/failure.dart';
import 'package:astronomy_picture/data/datasources/network/network_info_datasource.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_datasource.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:dartz/dartz.dart';

class TodayApodRepositoryImpl implements TodayApodRepository {
  final TodayApodDatasource datasource;
  final NetworkInfoDatasource datasourceNetworkInfo;

  TodayApodRepositoryImpl({
    required this.datasource,
    required this.datasourceNetworkInfo,
  });

  @override
  Future<Either<Failure, Apod>> fetchApodToday() async {
    final isConnected = await datasourceNetworkInfo.isConnected;
    if (isConnected) {
      try {
        final model = await datasource.fetchTodayApod();
        return Right(model);
      } on Failure catch (failure) {
        return Left(failure);
      }
    }
    return Left(NoConnection());
  }
}
