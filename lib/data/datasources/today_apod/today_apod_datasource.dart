import 'package:astronomy_picture/data/models/apod_model.dart';

abstract class TodayApodDatasource {
  Future<ApodModel> fetchTodayApod();
}
