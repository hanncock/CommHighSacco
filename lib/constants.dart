import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

//Spacing
const kSpacingUnit = 10.0;

// Colors
//const kTextColor = Color(0xFF151C2A);
const kTextSecondaryColor = Color(0xFF7E8EAA);
//const kPrimaryColor = Color(0xFF5D92EB);
const kGreenColor = Color(0xFF30C96B);
const kRedColor = Color(0xFFEE6B8D);
const kPurpleColor = Color(0xFFC482F9);
const kBackgroundColor = Color(0xFFFBF8FF);
const kLineColor = Color(0xFFEAEEF4);
const kShadowColor1 = Color.fromRGBO(149, 190, 207, 0.50);
const kShadowColor2 = Color(0xFFCFECF8);
const kShadowColor3 = Color.fromRGBO(0, 0, 0, 0.10);
const kShadowColor4 = Color.fromRGBO(207, 236, 248, 0.50);
const kShadowColor5 = Color.fromRGBO(238, 226, 255, 0.70);

// My Text Styles

final kHeadingTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(24),
  color: kTextColor,
  fontWeight: FontWeight.w600,
);

final kSubheaderTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(20),
  color: kTextColor,
  fontWeight: FontWeight.w600,
);

final kTitleTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(16),
  color: kTextColor,
);

final kBodyTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(13),
  color: kTextSecondaryColor,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(10),
  color: kTextSecondaryColor,
);

final kNumberTitleTextStyle = TextStyle(
  fontFamily: 'TTNorms',
  fontSize: ScreenUtil().setSp(22),
  fontWeight: FontWeight.w500,
  color: kTextColor,
);

final kCardTextStyle = TextStyle(
  fontFamily: 'Muli',
  color: Colors.white,
  shadows: [
    BoxShadow(
      color: kShadowColor3,
      blurRadius: kSpacingUnit.w,
      offset: Offset(0, kSpacingUnit.w * 0.5),
    ),
  ],
);
final f = new DateFormat('yyyy-MM-dd');
const kPrimaryColor = Color(0xFFF44336);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kErrorColor = Color(0xFFE53935);
const kAnimationDuration = Duration(milliseconds: 200);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final urlPattern = RegExp(
    r"^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)",
    caseSensitive: false);
const String kEmailNullError = "Please Enter your username";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String phoneNullError = "Please enter the phone number";
const String phoneTooShort = "Phone number too short";
const String otpConfirmNullError = "Please enter the 4 digit code";
const String phoneNumberToolongError = "Phone number too long";
