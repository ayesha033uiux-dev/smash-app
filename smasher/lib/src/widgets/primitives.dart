import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_theme.dart';

/// Draws one glyph from [SmasherIcons].
///
/// Takes the SVG source rather than an [IconData] on purpose: the file's icons
/// are its own vectors, and a Material look-alike is visibly the wrong stroke
/// weight next to them. [color] tints the whole glyph, so the colours baked
/// into the export never leak through.
class SmasherIcon extends StatelessWidget {
  const SmasherIcon(this.icon, {super.key, required this.size, this.color});

  /// A constant from [SmasherIcons].
  final String icon;

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tint = color ?? context.palette.textPrimary;
    return SvgPicture.string(
      icon,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(tint, BlendMode.srcIn),
    );
  }
}

/// 40x40 tinted tile holding a 20px screen icon.
/// Figma: Page Icon Tile — r12, fill #F3EEFE, icon stroke #7C3AED.
class PageIconTile extends StatelessWidget {
  const PageIconTile(this.icon, {super.key, this.size = 40});

  /// A constant from [SmasherIcons].
  final String icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: c.screen.tileTint,
        borderRadius: BorderRadius.circular(SmasherRadius.iconTile),
      ),
      child: SmasherIcon(icon, size: size / 2, color: c.brandPrimary),
    );
  }
}

/// The file's one small-caps label: 11/14 Inter Semi Bold, ls 1.1, uppercase.
///
/// Verified identical on the screen eyebrow (#7C3AED), the module-home section
/// label (#8A8A96) and the code field label (#8A8A96) — only the colour
/// changes, so [tone] picks the colour and nothing else.
class SmasherLabel extends StatelessWidget {
  const SmasherLabel(this.text, {super.key, this.tone = LabelTone.brand});

  final String text;
  final LabelTone tone;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Text(
      text.toUpperCase(),
      style: SmasherText.eyebrow.copyWith(
        color: tone == LabelTone.brand
            ? c.brandPrimary
            : c.screen.sectionLabel,
      ),
    );
  }
}

enum LabelTone { brand, muted }

/// Eyebrow / H1 / Description, stacked with the 8px gap the screens use,
/// optionally preceded by the icon tile with an 18px gap.
///
/// Every P02–P08 screen opens with this block, which is why it is a widget
/// rather than three Texts repeated 247 times.
class HeadBlock extends StatelessWidget {
  const HeadBlock({
    super.key,
    this.icon,
    required this.eyebrow,
    required this.title,
    this.description,
  });

  /// A constant from [SmasherIcons].
  final String? icon;
  final String eyebrow;
  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          PageIconTile(icon!),
          const SizedBox(height: SmasherScreen.headBlockGap),
        ],
        SmasherLabel(eyebrow),
        const SizedBox(height: SmasherScreen.headGap),
        Text(title, style: SmasherText.h1.copyWith(color: c.textPrimary)),
        if (description != null) ...[
          const SizedBox(height: SmasherScreen.headGap),
          Text(
            description!,
            style: SmasherText.bodyDefault.copyWith(color: c.screen.bodyText),
          ),
        ],
      ],
    );
  }
}

/// How a [StatusTile] is tinted. The file uses violet when the outcome is
/// good and neutral grey while something is still pending or has failed.
enum StatusTone {
  /// #EDE6FD tile, #7C3AED glyph — Circle Ready, You're In.
  brand,

  /// #EFEFF4 tile, #71717F glyph — Waiting for Approval.
  neutral,

  /// #FCECEC tile, #C43B3B glyph — the four invitation error states.
  error,
}

/// 64px round tile holding a 28px glyph — the marker at the top of a status
/// screen.
/// Figma: Status Tile — r999, fill #EDE6FD, #EFEFF4 or #FCECEC.
class StatusTile extends StatelessWidget {
  const StatusTile(this.icon, {super.key, this.tone = StatusTone.brand});

  /// A constant from [SmasherIcons].
  final String icon;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    final (background, glyph) = switch (tone) {
      StatusTone.brand => (c.screen.statusTile, c.brandPrimary),
      StatusTone.neutral => (c.screen.emptyTile, c.screen.mutedText),
      StatusTone.error => (c.screen.errorTile, c.screen.errorGlyph),
    };
    return Container(
      width: 64,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: SmasherIcon(icon, size: 28, color: glyph),
    );
  }
}

