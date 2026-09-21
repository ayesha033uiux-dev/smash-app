/// Layout tokens, generated from the Figma `Layout` collection (47 variables).
///
/// Where a screen measurement disagrees with a token, the screen value is
/// recorded in [SmasherScreen] and the discrepancy is listed in DESIGN_NOTES.md.
/// The screens are the source of truth for implementation.
abstract final class SmasherSpace {
  static const double x4 = 4;
  static const double x8 = 8;
  static const double x12 = 12;
  static const double x16 = 16;
  static const double x20 = 20;
  static const double x24 = 24;
  static const double x32 = 32;
  static const double x40 = 40;
  static const double x48 = 48;
  static const double x64 = 64;
  static const double x80 = 80;
  static const double x96 = 96;
}

abstract final class SmasherRadius {
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 20;
  static const double xl = 28;
  static const double full = 999;

  // Semantic aliases from the token set
  static const double button = full;
  static const double input = md; // 14
  static const double card = lg; // 20
  static const double hero = xl; // 28

  // Radii the screens actually use that the token set does not define.
  static const double groupList = 22;
  static const double infoStrip = 16;
  static const double featureCard = 24;
  static const double iconTile = 12;
  static const double iconTileLarge = 15;
  static const double circlePill = 24;
  static const double codeCard = 18;
}

abstract final class SmasherSize {
  static const double controlHeightLg = 52;
  static const double controlHeightMd = 44;
  static const double controlHeightSm = 36;
  static const double touchMin = 44;

  static const double iconXs = 16;
  static const double iconSm = 20;
  static const double iconMd = 24;
  static const double iconLg = 32;

  static const double avatarXs = 24;
  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatarLg = 48;
  static const double avatarXl = 64;
  static const double avatar2Xl = 80;

  static const double borderWidth = 1;

  /// Icon strokes on the screens are drawn at 1.75, not 1.
  static const double iconStroke = 1.75;
}

/// Measurements taken directly off the 390x844 artboards.
abstract final class SmasherScreen {
  static const double referenceWidth = 390;
  static const double referenceHeight = 844;

  /// Screen/Padding token = 24, and every Body frame confirms it.
  static const double padding = 24;

  /// Token says Size/Header-Height = 56; every screen draws 52.
  static const double headerHeight = 52;

  /// Bottom action bar: 76 tall, padding 14/24/10/24.
  static const double bottomBarHeight = 76;

  /// Bottom navigation: 58 of items + 30 of home indicator = 88.
  static const double bottomNavItemsHeight = 58;
  static const double bottomNavHeight = 88;

  /// Gap between the major blocks inside Body.
  static const double bodyGap = 28;

  /// Gap between Page Icon Tile and the Head text block.
  static const double headBlockGap = 18;

  /// Gap between Eyebrow / H1 / Description.
  static const double headGap = 8;

  /// Gap between items inside Content.
  static const double contentGap = 14;
}

abstract final class SmasherMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 200);
  static const Duration emphasis = Duration(milliseconds: 300);
  static const Duration large = Duration(milliseconds: 400);
}
