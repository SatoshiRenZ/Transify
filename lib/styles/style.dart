import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- App Theme Constants ---

class AppColors
{
  static const Color primary = Color(0xFFFEF3E2);
  static const Color secondary = Color(0xFFF3C623);
  static const Color box = Color(0xFFFFFFFF);
  static const Color hover = Color(0xFFFFB22C);
  static const Color mainText = Color(0xFF102E50);
}

class AppTextStyles
{
  static final TextStyle title = GoogleFonts.irishGrover(
    fontSize: 40,
    color: AppColors.mainText,
  );

  static final TextStyle mainFont35 = GoogleFonts.sulphurPoint(
    fontSize: 35,
    color: AppColors.mainText,
  );

  static final TextStyle mainFont25 = GoogleFonts.sulphurPoint(
    fontSize: 25,
    color: AppColors.mainText,
  );

  static final TextStyle mainFont20 = GoogleFonts.sulphurPoint(
    fontSize: 20,
    color: AppColors.mainText,
  );

  static final TextStyle mainFont15 = GoogleFonts.sulphurPoint(
    fontSize: 15,
    color: AppColors.mainText,
  );
}

class AppIcons
{
  static const bus = Icons.directions_bus_rounded;
}