import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ContextExtention on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;

  ThemeData get theme => Theme.of(this);
}

extension NumberExtention on BuildContext {
  double get lowHeight => dynamicHeight(0.01);
  double get mediumHeight => dynamicHeight(0.03);
  double get highHeight => dynamicHeight(0.05);

  double get lowWidth => dynamicWidth(0.01);
  double get mediumWidth => dynamicWidth(0.03);
  double get highWidth => dynamicWidth(0.05);
}

extension PaddingExtention on BuildContext {
  EdgeInsets get paddingAllLow => EdgeInsets.all(lowHeight);
  EdgeInsets get paddingAllMedium => EdgeInsets.all(mediumHeight);
  EdgeInsets get paddingAllHigh => EdgeInsets.all(mediumHeight);
}

extension ColorExtention on BuildContext {
  Color get primaryColor => Color(0xFF8875FF);
  Color get BackgroundColor => Color(0xFF121212);
}

extension MaterialColorExtention on BuildContext {
  MaterialColor get primaryMaterialColor => const MaterialColor(
        0xFF8875FF,
        <int, Color>{
          50: Color(0xFFA4A4BF),
          100: Color(0xFFA4A4BF),
          200: Color(0xFFA4A4BF),
          300: Color(0xFF9191B3),
          400: Color(0xFF7F7FA6),
          500: Color(0xFF181861),
          600: Color(0xFF6D6D99),
          700: Color(0xFF5B5B8D),
          800: Color(0xFF494980),
          900: Color(0xFF181861),
        },
      );
}

extension TextStyleExtention on BuildContext {
  TextStyle fontStyleLato(Color color, double size) =>
      GoogleFonts.lato(color: color, fontSize: size);
}
