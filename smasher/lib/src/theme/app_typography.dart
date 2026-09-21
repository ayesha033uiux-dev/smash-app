import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

/// Every text style in the file, at the exact metrics Figma reports.
///
/// Figma gives fontSize, lineHeight and letterSpacing in absolute pixels, so
/// that is what these take — no percentage conversion, nothing to round wrong.
/// Where the published token and the artboard disagree, the ARTBOARD wins and
/// the difference is noted on the style.
///
/// Display and Heading are DM Sans SemiBold; everything else is Inter.
abstract final class SmasherText {
  static TextStyle _dm(double size, double lineHeight, double ls) =>
      GoogleFonts.dmSans(
        fontSize: size,
        height: lineHeight / size,
        letterSpacing: ls,
        fontWeight: FontWeight.w600,
      );

  static TextStyle _inter(
    double size,
    double lineHeight,
    FontWeight weight, [
    double ls = 0,
  ]) =>
      GoogleFonts.inter(
        fontSize: size,
        height: lineHeight / size,
        letterSpacing: ls,
        fontWeight: weight,
      );

  // ---------------------------------------------------------------- Display

  static TextStyle get displayLarge => _dm(40, 48, -1.5);

  /// 36/44 — the Together greeting.
  static TextStyle get displayMedium => _dm(36, 44, -1.5);

  // ---------------------------------------------------------------- Heading

  /// 32/38 ls -0.9. The published Heading/H1 token says 32/40 ls -1.0, but
  /// every artboard draws 38/-0.9 — verified on P02 02, 03, 04, 05, 06, 07
  /// and 09. The artboards win.
  static TextStyle get h1 => _dm(32, 38, -0.9);

  static TextStyle get h2 => _dm(24, 32, -1);
  static TextStyle get h3 => _dm(20, 28, -0.5);
  static TextStyle get h4 => _dm(18, 24, -0.5);

  // ------------------------------------------------------------------- Body

  static TextStyle get bodyLarge => _inter(17, 26, FontWeight.w400);
  static TextStyle get bodyDefault => _inter(15, 22, FontWeight.w400);
  static TextStyle get bodyMedium => _inter(15, 22, FontWeight.w500);
  static TextStyle get bodyStrong => _inter(15, 22, FontWeight.w600);
  static TextStyle get bodySmall => _inter(13, 18, FontWeight.w400);
  static TextStyle get bodySmallMedium => _inter(13, 18, FontWeight.w500);

  /// 14/20 Regular — the description inside a Method card, one step down from
  /// the 15/22 used for screen descriptions.
  static TextStyle get bodyCompact => _inter(14, 20, FontWeight.w400);

  // ---------------------------------------------------------------- Buttons

  /// 15/20 Inter Semi Bold — every full-width button label in the file.
  static TextStyle get buttonLarge => _inter(15, 20, FontWeight.w600);
  static TextStyle get buttonSmall => _inter(13, 18, FontWeight.w600);

  // --------------------------------------------------------- Labels & chips

  /// 11/14 Inter Semi Bold ls 1.1, uppercase.
  ///
  /// The file's one small-caps label: the violet eyebrow above a screen title,
  /// the grey section label on module homes, and the field label above the
  /// code entry all use these exact metrics — only the colour changes. (The
  /// Together home's "EXPLORE TOGETHER" is drawn at ls 1.4, a one-off.)
  static TextStyle get eyebrow => _inter(11, 14, FontWeight.w600, 1.1);

  /// 11/14 Inter Medium ls 0.1 — bottom-navigation labels.
  static TextStyle get navLabel => _inter(11, 14, FontWeight.w500, 0.1);

  /// 11/16 Inter Semi Bold ls 0.22 — the eyebrow chip on the module hero.
  static TextStyle get chipLabel => _inter(11, 16, FontWeight.w600, 0.22);

  /// 11/16 Inter Medium ls 2% (0.22px) — the label inside a badge pill.
  static TextStyle get badgeLabel => _inter(11, 16, FontWeight.w500, 0.22);

  /// 12/16 Inter Semi Bold ls 2% (0.24px) — initials inside an avatar.
  static TextStyle get avatarInitials =>
      _inter(12, 16, FontWeight.w600, 0.24);

  /// 12/16 Inter Medium — the uppercase label on a Card/Code, and the "or"
  /// between two alternatives.
  static TextStyle get codeCardLabel => _inter(12, 16, FontWeight.w500);

  // ------------------------------------------------------- Card & tile text

  /// 16/21 DM Sans SemiBold — tile and feature card titles. The Figma layers
  /// report style "SemiBold" (DM Sans), not "Semi Bold" (Inter).
  static TextStyle get cardTitle => _dm(16, 21, -0.5);

  static TextStyle get cardSubtitle => _inter(12, 16, FontWeight.w400);
  static TextStyle get pillLabel => _inter(14, 17, FontWeight.w500);

  /// 14/17 Inter Semi Bold — the hero CTA label.
  static TextStyle get ctaLabel => _inter(14, 17, FontWeight.w600);

  /// 12.5/15 Inter Semi Bold — the "View matches →" link on tile cards.
  static TextStyle get cardLink => _inter(12.5, 15, FontWeight.w600);

  /// 20/26 DM Sans SemiBold ls -0.3 — the title on a Method card.
  static TextStyle get methodTitle => _dm(20, 26, -0.3);

  /// 18/24 DM Sans SemiBold ls 0.5 — the "SMASH" prefix chip on a code field.
  static TextStyle get codePrefix => _dm(18, 24, 0.5);

  /// 24/30 DM Sans SemiBold — one typed character in a code field.
  static TextStyle get codeDigit => _dm(24, 30, 0);
}
