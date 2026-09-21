import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../theme/app_theme.dart';
import 'controls.dart';
import 'primitives.dart';
import 'structures.dart';

/// Header used on every module home: circle switcher pill on the left,
/// notification button on the right. Figma: Header — h44, gap 8.
class ModuleHeader extends StatelessWidget {
  const ModuleHeader({
    super.key,
    required this.circleName,
    this.onSwitchCircle,
    this.onNotifications,
    this.hasNotifications = true,
  });

  final String circleName;
  final VoidCallback? onSwitchCircle;
  final VoidCallback? onNotifications;
  final bool hasNotifications;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          CirclePill(
            name: circleName,
            onTap: onSwitchCircle ??
                () => Navigator.of(context).pushNamed(Routes.circleSwitcher),
          ),
          const Spacer(),
          RoundIconButton(
            icon: SmasherIcons.bell,
            showBadge: hasNotifications,
            onPressed: onNotifications ??
                () => Navigator.of(context).pushNamed(Routes.notifications),
          ),
        ],
      ),
    );
  }
}

/// Title + description at the top of a module body.
/// Figma: Head — gap 8, H1 32, Description 15.
///
/// Distinct from HeadBlock, which carries an eyebrow and icon tile and is used
/// on task screens rather than module homes.
class ModuleHead extends StatelessWidget {
  const ModuleHead({
    super.key,
    required this.title,
    required this.description,
    this.large = false,
  });

  final String title;
  final String description;

  /// Together draws its greeting at 36 (Display/Medium); Moments, Stories
  /// and Messages all use 32 (Heading/H1).
  final bool large;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: (large ? SmasherText.displayMedium : SmasherText.h1)
              .copyWith(color: c.textPrimary),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: SmasherText.bodyDefault.copyWith(color: c.screen.bodyText),
        ),
      ],
    );
  }
}

/// Figma: Empty State — pad 24, gap 10, every child centred.
/// 52px #EFEFF4 tile at r16 with a y6 b14 s-4 5% shadow and a 24px #8A8A96
/// glyph; title 18/24 DM Sans ls -0.2; description 15/22 #52525E; optional
/// hugging primary button. Same block on Moments, Stories, Messages and
/// No Pending Invitations.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });

  /// A constant from [SmasherIcons].
  final String icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: c.screen.emptyTile,
              borderRadius: BorderRadius.circular(SmasherRadius.infoStrip),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D171724), // 5%
                  offset: Offset(0, 6),
                  blurRadius: 14,
                  spreadRadius: -4,
                ),
              ],
            ),
            child: SmasherIcon(icon, size: 24, color: c.screen.sectionLabel),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: SmasherText.h4.copyWith(
              color: c.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: SmasherText.bodyDefault.copyWith(color: c.textSecondary),
          ),
          if (actionLabel != null) ...[
            const SizedBox(height: 10),
            SmasherButton(
              label: actionLabel!,
              expand: false,
              onPressed: onAction,
            ),
          ],
        ],
      ),
    );
  }
}

