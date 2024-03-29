import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static final light = FlexThemeData.light(
    scheme: FlexScheme.material,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
    appBarStyle: FlexAppBarStyle.primary,
    appBarOpacity: 0.25,
    appBarElevation: 0,
    transparentStatusBar: true,
    tabBarStyle: FlexTabBarStyle.forBackground,
    tooltipsMatchBackground: false,
    swapColors: true,
    lightIsWhite: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: GoogleFonts.inter().fontFamily,
    subThemesData: const FlexSubThemesData(
      useTextTheme: true,
      fabUseShape: true,
      interactionEffects: true,
      bottomNavigationBarElevation: 0,
      bottomNavigationBarOpacity: 0,
      navigationBarOpacity: 0,
      navigationBarMutedUnselectedIcon: true,
      inputDecoratorIsFilled: false,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorUnfocusedHasBorder: false,
      blendOnColors: true,
      blendTextTheme: true,
      popupMenuOpacity: 0.25,
    ),
  );
}

class AppThemeDark {
  static Color appBarBackgroungColor = Colors.white;
  static Color primaryBackgroundColor = Colors.white;
  static Color dividerComent = Colors.grey.shade200;
  static Color iconMensagem = Colors.white54;
  static Color appBarTextColor = Colors.black;
  static Color primaryTextColor = Colors.black;
  static Color backgroundMensagemColor = Colors.white;
  static Color secondaryMessageTextColor = Colors.black54;
  static Color textButton = const Color.fromARGB(255, 10, 58, 131);
}
