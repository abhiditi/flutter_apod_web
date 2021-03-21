import 'package:flutter/material.dart';
import 'package:flutter_apod_web/model/astro.dart';

/* Notifier to notify changes in the UI */
class AstrologyNotifier with ChangeNotifier {
  Astrology _astrology;

  /* set Astrology */
  setAstrology(Astrology astrology) {
    _astrology = astrology;
    notifyListeners();
  }

  /* get Astrology */
  Astrology getAstrology() {
    return _astrology;
  }
}
