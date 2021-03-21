import 'package:dio/dio.dart';
import 'package:flutter_apod_web/model/astro.dart';
import 'package:flutter_apod_web/notifier/astro_notifier.dart';

class AstrologyApi {
  static const String BASE_URL =
      'https://api.nasa.gov/planetary/apod?api_key=aWPhODExHc5j48m59viPzCysv1jkoaN7ID2dchPw&date=';

  /* A function for Dio HTTP GET request for fetching APi changing the notifier */
  static getAstrologyApi(
      AstrologyNotifier astrologyNotifier, DateTime date) async {
    Dio dio = Dio();
    /* Handle Errors */
    onError(error) {
      Astrology astrology = new Astrology();

      astrology.title = 'Today Astrology not Available';
      astrologyNotifier.setAstrology(astrology);
    }

    var responseData;

    Response response;
    try {
      response = await dio
          .get('$BASE_URL${date.year}-${date.month}-${date.day}')
          .catchError(onError);

      if (response.statusCode == 400) {
        Astrology astrology = Astrology.fromMap(response.data);
        print('message:${response.statusMessage}');
        astrology.title = response.statusMessage;
        astrologyNotifier.setAstrology(astrology);
      } else {
        responseData = (response.data);

        Astrology astrology = Astrology.fromMap(responseData);

        astrologyNotifier.setAstrology(astrology);
      }
    } catch (e) {
      print(e);
    }
  }
}
