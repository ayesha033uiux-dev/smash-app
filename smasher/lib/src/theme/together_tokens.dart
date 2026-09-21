import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// P03 Together module — the values its 20 artboards use.
///
/// The module was drawn in a flatter dialect than P02: solid #7C3AED buttons
/// with no glow, a DM Sans nav title beside the back arrow, and text boxes on
/// Figma's AUTO line height. Those values live here so the screens stay free
/// of literals, and so the module can be re-skinned in one place.
///
/// P03 has no dark artboards, so these are light-only constants rather than
/// palette tokens.
abstract final class TogetherInk {
  static const page = Color(0xFFF6F6F9);
  static const pageAlt = Color(0xFFF9F9FB); // New Time Sent, Together states
  static const surface = Color(0xFFFFFFFF);

  static const ink = Color(0xFF18181F);
  static const body = Color(0xFF5C5C6B);
  static const meta = Color(0xFF6B6B78);
  static const counter = Color(0xFF8A8A96);
  static const placeholder = Color(0xFF9999A8);

  static const brand = Color(0xFF7C3AED);
  static const selectTint = Color(0xFFF6EFFE);
  static const lilacTile = Color(0xFFEDE6FD);
  static const cardBorder = Color(0xFFF0ECFC);
  static const radioRing = Color(0xFFD4D0E0);

  static const secondaryFill = Color(0xFFF1F1F5);
  static const secondaryBorder = Color(0xFFD2D2DB);

  static const success = Color(0xFF1F9154);
  static const successTint = Color(0xFFE0F6E5);

  static const waitTint = Color(0xFFFEEFE0);
  static const waitDot = Color(0xFFD98C26);
  static const waitInk = Color(0xFF99660D);

  static const errorTint = Color(0xFFFCE8E8);
  static const errorGlyph = Color(0xFFC0433D);
  static const danger = Color(0xFFC4433D);
  static const dangerText = Color(0xFFB23D3D);

  static const skeleton = Color(0xFFE5E3ED);
  static const skeletonCard = Color(0xFFECE9F1);
  static const skeletonHome = Color(0xFFE8E5F0);

  static const scrim = Color(0x73171221); // #171221 @ 45%
  static const sheetHandle = Color(0xFFD9D4E5);

  static const offline = Color(0xFF18181F);
  static const offlineSub = Color(0xFFD9D9E0);
}

abstract final class TogetherGradient {
  /// P04 page wash — #EDE6FD at the top, #F6F6F9 from 30% down.
  static const wash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFEDE6FD), Color(0xFFF6F6F9), Color(0xFFF6F6F9)],
    stops: [0, 0.3, 1],
  );

  /// Idea Card — #8B5CF6 → #7C3AED (55%) → #4C1D95, top-left to bottom-right.
  static const ideaCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED), Color(0xFF4C1D95)],
    stops: [0, 0.55, 1],
  );

  /// Matched Answer card and the Proposal Sent tile — #8B5CF6 → #4C1D95.
  static const deep = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFF4C1D95)],
  );
}

abstract final class TogetherShadow {
  /// Idea Card — #5C21B5 35%, y18 b36 s-8.
  static const ideaCard = [
    BoxShadow(
      color: Color(0x595C21B5),
      offset: Offset(0, 18),
      blurRadius: 36,
      spreadRadius: -8,
    ),
  ];

  /// Matched Answer — #5C21B5 30%, y16 b32 s-6.
  static const matched = [
    BoxShadow(
      color: Color(0x4D5C21B5),
      offset: Offset(0, 16),
      blurRadius: 32,
      spreadRadius: -6,
    ),
  ];

  /// Received proposal card — #5C21B5 7%, y10 b24 s-4.
  static const card = [
    BoxShadow(
      color: Color(0x125C21B5),
      offset: Offset(0, 10),
      blurRadius: 24,
      spreadRadius: -4,
    ),
  ];

  /// New Time Sent status card — #5C21B5 6%, y6 b18 s-2.
  static const soft = [
    BoxShadow(
      color: Color(0x0F5C21B5),
      offset: Offset(0, 6),
      blurRadius: 18,
      spreadRadius: -2,
    ),
  ];

  /// Celebration sheet — #171221 25%, y-8 b40.
  static const sheet = [
    BoxShadow(
      color: Color(0x40171221),
      offset: Offset(0, -8),
      blurRadius: 40,
    ),
  ];
}

/// Text styles on Figma's AUTO line height (font metrics), so `height` is
/// left unset rather than forced to a ratio.
abstract final class TogetherText {
  static TextStyle _dm(double size) => GoogleFonts.dmSans(
        fontSize: size,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: TogetherInk.ink,
      );

  static TextStyle _inter(double size, FontWeight w, [double ls = 0]) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: w,
        letterSpacing: ls,
        color: TogetherInk.ink,
      );

  static TextStyle get navTitle => _dm(17);
  static TextStyle get question => _dm(28);
  static TextStyle get questionAnswered => _dm(26);
  static TextStyle get pageTitle => _dm(26);
  static TextStyle get sectionTitle => _dm(24);
  static TextStyle get cardTitleLarge => _dm(22);
  static TextStyle get matchedTitle => _dm(20);
  static TextStyle get stateTitle => _dm(18);
  static TextStyle get summaryTitle => _dm(16);
  static TextStyle get rowTitle => _dm(15);

  /// Uppercase eyebrow — 11 Semi Bold, ls 1.2 (1 on small summaries).
  static TextStyle get eyebrow => _inter(11, FontWeight.w600, 1.2);
  static TextStyle get eyebrowTight => _inter(11, FontWeight.w600, 1);

  static TextStyle get option => _inter(15, FontWeight.w600);
  static TextStyle get label => _inter(14, FontWeight.w600);
  static TextStyle get fieldValue => _inter(14.5, FontWeight.w600);
  static TextStyle get pill => _inter(13.5, FontWeight.w600);
  static TextStyle get fieldLabel => _inter(13, FontWeight.w600);
  static TextStyle get small => _inter(12, FontWeight.w600);
  static TextStyle get cta => _inter(12.5, FontWeight.w600);
  static TextStyle get button => _inter(15, FontWeight.w600)
      .copyWith(height: 20 / 15);

  static TextStyle get body => _inter(14, FontWeight.w400);
  static TextStyle get bodySmall => _inter(13.5, FontWeight.w400);
  static TextStyle get meta => _inter(13, FontWeight.w400);
  static TextStyle get caption => _inter(12.5, FontWeight.w400);
  static TextStyle get tiny => _inter(11.5, FontWeight.w400);
}
