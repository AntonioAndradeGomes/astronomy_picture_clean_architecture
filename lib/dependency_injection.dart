import 'package:astronomy_picture/data/datasources/network/network_info_datasource.dart';
import 'package:astronomy_picture/data/datasources/today_apod/remote/today_apod_datasource_impl.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_datasource.dart';
import 'package:astronomy_picture/data/repositories/today_apod/today_apod_repository_impl.dart';
import 'package:astronomy_picture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/today_apod/fetch_apod_today.dart';
import 'package:astronomy_picture/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getIt = GetIt.instance;

Future<void> setupDependency() async {
  getIt.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );

  getIt.registerLazySingleton<NetworkInfoDatasource>(
    () => NetworkInfoDatasourceImpl(
      internetConnectionChecker: getIt(),
    ),
  );

  //features
  apodToday();
}

void apodToday() {
  getIt.registerLazySingleton<TodayApodDatasource>(
    () => TodayApodDatasourceImpl(
      client: getIt(),
    ),
  );
  getIt.registerLazySingleton<TodayApodRepository>(
    () => TodayApodRepositoryImpl(
      datasource: getIt(),
      datasourceNetworkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<FetchApodToday>(
    () => FetchApodToday(
      repository: getIt(),
    ),
  );

  getIt.registerFactory(
    () => TodayApodBloc(
      fetchApodTodayUsecase: getIt(),
    ),
  );
}
