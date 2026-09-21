import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_layout.dart';
import 'app_typography.dart';

export 'app_colors.dart';
export 'app_icons.dart';
export 'app_effects.dart';
export 'app_layout.dart';
export 'app_typography.dart';

/// Reads the Smasher palette off the current theme.
///
///     final c = context.palette;
///     Text('Hi', style: TextStyle(color: c.textPrimary));
extension SmasherThemeX on BuildContext {
  SmasherPalette get palette =>
      Theme.of(this).extension<SmasherPalette>() ?? SmasherPalette.light;

  Brightness get brightness => Theme.of(this).brightness;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

abstract final class SmasherTheme {
  static ThemeData light() => _build(SmasherPalette.light, Brightness.light);
  static ThemeData dark() => _build(SmasherPalette.dark, Brightness.dark);

  static ThemeData _build(SmasherPalette p, Brightness brightness) {
    final base = ThemeData(brightness: brightness, useMaterial3: true);

    return base.copyWith(
      extensions: <ThemeExtension<dynamic>>[p],
      scaffoldBackgroundColor: p.backgroundPrimary,
      canvasColor: p.backgroundPrimary,
      dividerColor: p.borderSubtle,
      splashFactory: InkRipple.splashFactory,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: p.brandPrimary,
        onPrimary: p.brandOnPrimary,
        secondary: p.brandText,
        onSecondary: p.brandOnPrimary,
        error: p.error,
        onError: p.textInverse,
        surface: p.surfaceDefault,
        onSurface: p.textPrimary,
      ),
      textTheme: base.textTheme.copyWith(
        displayLarge: SmasherText.displayLarge.copyWith(color: p.textPrimary),
        displayMedium: SmasherText.displayMedium.copyWith(color: p.textPrimary),
        headlineLarge: SmasherText.h1.copyWith(color: p.textPrimary),
        headlineMedium: SmasherText.h2.copyWith(color: p.textPrimary),
        headlineSmall: SmasherText.h3.copyWith(color: p.textPrimary),
        titleLarge: SmasherText.h4.copyWith(color: p.textPrimary),
        bodyLarge: SmasherText.bodyLarge.copyWith(color: p.textPrimary),
        bodyMedium: SmasherText.bodyDefault.copyWith(color: p.screen.bodyText),
        bodySmall: SmasherText.bodySmall.copyWith(color: p.textTertiary),
        labelLarge: SmasherText.buttonLarge.copyWith(color: p.textPrimary),
        labelSmall: SmasherText.eyebrow.copyWith(color: p.screen.sectionLabel),
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          for (final platform in const [
            TargetPlatform.android,
            TargetPlatform.iOS,
          ])
            platform: const CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: p.backgroundPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: SmasherScreen.headerHeight,
        iconTheme: IconThemeData(color: p.textPrimary, size: SmasherSize.iconMd),
      ),
    );
  }
}
