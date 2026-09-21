import 'package:flutter/material.dart';

/// Semantic colour tokens, generated from the Figma collections
/// `Theme — Light` and `Theme — Dark` (33 tokens each, aliases fully resolved).
///
/// Widgets must read these through `Theme.of(context).extension<SmasherPalette>()`
/// (or the `context.palette` helper in app_theme.dart) — never by hardcoding hex.
@immutable
class SmasherPalette extends ThemeExtension<SmasherPalette> {
  const SmasherPalette({
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.surfaceDefault,
    required this.surfaceElevated,
    required this.surfaceInteractive,
    required this.surfaceSelected,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.textInverse,
    required this.borderSubtle,
    required this.borderDefault,
    required this.borderStrong,
    required this.brandPrimary,
    required this.brandPressed,
    required this.brandDisabled,
    required this.brandSurface,
    required this.brandOnPrimary,
    required this.brandText,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.successSurface,
    required this.warningSurface,
    required this.errorSurface,
    required this.infoSurface,
    required this.boundaryYes,
    required this.boundaryMaybe,
    required this.boundaryNo,
    required this.boundaryNoEmphasis,
    required this.screen,
  });

  // Background
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundTertiary;

  // Surface
  final Color surfaceDefault;
  final Color surfaceElevated;
  final Color surfaceInteractive;
  final Color surfaceSelected;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color textInverse;

  // Border
  final Color borderSubtle;
  final Color borderDefault;
  final Color borderStrong;

  // Brand
  final Color brandPrimary;
  final Color brandPressed;
  final Color brandDisabled;
  final Color brandSurface;
  final Color brandOnPrimary;
  final Color brandText;

  // State
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color successSurface;
  final Color warningSurface;
  final Color errorSurface;
  final Color infoSurface;

  // Boundary — the consent scale used across the Together module
  final Color boundaryYes;
  final Color boundaryMaybe;
  final Color boundaryNo;
  final Color boundaryNoEmphasis;

  /// Colours that appear on the screens but are not in the Figma token set.
  /// Kept separate so the drift stays visible and can be reconciled later.
  final SmasherScreenColors screen;

