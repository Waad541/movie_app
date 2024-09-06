import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme{
  static ThemeData theme=ThemeData(
    scaffoldBackgroundColor: Color(0xff1A1A1A),
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
         titleTextStyle: TextStyle(
           color: Colors.white,
           fontSize: 24,
           fontWeight: FontWeight.w400
         )
      ),
      textTheme: TextTheme(

          bodyLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w300,
            color: Color(0xffB5B4B4),
          fontFamily: GoogleFonts.inter().fontFamily,
        )
      )

  );
}