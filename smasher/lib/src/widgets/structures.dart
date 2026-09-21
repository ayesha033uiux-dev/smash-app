import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'controls.dart';
import 'primitives.dart';

/// Figma: Header/Back — h52, pad 8/24, 24px arrow drawn at 1.75 stroke.
class BackHeader extends StatelessWidget implements PreferredSizeWidget {
  const BackHeader({super.key, this.onBack, this.trailing, this.title});

  final VoidCallback? onBack;
  final Widget? trailing;
  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(SmasherScreen.headerHeight);

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return SizedBox(
      height: SmasherScreen.headerHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SmasherScreen.padding,
          vertical: 8,
        ),
        child: Row(
          children: [
            InkResponse(
              onTap: onBack ?? () => Navigator.of(context).maybePop(),
              radius: 24,
              child: SmasherIcon(
                SmasherIcons.arrowLeft,
                size: SmasherSize.iconMd,
                color: c.textPrimary,
              ),
            ),
            if (title != null) ...[
              const SizedBox(width: 12),
              Text(
                title!,
                style: SmasherText.bodyStrong.copyWith(color: c.textPrimary),
              ),
            ],
            const Spacer(),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

/// A rounded white container that groups rows with hairlines between them.
/// Figma: Group/List — r22, white fill, 1px #EDEDF3 outline.
class GroupList extends StatelessWidget {
  const GroupList({super.key, required this.children, this.elevated = false});

  final List<Widget> children;

  /// Adds the card shadow (y2 b4 4% + y14 b30 s-8 7%) the Invitation
  /// Management list carries; the Profile settings group is flat.
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      rows.add(children[i]);
      if (i != children.length - 1) rows.add(const SmasherDivider());
    }
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: c.surfaceDefault,
        border: Border.all(color: c.screen.barHairline),
        borderRadius: BorderRadius.circular(SmasherRadius.groupList),
        boxShadow: elevated
            ? const [
                BoxShadow(
                  color: Color(0x0A171724),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: Color(0x12171724),
                  offset: Offset(0, 14),
                  blurRadius: 30,
                  spreadRadius: -8,
                ),
              ]
            : null,
      ),
      child: Column(children: rows),
    );
  }
}

/// The 28px round tile that ends an action row.
/// Figma: Chevron Tile — r999, fill #F5F5F9, 16px glyph.
class ChevronTile extends StatelessWidget {
  const ChevronTile({super.key, this.icon = SmasherIcons.chevronRight});

  /// A constant from [SmasherIcons].
  final String icon;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: c.screen.chevronTile,
        shape: BoxShape.circle,
      ),
      child: SmasherIcon(icon, size: 16, color: c.screen.chevronGlyph),
    );
  }
}

/// The two leading-tile treatments the file uses for [ActionCard].
enum ActionTone {
  /// Soft violet tint tile with a violet glyph — every action row in the
  /// file, including the Profile settings rows (verified by exporting them).
  soft,

  /// Deep violet gradient tile with a white glyph. Not used by any action row
  /// in the file today; kept for the Idea Deck-style emphasis if one appears.
  deep,
}