  static const light = SmasherPalette(
    backgroundPrimary: Color(0xFFF7F7FA),
    backgroundSecondary: Color(0xFFFFFFFF),
    backgroundTertiary: Color(0xFFF1F1F5),
    surfaceDefault: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFFFFFFF),
    surfaceInteractive: Color(0xFFF1F1F5),
    surfaceSelected: Color(0xFFF1F1F5),
    textPrimary: Color(0xFF18181F),
    textSecondary: Color(0xFF52525E),
    textTertiary: Color(0xFF6B6B78),
    textDisabled: Color(0xFFA0A0AE),
    textInverse: Color(0xFFFFFFFF),
    borderSubtle: Color(0xFFE4E4EB),
    borderDefault: Color(0xFFD2D2DB),
    borderStrong: Color(0xFFA0A0AE),
    brandPrimary: Color(0xFF7C3AED),
    brandPressed: Color(0xFF6D28D9),
    brandDisabled: Color(0xFFF1F1F5),
    brandSurface: Color(0xFFF1F1F5),
    brandOnPrimary: Color(0xFFFFFFFF),
    brandText: Color(0xFF7C3AED),
    success: Color(0xFF16A34A),
    warning: Color(0xFFD97706),
    error: Color(0xFFDC2626),
    // NOTE: Figma has State/Info = #7C3AED in light, identical to Brand/Primary,
    // while its own Info-Surface is blue-tinted and dark mode uses #60A5FA.
    // Treated as a design bug — see DESIGN_NOTES.md. Change here once decided.
    info: Color(0xFF7C3AED),
    successSurface: Color(0xFFE8F6ED),
    warningSurface: Color(0xFFFBF1E6),
    errorSurface: Color(0xFFFCE9E9),
    infoSurface: Color(0xFFE9EFFD),
    boundaryYes: Color(0xFF16A34A),
    boundaryMaybe: Color(0xFFD97706),
    boundaryNo: Color(0xFF6B6B78),
    boundaryNoEmphasis: Color(0xFFDC2626),
    screen: SmasherScreenColors.light,
  );

  static const dark = SmasherPalette(
    backgroundPrimary: Color(0xFF0E0E13),
    backgroundSecondary: Color(0xFF18181F),
    backgroundTertiary: Color(0xFF27272F),
    surfaceDefault: Color(0xFF18181F),
    surfaceElevated: Color(0xFF27272F),
    surfaceInteractive: Color(0xFF27272F),
    surfaceSelected: Color(0xFF32323C),
    textPrimary: Color(0xFFF7F7FA),
    textSecondary: Color(0xFFA0A0AE),
    textTertiary: Color(0xFF8B8B99),
    textDisabled: Color(0xFF52525E),
    textInverse: Color(0xFF0E0E13),
    borderSubtle: Color(0xFF27272F),
    borderDefault: Color(0xFF3F3F49),
    borderStrong: Color(0xFF52525E),
    brandPrimary: Color(0xFF7C3AED),
    brandPressed: Color(0xFF6D28D9),
    brandDisabled: Color(0xFF2B2440),
    brandSurface: Color(0xFF261D3C),
    brandOnPrimary: Color(0xFFFFFFFF),
    brandText: Color(0xFFA78BFA),
    success: Color(0xFF4ADE80),
    warning: Color(0xFFF59E0B),
    error: Color(0xFFF87171),
    info: Color(0xFF60A5FA),
    successSurface: Color(0xFF1F342D),
    warningSurface: Color(0xFF372B1C),
    errorSurface: Color(0xFF37242A),
    infoSurface: Color(0xFF222C3E),
    boundaryYes: Color(0xFF4ADE80),
    boundaryMaybe: Color(0xFFF59E0B),
    boundaryNo: Color(0xFF8B8B99),
    boundaryNoEmphasis: Color(0xFFF87171),
    screen: SmasherScreenColors.dark,
  );

  @override
  SmasherPalette copyWith({
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundTertiary,
    Color? surfaceDefault,
    Color? surfaceElevated,
    Color? surfaceInteractive,
    Color? surfaceSelected,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? textInverse,
    Color? borderSubtle,
    Color? borderDefault,
    Color? borderStrong,
    Color? brandPrimary,
    Color? brandPressed,
    Color? brandDisabled,
    Color? brandSurface,
    Color? brandOnPrimary,
    Color? brandText,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? successSurface,
    Color? warningSurface,
    Color? errorSurface,
    Color? infoSurface,
    Color? boundaryYes,
    Color? boundaryMaybe,
    Color? boundaryNo,
    Color? boundaryNoEmphasis,
    SmasherScreenColors? screen,
  }) {
    return SmasherPalette(
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundTertiary: backgroundTertiary ?? this.backgroundTertiary,
      surfaceDefault: surfaceDefault ?? this.surfaceDefault,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceInteractive: surfaceInteractive ?? this.surfaceInteractive,
      surfaceSelected: surfaceSelected ?? this.surfaceSelected,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      textInverse: textInverse ?? this.textInverse,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderDefault: borderDefault ?? this.borderDefault,
      borderStrong: borderStrong ?? this.borderStrong,
      brandPrimary: brandPrimary ?? this.brandPrimary,
      brandPressed: brandPressed ?? this.brandPressed,
      brandDisabled: brandDisabled ?? this.brandDisabled,
      brandSurface: brandSurface ?? this.brandSurface,
      brandOnPrimary: brandOnPrimary ?? this.brandOnPrimary,
      brandText: brandText ?? this.brandText,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      successSurface: successSurface ?? this.successSurface,
      warningSurface: warningSurface ?? this.warningSurface,
      errorSurface: errorSurface ?? this.errorSurface,
      infoSurface: infoSurface ?? this.infoSurface,
      boundaryYes: boundaryYes ?? this.boundaryYes,
      boundaryMaybe: boundaryMaybe ?? this.boundaryMaybe,
      boundaryNo: boundaryNo ?? this.boundaryNo,
      boundaryNoEmphasis: boundaryNoEmphasis ?? this.boundaryNoEmphasis,
      screen: screen ?? this.screen,
    );
  }

  @override
  SmasherPalette lerp(ThemeExtension<SmasherPalette>? other, double t) {
    if (other is! SmasherPalette) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t) ?? a;
    return SmasherPalette(
      backgroundPrimary: c(backgroundPrimary, other.backgroundPrimary),
      backgroundSecondary: c(backgroundSecondary, other.backgroundSecondary),
      backgroundTertiary: c(backgroundTertiary, other.backgroundTertiary),
      surfaceDefault: c(surfaceDefault, other.surfaceDefault),
      surfaceElevated: c(surfaceElevated, other.surfaceElevated),
      surfaceInteractive: c(surfaceInteractive, other.surfaceInteractive),
      surfaceSelected: c(surfaceSelected, other.surfaceSelected),
      textPrimary: c(textPrimary, other.textPrimary),
      textSecondary: c(textSecondary, other.textSecondary),
      textTertiary: c(textTertiary, other.textTertiary),
      textDisabled: c(textDisabled, other.textDisabled),
      textInverse: c(textInverse, other.textInverse),
      borderSubtle: c(borderSubtle, other.borderSubtle),
      borderDefault: c(borderDefault, other.borderDefault),
      borderStrong: c(borderStrong, other.borderStrong),
      brandPrimary: c(brandPrimary, other.brandPrimary),
      brandPressed: c(brandPressed, other.brandPressed),
      brandDisabled: c(brandDisabled, other.brandDisabled),
      brandSurface: c(brandSurface, other.brandSurface),
      brandOnPrimary: c(brandOnPrimary, other.brandOnPrimary),
      brandText: c(brandText, other.brandText),
      success: c(success, other.success),
      warning: c(warning, other.warning),
      error: c(error, other.error),
      info: c(info, other.info),
      successSurface: c(successSurface, other.successSurface),
      warningSurface: c(warningSurface, other.warningSurface),
      errorSurface: c(errorSurface, other.errorSurface),
      infoSurface: c(infoSurface, other.infoSurface),
      boundaryYes: c(boundaryYes, other.boundaryYes),
      boundaryMaybe: c(boundaryMaybe, other.boundaryMaybe),
      boundaryNo: c(boundaryNo, other.boundaryNo),
      boundaryNoEmphasis: c(boundaryNoEmphasis, other.boundaryNoEmphasis),
      screen: screen.lerp(other.screen, t),
    );
  }
}

