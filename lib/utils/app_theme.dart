import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
export './app_theme.dart';

class InsuremartTheme {
  static const white1 = Color(0xffFFFFFF);
  static const white2 = Color(0xfffafafa);
  static const white3 = Color(0xffcccccc);
  static const white4 = Color(0xfff3f3f3);
  static const green1 = Color(0xff1C89A7);
  static const green2 = Color(0xff03A688);
  static const green3 = Color(0xffB3E4DB);
  static const green4 = Color(0xff038C7F);
  static const black1 = Color(0xff222222);
  static const black2 = Color(0xffcccccc);
  static const black3 = Color(0xff808080);
  static const black4 = Color(0xff000000);
  static const blue1 = Color(0xff2269B3);
  static const blue2 = Color(0xff213267);
  static const blue3 = Color(0xff023859);
  static const blue4 = Color(0xff03588C);
  static const red1 = Color(0xffDB4437);
  static const red2 = Color(0xffE03347);
  static const red3 = Color(0xffff0000);
  static const pink1 = Color(0xffFDEFE7);
  static const pink2 = Color(0xffEA5B0C);

  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.raleway(
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: black1,
    ),
    headline2: GoogleFonts.raleway(
      fontWeight: FontWeight.w700,
      fontSize: 20,
      color: black1,
    ),
    headline3: GoogleFonts.raleway(
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: blue2,
    ),
    headline5: GoogleFonts.raleway(
      fontWeight: FontWeight.w600,
      fontSize: 10,
      color: black3,
    ),
    bodyText1: GoogleFonts.raleway(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: black1,
    ),
    bodyText2: GoogleFonts.raleway(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: black1,
    ),
    subtitle1: GoogleFonts.raleway(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: black4,
    ),
    button: GoogleFonts.raleway(
      fontWeight: FontWeight.w800,
      fontSize: 14,
      color: white1,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      // useMaterial3: true,
      // scaffoldBackgroundColor: const Color(0xffE5E5E5),
      brightness: Brightness.light,
      backgroundColor: white1,
      scaffoldBackgroundColor: white1,
      primaryColor: black1,
      colorScheme: ThemeData().colorScheme.copyWith(secondary: green1),
      appBarTheme: AppBarTheme(
        foregroundColor: black1,
        backgroundColor: white1,
        elevation: 0,
        toolbarTextStyle: lightTextTheme.headline1,
      ),
      dividerColor: black1,
      iconTheme: const IconThemeData(color: blue3),
      textTheme: lightTextTheme,
    );
  }
}