/// The centred title block on a status screen: [StatusTile], then a centred
/// H1 and description at gap 8. The block itself sits at gap 20.
///
/// Distinct from [HeadBlock], which is left-aligned, carries an eyebrow and
/// uses the small 40px square tile.
class StatusHead extends StatelessWidget {
  const StatusHead({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.tone = StatusTone.brand,
  });

  /// A constant from [SmasherIcons].
  final String icon;
  final String title;
  final String? description;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StatusTile(icon, tone: tone),
        const SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: SmasherText.h1.copyWith(color: c.textPrimary),
        ),
        if (description != null) ...[
          const SizedBox(height: SmasherScreen.headGap),
          Text(
            description!,
            textAlign: TextAlign.center,
            style: SmasherText.bodyDefault.copyWith(color: c.screen.bodyText),
          ),
        ],
      ],
    );
  }
}

/// Small rounded pill: "Private", "Pending", "Expired".
/// Figma: Badge — r999, pad 4/12, label 11 Inter Medium.
class SmasherBadge extends StatelessWidget {
  const SmasherBadge(this.label, {super.key, this.background, this.ink});

  final String label;
  final Color? background;
  final Color? ink;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: background ?? c.screen.badgeTint,
        borderRadius: BorderRadius.circular(SmasherRadius.full),
      ),
      child: Text(
        label,
        style: SmasherText.badgeLabel.copyWith(color: ink ?? c.brandPressed),
      ),
    );
  }
}

/// Round initials avatar.
/// Figma: Avatar — r999, fill #EDE6FD, 1px #D8D4CC ring, initials 12/16 Inter
/// Semi Bold ls 2 in Brand/Pressed #6D28D9.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar(this.initials, {super.key, this.size = 48});

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: c.screen.statusTile,
        shape: BoxShape.circle,
        border: Border.all(color: c.screen.avatarBorder),
      ),
      child: Text(
        initials.toUpperCase(),
        style: SmasherText.avatarInitials.copyWith(color: c.brandPressed),
      ),
    );
  }
}

/// Tinted reassurance strip — icon + wrapping label, ink #4C3A82 on #F1ECFD.
///
/// Two sizes in the file:
///   default — r16, pad 14/16, gap 10, 18px glyph (Info Strip)
///   compact — r14, pad 12/14, gap 8,  16px glyph (the Helper under a field)
class InfoStrip extends StatelessWidget {
  const InfoStrip({
    super.key,
    required this.text,
    this.icon = SmasherIcons.lock,
    this.compact = false,
  });

  final String text;
  /// A constant from [SmasherIcons].
  final String icon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 14 : 16,
        vertical: compact ? 12 : 14,
      ),
      decoration: BoxDecoration(
        color: c.screen.stripTint,
        borderRadius: BorderRadius.circular(
          compact ? SmasherRadius.md : SmasherRadius.infoStrip,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmasherIcon(icon, size: compact ? 16 : 18, color: c.screen.stripInk),
          SizedBox(width: compact ? 8 : 10),
          Expanded(
            child: Text(
              text,
              style: SmasherText.bodySmall.copyWith(color: c.screen.stripInk),
            ),
          ),
        ],
      ),
    );
  }
}

/// The small reassurance line pinned under the body.
/// Figma: Footnote — h42, pad 8/24/16/24, gap 6, icon 14, label 13 #71717F.
class Footnote extends StatelessWidget {
  const Footnote(this.text, {super.key, this.icon = SmasherIcons.lock});

  final String text;
  /// A constant from [SmasherIcons].
  final String icon;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SmasherScreen.padding,
        8,
        SmasherScreen.padding,
        16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SmasherIcon(icon, size: 14, color: c.screen.mutedText),
          const SizedBox(width: 6),
          Text(
            text,
            style: SmasherText.bodySmall.copyWith(color: c.screen.mutedText),
          ),
        ],
      ),
    );
  }
}

/// 1px hairline used inside grouped lists (#F0F0F5).
class SmasherDivider extends StatelessWidget {
  const SmasherDivider({super.key, this.indent = 0});

  final double indent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.only(left: indent),
      color: context.palette.screen.hairline,
    );
  }
}
