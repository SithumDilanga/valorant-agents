import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static const _primaryColor = Colors.black;
  static const _accentColor = Colors.blueGrey;

  static const _dividerTheme = DividerThemeData(
    space: 0.0,
    indent: 16.0,
  );

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: _primaryColor,
      onPrimary: _accentColor
    )
  );

  static ThemeData light() {

    final textTheme = _getTextTheme(Brightness.light);

    return ThemeData(
      primaryColor: _primaryColor,
      accentColor: _accentColor,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      dividerTheme: _dividerTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  static ThemeData dark() {

    final textTheme = _getTextTheme(Brightness.dark);

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: _primaryColor,
      accentColor: _accentColor,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      dividerTheme: _dividerTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  static TextTheme _getTextTheme(Brightness brightness) {

    final themeData = ThemeData(brightness: brightness);

    return GoogleFonts.exo2TextTheme(themeData.textTheme).copyWith(
      headline1: GoogleFonts.orbitron(),
      headline2: GoogleFonts.orbitron(),
      headline3: GoogleFonts.orbitron(),
      headline4: GoogleFonts.orbitron(),
      headline5: GoogleFonts.kanit(
        textStyle: TextStyle(fontSize: 28)
      ), //lexendMega()
      headline6: GoogleFonts.orbitron(),
      
    );
  }

}