/// A tappable row inside a [GroupList].
///
/// Figma: Card/Action — pad 18, gap 14. Leading tile 42 at r14, copy block at
/// gap 4 (title Inter Semi Bold 15, description Body/Small 13 at #6B6B78),
/// trailing [ChevronTile]. Height follows the copy: 80 for a one-line
/// description, 98 when it wraps to two.
///
/// The leading tile is the soft #F4EFFE → #E8DEFC tint with a #7C3AED glyph
/// everywhere the file draws this row.
class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.showChevron = true,
    this.tone = ActionTone.soft,
    this.standalone = false,
  });

  /// A constant from [SmasherIcons].
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool showChevron;
  final ActionTone tone;

  /// Outside a [GroupList] the row carries its own surface: r20, white,
  /// 1px #EDEDF3, and pad 16 rather than 18 (Join Circle draws it this way).
  final bool standalone;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    final deep = tone == ActionTone.deep;
    return Material(
      color: standalone ? c.surfaceDefault : Colors.transparent,
      borderRadius: standalone
          ? BorderRadius.circular(SmasherRadius.card)
          : null,
      clipBehavior: standalone ? Clip.antiAlias : Clip.none,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(standalone ? 16 : 18),
          decoration: standalone
              ? BoxDecoration(
                  border: Border.all(color: c.screen.barHairline),
                  borderRadius: BorderRadius.circular(SmasherRadius.card),
                )
              : null,
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: deep
                      ? SmasherGradient.deepTile
                      : SmasherGradient.softTint,
                  borderRadius: BorderRadius.circular(SmasherRadius.md),
                ),
                child: SmasherIcon(
                  icon,
                  size: 20,
                  color: deep ? c.brandOnPrimary : c.brandPrimary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style:
                          SmasherText.bodyStrong.copyWith(color: c.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: SmasherText.bodySmall
                          .copyWith(color: c.textTertiary),
                    ),
                  ],
                ),
              ),
              if (showChevron) ...[
                const SizedBox(width: 14),
                const ChevronTile(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The tall card that presents the recommended way to do something: a large
/// tinted tile, a headline, a paragraph, and its own full-width CTA.
///
/// Figma: Method/Primary — 342, r24, white, 1px #EDEDF3, pad 22/24, gap 16.
/// Icon tile 56 at r18 with a 26px glyph; copy block at gap 6 (title DM Sans
/// SemiBold 20/26, description Inter 14/20); button h48 at r999.
class MethodCard extends StatelessWidget {
  const MethodCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.actionLabel,
    this.onAction,
  });

  /// A constant from [SmasherIcons].
  final String icon;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      decoration: BoxDecoration(
        color: c.surfaceDefault,
        border: Border.all(color: c.screen.barHairline),
        borderRadius: BorderRadius.circular(SmasherRadius.featureCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: SmasherGradient.softTint,
              borderRadius: BorderRadius.circular(SmasherRadius.codeCard),
            ),
            child: SmasherIcon(icon, size: 26, color: c.brandPrimary),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: SmasherText.methodTitle.copyWith(color: c.textPrimary),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: SmasherText.bodyCompact.copyWith(color: c.screen.bodyText),
          ),
          const SizedBox(height: 16),
          SmasherButton(
            label: actionLabel,
            onPressed: onAction,
            height: SmasherSize.controlHeightMd + 4,
          ),
        ],
      ),
    );
  }
}

/// Two hairlines with a lowercase "or" between them.
/// Figma: Or — h16, gap 12, 1px #E4E4EC lines, label 12/16 Inter Medium
/// #8A8A96.
class OrDivider extends StatelessWidget {
  const OrDivider({super.key, this.label = 'or'});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    final line = Expanded(child: Container(height: 1, color: c.screen.orLine));
    return Row(
      children: [
        line,
        const SizedBox(width: 12),
        Text(
          label,
          style: SmasherText.codeCardLabel
              .copyWith(color: c.screen.sectionLabel),
        ),
        const SizedBox(width: 12),
        line,
      ],
    );
  }
}

/// The centred white card that presents something to be shared or read out:
/// a QR code, an invite code, a recovery key.
///
/// Figma: Card/Code — r18, white, 1px #EDEDF3 outline, pad 20, gap 16.
/// Uppercase label 12 Medium #71717F, the payload, then a lock note row
/// (gap 8, 20px glyph, 13 Regular #6B6B78).
class CodeCard extends StatelessWidget {
  const CodeCard({
    super.key,
    required this.label,
    required this.child,
    this.note,
    this.noteIcon = SmasherIcons.lock,
  });

