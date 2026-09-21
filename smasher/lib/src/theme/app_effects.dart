import 'package:flutter/material.dart';

/// The 5 effect styles and 4 gradient paint styles published in Figma.
///
/// Elevation is theme-specific: the light shadows are far softer than the dark
/// ones, so always pick via [SmasherShadow.low] / [SmasherShadow.medium] with
/// the current [Brightness] rather than hardcoding one set.
abstract final class SmasherShadow {
  /// Elevation/Light/Low — y4, blur 12, 5%
  static const List<BoxShadow> lightLow = [
    BoxShadow(
      color: Color(0x0D000000), // 5%
      offset: Offset(0, 4),
      blurRadius: 12,
    ),
  ];

  /// Elevation/Light/Medium — y16, blur 40, 10%
  static const List<BoxShadow> lightMedium = [
    BoxShadow(
      color: Color(0x1A000000), // 10%
      offset: Offset(0, 16),
      blurRadius: 40,
    ),
  ];

  /// Elevation/Dark/Low — y8, blur 24, 35%
  static const List<BoxShadow> darkLow = [
    BoxShadow(
      color: Color(0x59000000), // 35%
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];

  /// Elevation/Dark/Medium — y20, blur 48, 45%
  static const List<BoxShadow> darkMedium = [
    BoxShadow(
      color: Color(0x73000000), // 45%
      offset: Offset(0, 20),
      blurRadius: 48,
    ),
  ];

  /// Elevation/Brand Glow — y6, blur 16, brand violet at 28%.
  /// Sits under primary buttons and selected states.
  static const List<BoxShadow> brandGlow = [
    BoxShadow(
      color: Color(0x477C3AED), // #7C3AED @ 28%
      offset: Offset(0, 6),
      blurRadius: 16,
    ),
  ];

  static List<BoxShadow> low(Brightness b) =>
      b == Brightness.dark ? darkLow : lightLow;

  static List<BoxShadow> medium(Brightness b) =>
      b == Brightness.dark ? darkMedium : lightMedium;
}

abstract final class SmasherGradient {
  /// Gradient/Brand — the hero card wash.
  static const LinearGradient brand = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
  );

  /// The hero card on module homes. Three stops, measured off
  /// `Hero / Daily Question`: #8B5CF6 → #7C3AED → #4C1D95.
  static const LinearGradient hero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED), Color(0xFF4C1D95)],
  );

  /// Soft violet wash used as a card FILL — the Idea Deck card and the
  /// 42px icon tiles inside the Matches / Proposals tiles.
  /// #F4EFFE → #E8DEFC.
  static const LinearGradient softTint = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF4EFFE), Color(0xFFE8DEFC)],
  );

  /// Deep violet tile used for leading icons that carry a white glyph —
  /// the Idea Deck tile and every Profile settings row. #8B5CF6 → #5B21B6.
  static const LinearGradient deepTile = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFF5B21B6)],
  );

  /// The full-bleed background of the task screens (Circle Entry and the rest
  /// of the P02 flow). The artboard's root fill is a vertical three-stop
  /// gradient — #EDE6FD → #F6F6F9 → #F6F6F9 — so the violet only tints the
  /// top third and the body sits on flat grey.
  static const LinearGradient screenWash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.42, 1.0],
    colors: [Color(0xFFEDE6FD), Color(0xFFF6F6F9), Color(0xFFF6F6F9)],
  );

  /// Gradient/Brand Deep — premium and celebratory surfaces.
  static const LinearGradient brandDeep = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6D28D9), Color(0xFF2E1065)],
  );

  /// Gradient/Surface Dark — dark module headers.
  static const LinearGradient surfaceDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF27272F), Color(0xFF18181F)],
  );

  /// Gradient/Glass — translucent overlay on imagery.
  static const LinearGradient glass = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00FFFFFF), Color(0x1FFFFFFF)],
  );
}
