import 'package:console/console.dart';

enum AppTheme {
  arcticPetrol(
    Theme(
      background: Color.deepPetrol,
      foreground: Color.iceWhite,
      boldAccent: Color.cyanTeal,
      subtleAccent: Color.softMint,
      error: Color.mellowYellow,
    ),
  ),
  electricSolarized(
    Theme(
      background: Color.solarizedBase,
      foreground: Color.mutedGreyTeal,
      boldAccent: Color.electricNeon,
      subtleAccent: Color.officeTeal,
      error: Color.softPinkRed,
    ),
  ),
  nordicFrost(
    Theme(
      background: Color.nordDeepGrey,
      foreground: Color.seafoam,
      boldAccent: Color.frostTeal,
      subtleAccent: Color.blueTeal,
      error: Color.softPinkRed,
    ),
  ),
  wikipediaClassic(
    Theme(
      background: Color.deepBlack,
      foreground: Color.dimWhite,
      boldAccent: Color.white,
      subtleAccent: Color.blue,
      error: Color.red,
    ),
  );

  final Theme theme;
  const AppTheme(this.theme);
}
