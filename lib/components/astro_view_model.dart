import 'package:flutter_apod_web/model/astro.dart';

/* The View Model Class*/
class AstrologyViewModel {
  Astrology _astrology;

  setAstrology(Astrology astrology) {
    _astrology = astrology;
  }

  Astrology get astrology => _astrology;
}