/// Values measured off the screens that have no matching Figma variable.
/// Every field here is drift — see DESIGN_NOTES.md before adding more.
@immutable
class SmasherScreenColors {
  const SmasherScreenColors({
    required this.bodyText,
    required this.mutedText,
    required this.sectionLabel,
    required this.hairline,
    required this.barHairline,
    required this.tileTint,
    required this.stripTint,
    required this.stripInk,
    required this.heroWash,
    required this.pillBorder,
    required this.cardBorder,
    required this.badge,
    required this.disabledFill,
    required this.disabledBorder,
    required this.emptyTile,
    required this.chevronTile,
    required this.chevronGlyph,
    required this.statusTile,
    required this.avatarBorder,
    required this.badgeTint,
    required this.orLine,
    required this.dashInk,
    required this.scannerInk,
    required this.errorTile,
    required this.errorGlyph,
    required this.tileBorder,
    required this.deepInk,
    required this.softCardText,
  });

  /// #5C5C6B — used for every screen description line. Nearest token is
  /// Text/Secondary #52525E.
  final Color bodyText;

  /// #71717F — footnotes and inactive nav labels. Nearest token Text/Tertiary #6B6B78.
  final Color mutedText;

  /// #8A8A96 — uppercase section labels.
  final Color sectionLabel;

