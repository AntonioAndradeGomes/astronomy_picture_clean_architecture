import 'dart:convert';

import 'package:astronomy_picture/core/constants/env.dart';
import 'package:astronomy_picture/core/error/failure.dart';
import 'package:http/http.dart' as http;
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_datasource.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';

class TodayApodDatasourceImpl implements TodayApodDatasource {
  final http.Client client;

  TodayApodDatasourceImpl({
    required this.client,
  });

  @override
  Future<ApodModel> fetchTodayApod() async {
    http.Response response;
    try {
      response = await client.get(Uri.parse(Env.urlBase));
    } catch (e) {
      throw ApiFailure();
    }
    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      return ApodModel.fromJson(json);
    } else {
      throw ApiFailure();
    }
  }
}
