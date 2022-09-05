import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/utils/colors.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: primaryColor,
          onPrimary: Colors.white,
        ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.mulishTextTheme(),
    scaffoldBackgroundColor: Colors.white);