  /// #F0F0F5 — divider inside grouped lists.
  final Color hairline;

  /// #EDEDF3 / #ECECF2 — hairline above the bottom bar and bottom nav.
  final Color barHairline;

  /// #F3EEFE — 40x40 page icon tile.
  final Color tileTint;

  /// #F1ECFD — info strip background.
  final Color stripTint;

  /// #4C3A82 — info strip label.
  final Color stripInk;

  /// The large decorative ellipse behind module home screens.
  /// Figma uses #EDE6FD; lightened to #F5F1FE so the wash reads as
  /// atmosphere rather than a shape with a visible edge.
  final Color heroWash;

  /// #E8DEFC — circle pill and round icon button border.
  final Color pillBorder;

  /// #E0D4FA — feature card border.
  final Color cardBorder;

  /// #E5484D — unread dot on the Messages tab. Token error red is #DC2626.
  final Color badge;

  /// #FFFFFF fill + #E6E6EE border — the disabled primary button.
  final Color disabledFill;
  final Color disabledBorder;

  /// #EFEFF4 — 52x52 icon tile inside empty states. Neutral, not violet.
  final Color emptyTile;

  /// #F5F5F9 — the 28px round chevron tile at the end of an action row.
  final Color chevronTile;

  /// #A1A1AE — the 16px chevron glyph itself. Lighter than Text/Secondary,
  /// which is what the action rows were drawing before.
  final Color chevronGlyph;

  /// #EDE6FD — the 64px round success tile, and the 48px circle avatar.
  /// Same violet as the top stop of the screen wash.
  final Color statusTile;

  /// #D8D4CC — the 1px ring around a circle avatar.
  final Color avatarBorder;

  /// #F1EAFE — the "Private" badge pill. Its ink is Brand/Pressed #6D28D9.
  final Color badgeTint;

  /// #E4E4EC — the hairlines either side of an "or" divider.
  final Color orLine;

  /// #C4C4CE — the en-dash between the prefix and the digits of a code field.
  final Color dashInk;

  /// #121218 — the camera viewport on the QR scanner. Near-black in both
  /// themes: it stands for the camera feed, not for a surface.
  final Color scannerInk;

  /// #FCECEC — the 64px status tile on the invitation error screens. The
  /// Error-Surface token is #FCE9E9; the artboards draw #FCECEC.
  final Color errorTile;

  /// #C43B3B — the glyph inside [errorTile]. Softer than State/Error #DC2626.
  final Color errorGlyph;

  /// #F0ECFC — border on the Matches / Proposals tile cards. Lighter than
  /// the #E0D4FA used on the Idea Deck card.
  final Color tileBorder;

  /// #5B21B6 — deep violet ink for text and arrows that sit on white
  /// against a violet ground: the hero CTA label, the round trailing arrows.
  final Color deepInk;

  /// #615978 — description text inside the violet-tinted Idea Deck card,
  /// where the usual #6B6B78 would read too grey.
  final Color softCardText;

  static const light = SmasherScreenColors(
    bodyText: Color(0xFF5C5C6B),
    mutedText: Color(0xFF71717F),
    sectionLabel: Color(0xFF8A8A96),
    hairline: Color(0xFFF0F0F5),
    barHairline: Color(0xFFEDEDF3),
    tileTint: Color(0xFFF3EEFE),
    stripTint: Color(0xFFF1ECFD),
    stripInk: Color(0xFF4C3A82),
    heroWash: Color(0xFFF5F1FE),
    pillBorder: Color(0xFFE8DEFC),
    cardBorder: Color(0xFFE0D4FA),
    badge: Color(0xFFE5484D),
    disabledFill: Color(0xFFFFFFFF),
    disabledBorder: Color(0xFFE6E6EE),
    emptyTile: Color(0xFFEFEFF4),
    chevronTile: Color(0xFFF5F5F9),
    chevronGlyph: Color(0xFFA1A1AE),
    statusTile: Color(0xFFEDE6FD),
    avatarBorder: Color(0xFFD8D4CC),
    badgeTint: Color(0xFFF1EAFE),
    orLine: Color(0xFFE4E4EC),
    dashInk: Color(0xFFC4C4CE),
    scannerInk: Color(0xFF121218),
    errorTile: Color(0xFFFCECEC),
    errorGlyph: Color(0xFFC43B3B),
    tileBorder: Color(0xFFF0ECFC),
    deepInk: Color(0xFF5B21B6),
    softCardText: Color(0xFF615978),
  );

