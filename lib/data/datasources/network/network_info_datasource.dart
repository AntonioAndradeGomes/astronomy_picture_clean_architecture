import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfoDatasource {
  /*
  * if true has connection
  * else, no connection
  */
  Future<bool> get isConnected;
}

class NetworkInfoDatasourceImpl implements NetworkInfoDatasource {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoDatasourceImpl({
    required this.internetConnectionChecker,
  });

  @override
  Future<bool> get isConnected async =>
      await internetConnectionChecker.hasConnection;
}
