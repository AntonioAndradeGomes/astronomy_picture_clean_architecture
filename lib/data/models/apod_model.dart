import 'package:astronomy_picture/domain/entities/apod.dart';

class ApodModel extends Apod {
  const ApodModel({
    super.copyright,
    super.date,
    super.explanation,
    super.mediaType,
    super.serviceVersion,
    super.title,
    super.url,
    super.hdurl,
    super.thumbnailUrl,
  });

  factory ApodModel.fromJson(Map<String, dynamic> json) => ApodModel(
        copyright: json['copyright'] ?? "Nasa APOD",
        date: json['date'] ?? DateTime.parse(json['date']),
        explanation: json['explanation'],
        hdurl: json['hdurl'],
        mediaType: json['media_type'],
        serviceVersion: json['service_version'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnail_url'],
      );

  Map toJson() => {
        'copyright': copyright,
        'date': date.toString(),
        'explanation': explanation,
        'hdurl': hdurl,
        'media_type': mediaType,
        'service_version': serviceVersion,
        'title': title,
        'url': url,
        'thumbnail_url': thumbnailUrl,
      };
}