  /// The Figma file has no dark variants for these — derived from the dark
  /// token set so dark mode stays legible until design supplies real values.
  static const dark = SmasherScreenColors(
    bodyText: Color(0xFFA0A0AE),
    mutedText: Color(0xFF8B8B99),
    sectionLabel: Color(0xFF8B8B99),
    hairline: Color(0xFF27272F),
    barHairline: Color(0xFF27272F),
    tileTint: Color(0xFF261D3C),
    stripTint: Color(0xFF261D3C),
    stripInk: Color(0xFFC4B5FD),
    heroWash: Color(0xFF2B2440),
    pillBorder: Color(0xFF3F3F49),
    cardBorder: Color(0xFF3F3F49),
    badge: Color(0xFFF87171),
    disabledFill: Color(0xFF18181F),
    disabledBorder: Color(0xFF3F3F49),
    emptyTile: Color(0xFF27272F),
    chevronTile: Color(0xFF27272F),
    chevronGlyph: Color(0xFF71717F),
    statusTile: Color(0xFF2B2440),
    avatarBorder: Color(0xFF3F3F49),
    badgeTint: Color(0xFF261D3C),
    orLine: Color(0xFF3F3F49),
    dashInk: Color(0xFF6E6E7B),
    scannerInk: Color(0xFF0B0B10),
    errorTile: Color(0xFF3A1F22),
    errorGlyph: Color(0xFFF87171),
    tileBorder: Color(0xFF3F3F49),
    deepInk: Color(0xFFC4B5FD),
    softCardText: Color(0xFFA0A0AE),
  );

  SmasherScreenColors lerp(SmasherScreenColors other, double t) {
    Color c(Color a, Color b) => Color.lerp(a, b, t) ?? a;
    return SmasherScreenColors(
      bodyText: c(bodyText, other.bodyText),
      mutedText: c(mutedText, other.mutedText),
      sectionLabel: c(sectionLabel, other.sectionLabel),
      hairline: c(hairline, other.hairline),
      barHairline: c(barHairline, other.barHairline),
      tileTint: c(tileTint, other.tileTint),
      stripTint: c(stripTint, other.stripTint),
      stripInk: c(stripInk, other.stripInk),
      heroWash: c(heroWash, other.heroWash),
      pillBorder: c(pillBorder, other.pillBorder),
      cardBorder: c(cardBorder, other.cardBorder),
      badge: c(badge, other.badge),
      disabledFill: c(disabledFill, other.disabledFill),
      disabledBorder: c(disabledBorder, other.disabledBorder),
      emptyTile: c(emptyTile, other.emptyTile),
      chevronTile: c(chevronTile, other.chevronTile),
      chevronGlyph: c(chevronGlyph, other.chevronGlyph),
      statusTile: c(statusTile, other.statusTile),
      avatarBorder: c(avatarBorder, other.avatarBorder),
      badgeTint: c(badgeTint, other.badgeTint),
      orLine: c(orLine, other.orLine),
      dashInk: c(dashInk, other.dashInk),
      scannerInk: c(scannerInk, other.scannerInk),
      errorTile: c(errorTile, other.errorTile),
      errorGlyph: c(errorGlyph, other.errorGlyph),
      tileBorder: c(tileBorder, other.tileBorder),
      deepInk: c(deepInk, other.deepInk),
      softCardText: c(softCardText, other.softCardText),
    );
  }
}
