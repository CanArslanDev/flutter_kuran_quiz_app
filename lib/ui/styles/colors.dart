import 'package:flutter/material.dart';
import 'package:flutterquiz/utils/constants/constants.dart';
import 'package:hive/hive.dart';

String selectedTheme = '';

void themeInitialize() {
  if (Hive.box(colorBox).get('color') == null) {
     primaryColor = Colors.green;
    return;
  }
  String selectedTheme = Hive.box(colorBox).get('color');
  if (selectedTheme == 'red') {
     primaryColor = Colors.red;
  } else if (selectedTheme == 'pink') {
     primaryColor = Colors.pink;
  } else if (selectedTheme == 'green') {
     primaryColor = Colors.green;
  } else if (selectedTheme == 'purple') {
     primaryColor = Colors.purple;
  } else if (selectedTheme == 'yellow') {
     primaryColor = Colors.yellow;
  } else if (selectedTheme == 'blue') {
     primaryColor = Colors.blue;
  } else if (selectedTheme == 'orange') {
     primaryColor = Colors.orange;
  } else {
     primaryColor = Colors.green;
  }
  // if (selectedTheme == 'first') {
  //   pageBackgroundColor = Colors.grey.shade900;
  //   backgroundColor = const Color(0xff333333); // Koyu Gri / Siyaha Yakın
  //   levelLockedColor = const Color(0xff222222); // Daha Koyu Gri / Siyaha Yakın
  //   onPrimaryColor = const Color(0xff444444); // Gri / Siyaha Yakın
  //   onSecondaryColor = const Color(0xff333333); // Koyu Gri / Siyaha Yakın
  //   darkCanvasColor = const Color(0xff222222); // Daha Koyu Gri / Siyaha Yakın
  //   darkPrimaryTxtColor = const Color(0xFFF5F5F5);
  //   onBackgroundColor = const Color(0xFFE9EAEC);
  //   primaryTxtColor = const Color(0xFFF5F5F5);
  //   kBoxShadowColor = const Color(0xE6FFFFFF);
  //   darkBackgroundColor = const Color(0xFF3473C0);
  //   darkPageBackgroundColor = const Color(0xFF4073DA);
  //   darkOnPrimaryColor = const Color(0xFF3473C0);
  //   darkOnSecondaryColor = const Color(0xFF4073DA);
  // } else {
  //   pageBackgroundColor = Colors.white;
  //   backgroundColor = const Color(0xfffefefe);
  //   levelLockedColor = const Color(0xffe8e8e8);
  //   onPrimaryColor = const Color(0xffFBF4F8); //
  //   onSecondaryColor = const Color(0xffEFD8E7);
  //   darkCanvasColor = const Color(0xccffffff);
  //   darkPrimaryTxtColor = const Color(0xffffffff);
  //   onBackgroundColor = const Color(0xff24272D);
  //   primaryTxtColor = const Color(0xff45536d);
  //   kBoxShadowColor = const Color(0x40000000);
  //   darkBackgroundColor = const Color(0xff294261);
  //   darkPageBackgroundColor = const Color(0xff233354);
  //   darkOnPrimaryColor = const Color(0xff233354);
  //   darkOnSecondaryColor = const Color(0xff294261);
  // }
}

//old 0xffA93A6F
Color primaryColor = const Color(0xFF50B672);
Color secondaryColor = const Color(0xffED5588);
Color backgroundColor = const Color(0xfffefefe);
Color pageBackgroundColor = const Color(0xffF3F7FA);
Color onBackgroundColor = const Color(0xff24272D);
Color primaryTxtColor = const Color(0xff45536d);
Color kBoxShadowColor = const Color(0x40000000);
Color levelLockedColor = const Color(0xffe8e8e8);

//This will be colors of side half circle in home screen
Color onPrimaryColor = const Color(0xffFBF4F8); //
Color onSecondaryColor = const Color(0xffEFD8E7);

Color darkPrimaryColor = const Color(0xffA93A6F);
Color darkSecondaryColor = const Color(0xffff9abc);
Color darkBackgroundColor = const Color(0xff294261);
Color darkPageBackgroundColor = const Color(0xff233354);
Color darkCanvasColor = const Color(0xccffffff);
Color darkPrimaryTxtColor = const Color(0xffffffff);
//This will be colors of side half circle in home screen
Color darkOnPrimaryColor = const Color(0xff233354);
Color darkOnSecondaryColor = const Color(0xff294261);
Color darkLevelLockedColor = const Color(0xffa8a8a8);

//it will be same for both light and dark theme
Color badgeLockedColor = Colors.grey;
Color addCoinColor = Colors.green;
Color hurryUpTimerColor = Colors.red; //timer color when 25% time left