/// The gradient hero on module homes.
/// Figma: Hero / Daily Question — r28, brand gradient, two decorative circles
/// bleeding off the right edge, copy block gap 10, white CTA pill.
class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.eyebrow,
    required this.title,
    this.ctaLabel,
    this.onCta,
  });

  final String eyebrow;
  final String title;
  final String? ctaLabel;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    const white = Color(0xFFFFFFFF);

    return Container(
      height: 196,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: SmasherGradient.hero,
        borderRadius: BorderRadius.circular(SmasherRadius.hero),
        boxShadow: SmasherShadow.brandGlow,
      ),
      child: Stack(
        children: [
          // 190px outlined ring and a 130px 7% disc, both bleeding off the
          // right edge — straight off the Figma layer list.
          Positioned(
            right: -58,
            top: -36,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: white.withValues(alpha: 0.22)),
              ),
            ),
          ),
          Positioned(
            right: -18,
            top: 34,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: white.withValues(alpha: 0.07),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Eyebrow is a chip, not loose text: r999, white at 16%,
                    // pad 5/10, 12px glyph, gap 6.
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: white.withValues(alpha: 0.16),
                        borderRadius:
                            BorderRadius.circular(SmasherRadius.full),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SmasherIcon(
                            SmasherIcons.sparkle,
                            size: 12,
                            color: white,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            eyebrow.toUpperCase(),
                            style:
                                SmasherText.chipLabel.copyWith(color: white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: SmasherText.h3.copyWith(color: white),
                    ),
                  ],
                ),
                if (ctaLabel != null)
                  Material(
                    color: c.surfaceDefault,
                    borderRadius: BorderRadius.circular(SmasherRadius.full),
                    child: InkWell(
                      onTap: onCta,
                      borderRadius: BorderRadius.circular(SmasherRadius.full),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 11, 14, 11),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              ctaLabel!,
                              style: SmasherText.ctaLabel
                                  .copyWith(color: c.screen.deepInk),
                            ),
                            const SizedBox(width: 8),
                            SmasherIcon(
                              SmasherIcons.arrowRight,
                              size: 15,
                              color: c.screen.deepInk,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Square-ish tile used in pairs under a section label.
///
/// Figma: Card / Matches, Card / Proposals — 165x178, r24, white fill,
/// 1px #F0ECFC border, column gap 10, pad 18/18/16/18. The tile carries
/// no headline number: icon, title, description, then a violet text link.
class TileCard extends StatelessWidget {
  const TileCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.linkLabel,
    this.onTap,
  });

  /// A constant from [SmasherIcons].
  final String icon;
  final String title;
  final String description;
  final String linkLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Expanded(
      child: Material(
        color: c.surfaceDefault,
        borderRadius: BorderRadius.circular(SmasherRadius.featureCard),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 178,
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
            decoration: BoxDecoration(
              border: Border.all(color: c.screen.tileBorder),
              borderRadius: BorderRadius.circular(SmasherRadius.featureCard),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: SmasherGradient.softTint,
                    borderRadius: BorderRadius.circular(SmasherRadius.md),
                  ),
                  child: SmasherIcon(icon, size: 20, color: c.brandPrimary),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: SmasherText.cardTitle.copyWith(color: c.textPrimary),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Text(
                    description,
                    style: SmasherText.cardSubtitle
                        .copyWith(color: c.textTertiary),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      linkLabel,
                      style: SmasherText.cardLink
                          .copyWith(color: c.brandPrimary),
                    ),
                    const SizedBox(width: 5),
                    SmasherIcon(
                      SmasherIcons.arrowRight,
                      size: 13,
                      color: c.brandPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shell for a module home: the soft decorative wash, header, scrolling body
/// with the 24px gutter, and whatever bottom navigation the shell supplies.
///
/// Figma: Body — gap 24, pad 8/24/16/24, with a 520x420 #EDE6FD ellipse
/// bleeding off the top-right on Together and Profile.
class ModuleScaffold extends StatelessWidget {
  const ModuleScaffold({
    super.key,
    this.header,
    required this.children,
    this.showWash = true,
    this.washTop = -190,
    this.gap = 24,
    this.emptyState = false,
  });

  final Widget? header;
  final List<Widget> children;
  final bool showWash;

  /// The Moments / Stories / Messages layout: header flush under the status
  /// bar, Body pad 8/24/16, and the last child (the empty state) centred in
  /// whatever height is left, as the file's CENTER/CENTER Content frame does.
  final bool emptyState;

  /// Vertical offset of the decorative ellipse. Figma places it at -78 on
  /// Together and -210 on Profile; because the ellipse here is larger, both
  /// sit higher so the bottom curve clears the greeting.
  final double washTop;

  final double gap;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Container(
      color: c.backgroundPrimary,
      child: Stack(
        children: [
          // 520x412 ellipse at x -65 — wider than the 390 screen, so it
          // bleeds off both edges and washes the whole upper area.
          //
          // Must be an elliptical borderRadius, not BoxShape.circle: on a
          // non-square box Flutter's circle uses the SHORTER side as the
          // diameter, which drew a 412px circle and left a hard curved edge
          // cutting across the content.
          //
          // Figma draws it 520x412; widened to 700x540 and centred so the
          // curve is gentler and its bottom edge lands below the hero
          // instead of slicing across the greeting.
          if (showWash)
            Positioned(
              top: washTop,
              left: -155,
              child: Container(
                width: 700,
                height: 540,
                decoration: BoxDecoration(
                  color: c.screen.heroWash,
                  borderRadius: const BorderRadius.all(
                    Radius.elliptical(350, 270),
                  ),
                ),
              ),
            ),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (header != null)
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      SmasherScreen.padding,
                      emptyState ? 0 : 8,
                      SmasherScreen.padding,
                      0,
                    ),
                    child: header!,
                  ),
                if (emptyState)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        SmasherScreen.padding,
                        8,
                        SmasherScreen.padding,
                        16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final child in children.take(children.length - 1))
                            ...[child, SizedBox(height: gap)],
                          Expanded(child: Center(child: children.last)),
                        ],
                      ),
                    ),
                  )
                else
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      SmasherScreen.padding,
                      24,
                      SmasherScreen.padding,
                      16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < children.length; i++) ...[
                          children[i],
                          if (i != children.length - 1) SizedBox(height: gap),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
