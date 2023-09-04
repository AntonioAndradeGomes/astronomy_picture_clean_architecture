import 'package:astronomy_picture/core/error/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';

Apod Function() tApod = () => Apod(
      copyright: "Stefan Seip",
      date: DateTime.parse("2004-09-27"),
      explanation: "The Great Nebula in Orion is a colorful place.",
      mediaType: 'image',
      serviceVersion: 'v1',
      title: 'The Great Nebula in Orion',
      url: 'https://apod.nasa.gov/apod/image/0409/orion_seip.jpg',
      hdurl: 'https://apod.nasa.gov/apod/image/0409/orion_seip_big.jpg',
    );

Failure Function() tNoConnection = () => NoConnection();