  final String label;
  final Widget child;
  final String? note;
  /// A constant from [SmasherIcons].
  final String noteIcon;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: c.surfaceDefault,
        border: Border.all(color: c.screen.barHairline),
        borderRadius: BorderRadius.circular(SmasherRadius.codeCard),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label.toUpperCase(),
            style: SmasherText.codeCardLabel
                .copyWith(color: c.screen.mutedText),
          ),
          const SizedBox(height: 16),
          child,
          if (note != null) ...[
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmasherIcon(noteIcon, size: 20, color: c.textTertiary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    note!,
                    style: SmasherText.bodySmall
                        .copyWith(color: c.textTertiary),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// A plain icon + title + supporting-line row on its own white card.
///
/// Figma: Card/Info — r18, white, 1px #EDEDF3, pad 16, gap 12, a 20px glyph
/// pinned to the TOP of the row and a copy block at gap 4.
/// Figma: Card/Status — the same card with a 24px glyph, vertically CENTRED,
/// and a tighter gap 2 copy block.
class InfoRowCard extends StatelessWidget {
  const InfoRowCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.centred = false,
  });

  /// A constant from [SmasherIcons].
  final String icon;
  final String title;
  final String subtitle;

  /// Card/Status: 24px glyph, centred, copy gap 2.
  final bool centred;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.surfaceDefault,
        border: Border.all(color: c.screen.barHairline),
        borderRadius: BorderRadius.circular(SmasherRadius.codeCard),
      ),
      child: Row(
        crossAxisAlignment:
            centred ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SmasherIcon(
            icon,
            size: centred ? 24 : 20,
            // Both forms draw the glyph in #8A8A96.
            color: c.screen.sectionLabel,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: SmasherText.bodyStrong.copyWith(color: c.textPrimary),
                ),
                SizedBox(height: centred ? 2 : 4),
                Text(
                  subtitle,
                  style:
                      SmasherText.bodySmall.copyWith(color: c.textTertiary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The dark camera viewport on the QR scanner.
///
/// Figma: Scanner — 342x339, r28, fill #121218, a 300px violet glow at 22%,
/// four 46px corner brackets and a hint pill (r999, white at 12%, pad 10/16,
/// label 13/18 Inter Medium at white 85%).
class ScannerFrame extends StatelessWidget {
  const ScannerFrame({super.key, required this.hint, this.height = 339});

  final String hint;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    const white = Color(0xFFFFFFFF);

    // Figma measurements, all relative to the 342x339 Scanner frame:
    // glow 300x300 at y1, centred; reticle brackets 46x46 inset 63 from each
    // side and 41 from the top, making a 216 square; hint pill 27 off the
    // bottom. (The right-hand brackets are rotated instances, so their
    // reported x is the pre-rotation origin and cannot be used directly —
    // the render confirms the reticle is symmetric.)
    return ClipRRect(
      borderRadius: BorderRadius.circular(SmasherRadius.hero),
      child: Container(
        height: height,
        width: double.infinity,
        color: c.screen.scannerInk,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 1,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // The Figma layer is a flat 22% disc with a blur on it.
                  // A radial falloff gets to the same picture without paying
                  // for a real-time ImageFilter on every frame.
                  gradient: RadialGradient(
                    colors: [
                      c.brandPrimary.withValues(alpha: 0.22),
                      c.brandPrimary.withValues(alpha: 0.0),
                    ],
                    stops: const [0.55, 1.0],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 41,
              left: 63,
              child: _ScanBracket(true, true),
            ),
            const Positioned(
              top: 41,
              right: 63,
              child: _ScanBracket(true, false),
            ),
            const Positioned(
              bottom: 84,
              left: 63,
              child: _ScanBracket(false, true),
            ),
            const Positioned(
              bottom: 84,
              right: 63,
              child: _ScanBracket(false, false),
            ),
            Positioned(
              bottom: 27,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(SmasherRadius.full),
                ),
                child: Text(
                  hint,
                  style: SmasherText.bodySmallMedium
                      .copyWith(color: white.withValues(alpha: 0.85)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One 46x46 corner of the scanner reticle: an L with a rounded elbow,
/// #A78BFA stroked at 4 with round caps.
///
/// Drawn with a painter rather than a [Border]: Flutter asserts on a
/// borderRadius when the four sides are not uniform, which they never are here.
class _ScanBracket extends StatelessWidget {
  const _ScanBracket(this.top, this.left);

  final bool top;
  final bool left;

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: const Size(46, 46),
        painter: _BracketPainter(top: top, left: left),
      );
}

class _BracketPainter extends CustomPainter {
  const _BracketPainter({required this.top, required this.left});

  final bool top;
  final bool left;

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 16.0;
    final w = size.width;
    final h = size.height;

    // Corner the elbow sits in, and the two straight runs leading away.
    final cx = left ? 2.0 : w - 2;
    final cy = top ? 2.0 : h - 2;
    final hx = left ? w : 0.0; // end of the horizontal run
    final vy = top ? h : 0.0; // end of the vertical run

    final path = Path()
      ..moveTo(cx, vy)
      ..lineTo(cx, cy + (top ? radius : -radius))
      ..quadraticBezierTo(cx, cy, cx + (left ? radius : -radius), cy)
      ..lineTo(hx, cy);

    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFA78BFA)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_BracketPainter old) =>
      old.top != top || old.left != left;
}

/// A circle shown as a row: avatar, name and member count, status badge.
/// Figma: Card/Circle — r18, white, 1px #EDEDF3 outline, pad 20, gap 12,
/// copy block at gap 2.
class CircleCard extends StatelessWidget {
  const CircleCard({
    super.key,
    required this.initials,
    required this.name,
    required this.meta,
    this.badge,
    this.onTap,
  });

  final String initials;
  final String name;
  final String meta;
  final String? badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Material(
      color: c.surfaceDefault,
      borderRadius: BorderRadius.circular(SmasherRadius.codeCard),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: c.screen.barHairline),
            borderRadius: BorderRadius.circular(SmasherRadius.codeCard),
          ),
          child: Row(
            children: [
              InitialsAvatar(initials),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style:
                          SmasherText.bodyStrong.copyWith(color: c.textPrimary),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      meta,
                      style: SmasherText.bodySmall
                          .copyWith(color: c.textTertiary),
                    ),
                  ],
                ),
              ),
              if (badge != null) ...[
                const SizedBox(width: 12),
                SmasherBadge(badge!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Standalone outlined card used on module homes (Idea Deck, Matches…).
/// Figma: Card / Idea Deck — r24, 1px #E0D4FA border, pad 16/16/16/18, gap 14.
class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  /// A constant from [SmasherIcons].
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(SmasherRadius.featureCard),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
          decoration: BoxDecoration(
            // The card itself is violet-tinted, not white — #F4EFFE → #E8DEFC.
            gradient: SmasherGradient.softTint,
            border: Border.all(color: c.screen.cardBorder),
            borderRadius: BorderRadius.circular(SmasherRadius.featureCard),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: SmasherGradient.deepTile,
                  borderRadius:
                      BorderRadius.circular(SmasherRadius.iconTileLarge),
                ),
                child: SmasherIcon(icon, size: 22, color: c.brandOnPrimary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: SmasherText.cardTitle.copyWith(color: c.textPrimary),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: SmasherText.cardSubtitle
                          .copyWith(color: c.screen.softCardText),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: c.surfaceDefault,
                  shape: BoxShape.circle,
                ),
                child: SmasherIcon(
                  SmasherIcons.arrowRight,
                  size: 16,
                  color: c.screen.deepInk,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The circle switcher pill in module headers.
/// Figma: Circle Pill — h42, r24, white, 1px #E8DEFC, overlapping 30px avatars.
class CirclePill extends StatelessWidget {
  const CirclePill({
    super.key,
    required this.name,
    this.memberColors = const [],
    this.onTap,
  });

  final String name;
  final List<Color> memberColors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    final avatars = memberColors.isEmpty
        ? [c.brandPrimary, c.screen.pillBorder]
        : memberColors;

    return Material(
      color: c.surfaceDefault,
      borderRadius: BorderRadius.circular(SmasherRadius.circlePill),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(SmasherRadius.circlePill),
        child: Container(
          height: 42,
          padding: const EdgeInsets.fromLTRB(6, 6, 14, 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SmasherRadius.circlePill),
            border: Border.all(color: c.screen.pillBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 30 + (avatars.length - 1) * 20,
                height: 30,
                child: Stack(
                  children: [
                    for (var i = 0; i < avatars.length; i++)
                      Positioned(
                        left: i * 20,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: avatars[i],
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: c.surfaceDefault, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: SmasherText.pillLabel.copyWith(color: c.textPrimary),
              ),
              const SizedBox(width: 6),
              SmasherIcon(
                SmasherIcons.chevronDown,
                size: 14,
                color: c.brandPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Five-tab bottom navigation.
/// Figma: 58px of items + 30px home indicator, icon 24, label 11,
/// active #7C3AED, inactive #71717F, 8px unread dot on Messages.
class SmasherBottomNav extends StatelessWidget {
  const SmasherBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.badges = const {},
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  /// Tab index -> show an unread dot.
  final Map<int, bool> badges;

  static const _items = <({String icon, String label})>[
    // Figma draws Together as a two-person glyph, not a heart.
    (icon: SmasherIcons.users, label: 'Together'),
    (icon: SmasherIcons.moments, label: 'Moments'),
    (icon: SmasherIcons.stories, label: 'Stories'),
    (icon: SmasherIcons.messages, label: 'Messages'),
    (icon: SmasherIcons.profile, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Container(
      decoration: BoxDecoration(
        color: c.surfaceDefault,
        border: Border(top: BorderSide(color: c.screen.barHairline)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: SmasherScreen.bottomNavItemsHeight,
          child: Row(
            children: [
              for (var i = 0; i < _items.length; i++)
                Expanded(
                  child: _NavItem(
                    icon: _items[i].icon,
                    label: _items[i].label,
                    selected: i == currentIndex,
                    badge: badges[i] ?? false,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.badge,
    required this.onTap,
  });

  /// A constant from [SmasherIcons].
  final String icon;
  final String label;
  final bool selected;
  final bool badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    final tint = selected ? c.brandPrimary : c.screen.mutedText;

    return InkResponse(
      onTap: onTap,
      radius: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: SmasherSize.iconMd,
            height: SmasherSize.iconMd,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SmasherIcon(icon, size: SmasherSize.iconMd, color: tint),
                if (badge)
                  Positioned(
                    top: -1,
                    right: -1,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: c.screen.badge,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: c.surfaceDefault, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(label, style: SmasherText.navLabel.copyWith(color: tint)),
        ],
      ),
    );
  }
}

/// Screen shell: header, scrolling body with the 24px gutter, optional
/// footnote and bottom bar. Mirrors the Header / Body / Bottom split that
/// every artboard in the file uses.
class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    super.key,
    this.header,
    required this.children,
    this.footnote,
    this.bottomBar,
    this.bottomNav,
    this.backgroundColor,
    this.wash = true,
    this.center = false,
    this.gap = SmasherScreen.bodyGap,
  });

  final Widget? header;
  final List<Widget> children;
  final Widget? footnote;
  final Widget? bottomBar;
  final Widget? bottomNav;
  final Color? backgroundColor;

  /// The artboards in the P02 flow do not sit on a flat fill: their root frame
  /// carries [SmasherGradient.screenWash], a violet tint at the top fading to
  /// grey by the upper third. Pass false — or a [backgroundColor] — for the
  /// screens that really are flat.
  final bool wash;

  /// Status screens (Circle Ready, You're In, the error states) centre their
  /// Body frame on both axes instead of stacking from the top.
  final bool center;

  final double gap;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    // The wash is a light-mode fill; dark mode keeps the flat background.
    final flat = backgroundColor != null ||
        !wash ||
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: flat
          ? null
          : const BoxDecoration(gradient: SmasherGradient.screenWash),
      child: Scaffold(
        backgroundColor:
            flat ? (backgroundColor ?? c.backgroundPrimary) : Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              if (header != null) header!,
              Expanded(
                child: LayoutBuilder(
                  builder: (context, box) => SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      SmasherScreen.padding,
                      4,
                      SmasherScreen.padding,
                      SmasherScreen.padding,
                    ),
                    child: ConstrainedBox(
                      // Lets the centred body actually centre while still
                      // scrolling if the content outgrows the viewport.
                      // 28 = the 4 top + 24 bottom padding above.
                      constraints: center
                          ? BoxConstraints(
                              minHeight: (box.maxHeight - 28)
                                  .clamp(0.0, double.infinity),
                            )
                          : const BoxConstraints(),
                      child: Column(
                        crossAxisAlignment: center
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        mainAxisAlignment: center
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: [
                          for (var i = 0; i < children.length; i++) ...[
                            children[i],
                            if (i != children.length - 1)
                              SizedBox(height: gap),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (footnote != null) footnote!,
              if (bottomBar != null) bottomBar!,
              if (bottomNav != null) bottomNav!,
            ],
          ),
        ),
      ),
    );
  }
}
