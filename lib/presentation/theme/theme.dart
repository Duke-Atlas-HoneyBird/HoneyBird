import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'border_radius.dart';

ThemeData buildBlackAndWhiteTheme() {
  const Color kBlack = Colors.black;
  const Color kWhite = Colors.white;

  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: kWhite,
    dividerColor: Colors.black12,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kBlack,
      brightness: Brightness.light,
      primary: kBlack,
    ).copyWith(
      background: kWhite,
      onBackground: kBlack,
      surface: kWhite,
      onSurface: kBlack,
      primary: kBlack,
      onPrimary: kWhite,
      secondary: kBlack,
      onSecondary: kWhite,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: kWhite,
        foregroundColor: kBlack,
      ),
    ),
    textTheme: GoogleFonts.ibmPlexSansTextTheme(
      TextTheme(
        displayLarge: GoogleFonts.ibmPlexSans(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: kBlack,
        ),
        headlineSmall: GoogleFonts.ibmPlexSans(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: kBlack,
        ),
        titleMedium: const TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w500, color: kBlack),
        bodyMedium: GoogleFonts.ibmPlexSans(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: kBlack,
        ),
        labelSmall: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: kBlack,
        ),
      ),
    ),
    cardColor: kWhite,
    cardTheme: CardThemeData(
      color: kWhite,
      shadowColor: Colors.black.withValues(alpha: 0.2),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
    ),
    appBarTheme: AppBarTheme(
      shadowColor: kBlack,
      backgroundColor: kWhite,
      foregroundColor: kBlack,
      surfaceTintColor: kBlack,
      titleTextStyle: GoogleFonts.ibmPlexSans(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: kBlack,
      ),
      toolbarTextStyle: GoogleFonts.ibmPlexSans(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: kBlack,
      ),
      iconTheme: const IconThemeData(
        color: kBlack,
      ),
      elevation: 0,
      
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kBlack,
        foregroundColor: kWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
      ),
    ),
    
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: kBlack,
      selectionColor: Colors.black12,
      selectionHandleColor: kBlack,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.ibmPlexSans(
          fontSize: 12, fontWeight: FontWeight.w500, color: kBlack),
      helperStyle: GoogleFonts.ibmPlexSans(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black45),
      prefixStyle: GoogleFonts.ibmPlexSans(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black45),
      suffixStyle: GoogleFonts.ibmPlexSans(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black45),
      errorStyle: GoogleFonts.ibmPlexSans(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black45),
      floatingLabelStyle: GoogleFonts.ibmPlexSans(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black45),
      filled: true,
      fillColor: Colors.grey[200],
      iconColor: kBlack,
      focusColor: kBlack,
      hoverColor: kBlack,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
    iconTheme: const IconThemeData(color: kBlack),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kBlack,
      foregroundColor: kWhite,
    ),
  );
}

extension MorrenaThemeExtension on ThemeData {
  /// Returns a ThemeData where core visual properties are overridden to a
  /// strict black-and-white (monochrome) palette while preserving other
  /// ThemeData values where appropriate.
  ThemeData morrenaOverride() {
    const Color kBlack = Colors.black;
    const Color kWhite = Colors.white;

    final TextTheme monoText = GoogleFonts.ibmPlexSansTextTheme(
      this.textTheme,
    ).apply(bodyColor: kBlack, displayColor: kBlack);
    return copyWith(
      brightness: Brightness.light,
      primaryColor: kBlack,
      scaffoldBackgroundColor: kWhite,
      canvasColor: kWhite,
      cardColor: kWhite,
      dividerColor: Colors.black12,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kBlack,
        brightness: Brightness.light,
        primary: kBlack,
      ).copyWith(
        background: kWhite,
        onBackground: kBlack,
        surface: kWhite,
        onSurface: kBlack,
        primary: kBlack,
        onPrimary: kWhite,
        secondary: kBlack,
        onSecondary: kWhite,
      ),
      textTheme: monoText,
      primaryTextTheme: monoText,
      iconTheme: const IconThemeData(color: kBlack),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: kBlack,
          foregroundColor: kWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadius),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: kBlack,
        foregroundColor: kWhite ,
        titleTextStyle: GoogleFonts.ibmPlexSans(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: kWhite,
        ),
        iconTheme: const IconThemeData(color: kBlack),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kBlack,
          foregroundColor: kWhite,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonBorderRadius)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(backgroundColor: kWhite, foregroundColor: kBlack),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: kBlack,
          side: const BorderSide(color: Colors.black12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadius),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: kBlack,
        foregroundColor: kWhite,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: GoogleFonts.ibmPlexSans(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
        helperStyle: GoogleFonts.ibmPlexSans(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54),
        prefixStyle: GoogleFonts.ibmPlexSans(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54),
        suffixStyle: GoogleFonts.ibmPlexSans(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54),
        errorStyle: GoogleFonts.ibmPlexSans(fontSize: 12, fontWeight: FontWeight.w500, color: kBlack),
        floatingLabelStyle: GoogleFonts.ibmPlexSans(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
        filled: true,
        fillColor: kWhite,
        iconColor: kBlack,
        focusColor: kBlack,
        hoverColor: kBlack,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Colors.black12)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Colors.black12)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: kBlack)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: kBlack)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: kBlack)),
      ),
      // bottomAppBarColor: kWhite,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: kWhite,
        selectedItemColor: kBlack,
        unselectedItemColor: Colors.black54,
      ),
      snackBarTheme: const SnackBarThemeData(backgroundColor: kBlack, contentTextStyle: TextStyle(color: kWhite)),
      dialogTheme: DialogThemeData(
        backgroundColor: kWhite,
        titleTextStyle: GoogleFonts.ibmPlexSans(fontSize: 16, fontWeight: FontWeight.w600, color: kBlack),
        contentTextStyle: GoogleFonts.ibmPlexSans(fontSize: 14, color: kBlack),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: Colors.black12,
        disabledColor: Colors.black12,
        selectedColor: kBlack,
        secondarySelectedColor: kBlack,
        labelStyle: TextStyle(color: kBlack),
        secondaryLabelStyle: TextStyle(color: kWhite),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        brightness: Brightness.light,
      ),
      // toggleableActiveColor: kBlack,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: kBlack, selectionColor: Colors.black12, selectionHandleColor: kBlack),
      // keep the existing icon/theme config but force monochrome colors
      // iconTheme: const IconThemeData(color: kBlack),
    );
  }
}
