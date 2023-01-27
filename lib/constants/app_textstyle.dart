import 'package:flutter/material.dart';

import 'color_constants.dart';

class ApptextStyle {
  static const TextStyle MY_CARD_TITLE =
  TextStyle(color: kThirdColor, fontWeight: FontWeight.w700, fontSize: 12,fontFamily: "MUli");

  static const TextStyle MY_CARD_SUBTITLE =
  TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14,fontFamily: "MUli");

  static const TextStyle BODY_TEXT = TextStyle(
      color: kPrimaryColor, fontWeight: FontWeight.w700, fontSize: 14,fontFamily: "MUli");

  static const TextStyle LISTTILE_TITLE = TextStyle(
    color: kPrimaryColor,
    fontSize: 14,
      fontFamily: "MUli"
  );

  static const TextStyle LISTTILE_SUB_TITLE = TextStyle(
    color: Colors.grey,
    fontSize: 10,
      fontFamily: "MUli"
  );
}