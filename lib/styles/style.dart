import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Primary colors
const Color primaryColor = Color(0xFFFEF3E2);
const Color secondaryColor = Color(0xFFF3C623);
const Color boxColor = Color(0xFFFFFFFF);
const Color hoverColor = Color(0xFFFFB22C);
const Color mainTextColor = Color(0xFF102E50);

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