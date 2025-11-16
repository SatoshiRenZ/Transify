import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
  // Primary colors
  static const Color primaryOrange = Color(0xFFFF8C00);
  static const Color appBarYellow = Color(0xFFF7C300);
  static const Color backgroundYellow = Color(0xFFFAEBD7);
  
  static const Color mainTextColor = Colors.black; 


  TextStyle appBarTitle = GoogleFonts.irishGrover(
    fontSize: 40.0,
    fontWeight: FontWeight.normal,
    color: mainTextColor, 
  );

  // Main font: "Sulphur Point", 35px
  TextStyle mainFontLarge = GoogleFonts.sulphurPoint(
    fontSize: 35.0,
    color: mainTextColor, 
    fontWeight: FontWeight.bold,
  );

// Main font: "Sulphur Point", 20px
TextStyle mainFontMedium = GoogleFonts.sulphurPoint(
  fontSize: 20.0,
  color: mainTextColor,
  fontWeight: FontWeight.normal,
);

// Main font: "Sulphur Point", 15px
TextStyle mainFontSmall = GoogleFonts.sulphurPoint(
  fontSize: 15.0,
  color: mainTextColor,
  fontWeight: FontWeight.normal,
);

}