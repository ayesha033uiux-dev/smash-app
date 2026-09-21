import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/together_tokens.dart';
import 'primitives.dart';

/// Building blocks for the P03 Together module. Every value is taken from the
/// P03 artboards; see [TogetherInk] for the colours.

// ─── Page ────────────────────────────────────────────────────────────────────

/// P03 page: #F6F6F9, Header/Back with an optional DM Sans 17 nav title, a
/// scrolling Body and an optional pinned Bottom (pad 14/24, gap 10).
class TogetherScaffold extends StatelessWidget {
  const TogetherScaffold({
    super.key,
    this.title,
    this.showHeader = true,
    this.padding = const EdgeInsets.fromLTRB(24, 24, 24, 24),
    this.gap = 24,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.center = false,
    required this.children,
    this.bottom = const [],
    this.bottomSurface = false,
    this.background = TogetherInk.page,
    this.washed = false,
    this.titleSize = 17,
    this.bodyColor,
  });

  final String? title;
  final bool showHeader;
  final EdgeInsets padding;
  final double gap;
  final CrossAxisAlignment crossAxisAlignment;

  /// Centre the body vertically — the state screens.
  final bool center;
  final List<Widget> children;
  final List<Widget> bottom;

  /// White bar behind the bottom buttons (Daily Question); the rest sit
  /// straight on the page.
  final bool bottomSurface;
  final Color background;

  /// P04 frames: #EDE6FD fading into #F6F6F9 by 30% of the height.
  final bool washed;

  /// Nav title size — 17 in P03/P04, 18–19 in P05.
  final double titleSize;

  /// Fill behind the body only (P05's later artboards paint it white while
  /// the header keeps the wash).
  final Color? bodyColor;

  @override
  Widget build(BuildContext context) {
    final column = Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment:
          center ? MainAxisAlignment.center : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          children[i],
          if (i != children.length - 1) SizedBox(height: gap),
        ],
      ],
    );

    return Scaffold(
      backgroundColor: background,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: washed ? TogetherGradient.wash : null,
        ),
        child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            if (showHeader) _NavHeader(title: title, size: titleSize),
            Expanded(
              child: ColoredBox(
                color: bodyColor ?? Colors.transparent,
                child: LayoutBuilder(
                builder: (context, box) => SingleChildScrollView(
                  padding: padding,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: center
                          ? box.maxHeight - padding.vertical
                          : 0,
                      minWidth: double.infinity,
                    ),
                    child: column,
                  ),
                ),
              ),
              ),
            ),
            if (bottom.isNotEmpty)
              Container(
                width: double.infinity,
                color: bottomSurface ? TogetherInk.surface : null,
                padding: const EdgeInsets.fromLTRB(24, 14, 24, 14),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var i = 0; i < bottom.length; i++) ...[
                        bottom[i],
                        if (i != bottom.length - 1) const SizedBox(height: 10),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      ),
    );
  }
}

/// Header/Back (h52, pad 8/24) with the P03 nav title 12px after the arrow.
class _NavHeader extends StatelessWidget {
  const _NavHeader({this.title, this.size = 17});

  final String? title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Row(
          children: [
            InkResponse(
              onTap: () => Navigator.of(context).maybePop(),
              radius: 24,
              child: const SmasherIcon(
                SmasherIcons.arrowLeft,
                size: 24,
                color: TogetherInk.ink,
              ),
            ),
            if (title != null) ...[
              const SizedBox(width: 12),
              Text(
                title!,
                style: TogetherText.navTitle.copyWith(fontSize: size),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Eyebrow-less head: title over a 14px description at gap 6.
class TogetherHead extends StatelessWidget {
  const TogetherHead({
    super.key,
    required this.title,
    this.description,
    this.titleStyle,
    this.eyebrow,
    this.gap = 6,
  });

  final String title;
  final String? description;
  final TextStyle? titleStyle;
  final String? eyebrow;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (eyebrow != null) ...[
          Text(
            eyebrow!.toUpperCase(),
            style: TogetherText.eyebrow.copyWith(color: TogetherInk.brand),
          ),
          const SizedBox(height: 8),
        ],
        Text(title, style: titleStyle ?? TogetherText.pageTitle),
        if (description != null) ...[
          SizedBox(height: gap),
          Text(
            description!,
            style: TogetherText.body.copyWith(color: TogetherInk.body),
          ),
        ],
      ],
    );
  }
}

// ─── Buttons ─────────────────────────────────────────────────────────────────

enum TogetherButtonTone { primary, secondary, danger }

/// P03 button — h52, r999, 15 Semi Bold. Primary is flat #7C3AED (no glow),
/// secondary #F1F1F5 with a #D2D2DB hairline, danger #C4433D.
class TogetherButton extends StatelessWidget {
  const TogetherButton({
    super.key,
    required this.label,
    this.onPressed,
    this.tone = TogetherButtonTone.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final TogetherButtonTone tone;

  @override
  Widget build(BuildContext context) {
    if (onPressed == null && tone == TogetherButtonTone.primary) {
      // P04 11: #D9D4E0 fill, #9994A1 label.
      return Container(
        width: double.infinity,
        height: 52,
        alignment: Alignment.center,
        decoration: const ShapeDecoration(
          color: Color(0xFFD9D4E0),
          shape: StadiumBorder(),
        ),
        child: Text(
          label,
          style: TogetherText.button.copyWith(color: const Color(0xFF9994A1)),
        ),
      );
    }
    final (fill, ink, border) = switch (tone) {
      TogetherButtonTone.primary => (TogetherInk.brand, Colors.white, null),
      TogetherButtonTone.danger => (TogetherInk.danger, Colors.white, null),
      TogetherButtonTone.secondary => (
          TogetherInk.secondaryFill,
          TogetherInk.ink,
          TogetherInk.secondaryBorder,
        ),
    };
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: Material(
        color: fill,
        shape: StadiumBorder(
          side: border == null ? BorderSide.none : BorderSide(color: border),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onPressed,
          child: Center(
            child: Text(label, style: TogetherText.button.copyWith(color: ink)),
          ),
        ),
      ),
    );
  }
}

// ─── Selection ───────────────────────────────────────────────────────────────

/// Figma: Option Row — h56, r18, pad 18/20, gap 12. Selected: #F6EFFE fill,
/// 1.5 #7C3AED stroke, filled 20px disc. Idle: white, 1px #F0ECFC, 1.5
/// #D4D0E0 ring.
class OptionRow extends StatelessWidget {
  const OptionRow({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: SmasherMotion.fast,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: selected ? TogetherInk.selectTint : TogetherInk.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? TogetherInk.brand : TogetherInk.cardBorder,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label, style: TogetherText.option)),
            const SizedBox(width: 12),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? TogetherInk.brand : null,
                border: Border.all(
                  color: selected ? TogetherInk.brand : TogetherInk.radioRing,
                  width: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Figma: Pill (Propose Idea "when" grid) — h44, r16. Selected mirrors
/// [OptionRow]; label 13.5 Semi Bold, #7C3AED when selected.
class SelectPill extends StatelessWidget {
  const SelectPill({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: SmasherMotion.fast,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? TogetherInk.selectTint : TogetherInk.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? TogetherInk.brand : TogetherInk.cardBorder,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TogetherText.pill.copyWith(
            color: selected ? TogetherInk.brand : TogetherInk.ink,
          ),
        ),
      ),
    );
  }
}

/// Figma: Reaction/No | Maybe | Yes — h49, r18, 14 Semi Bold. Active uses
/// the selected treatment with a 1px stroke.
class ReactionButton extends StatelessWidget {
  const ReactionButton({
    super.key,
    required this.label,
    required this.active,
    this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: SmasherMotion.fast,
          height: 49,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? TogetherInk.selectTint : TogetherInk.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: active ? TogetherInk.brand : TogetherInk.cardBorder,
            ),
          ),
          child: Text(
            label,
            style: TogetherText.label.copyWith(
              color: active ? TogetherInk.brand : TogetherInk.body,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Cards ───────────────────────────────────────────────────────────────────

/// Figma: Idea Card — r28, three-stop violet gradient, pad 28/24 (26 on the
/// match detail), gap 14 (12). White eyebrow, 22 DM Sans title, 14 body at
/// 85%, optional 12 Semi Bold meta at 80%.
class IdeaCard extends StatelessWidget {
  const IdeaCard({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
    this.meta,
    this.compact = false,
  });

  final String eyebrow;
  final String title;
  final String description;
  final String? meta;

  /// Match Detail's tighter 26px padding and 12px gap.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final gap = SizedBox(height: compact ? 12 : 14);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: compact ? 26 : 28),
      decoration: BoxDecoration(
        gradient: TogetherGradient.ideaCard,
        borderRadius: BorderRadius.circular(28),
        boxShadow: TogetherShadow.ideaCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow.toUpperCase(),
            style: TogetherText.eyebrow.copyWith(color: Colors.white),
          ),
          gap,
          Text(
            title,
            style: TogetherText.cardTitleLarge.copyWith(color: Colors.white),
          ),
          gap,
          Text(
            description,
            style: TogetherText.body.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          if (meta != null) ...[
            gap,
            Text(
              meta!,
              style: TogetherText.small.copyWith(
                color: Colors.white.withValues(alpha: 0.80),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// White r20 card with a 1px #F0ECFC outline — status and summary cards.
class OutlineCard extends StatelessWidget {
  const OutlineCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.radius = 20,
    this.shadow,
    this.outlined = true,
  });

  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final List<BoxShadow>? shadow;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: TogetherInk.surface,
        borderRadius: BorderRadius.circular(radius),
        border: outlined ? Border.all(color: TogetherInk.cardBorder) : null,
        boxShadow: shadow,
      ),
      child: child,
    );
  }
}

enum StatusPillTone { waiting, confirmed, cancelled, completed }

/// Figma: Status Pill — r10, pad 6/10, gap 6, 6px dot, 12 Semi Bold.
/// Waiting: #FEEFE0 / #D98C26 / #99660D. Confirmed: #E0F6E5 / #1F9154.
class StatusPill extends StatelessWidget {
  const StatusPill(this.tone, {super.key, this.compact = false, this.label});

  final StatusPillTone tone;

  /// r9, pad 5/9, 11px label — the day card and Moment Created.
  final bool compact;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final (bg, dot, ink, label) = switch (tone) {
      StatusPillTone.waiting => (
          TogetherInk.waitTint,
          TogetherInk.waitDot,
          TogetherInk.waitInk,
          'Waiting for response',
        ),
      StatusPillTone.confirmed => (
          TogetherInk.successTint,
          TogetherInk.success,
          TogetherInk.success,
          'Confirmed',
        ),
      StatusPillTone.cancelled => (
          TogetherInk.errorTint,
          TogetherInk.danger,
          TogetherInk.danger,
          'Cancelled',
        ),
      StatusPillTone.completed => (
          TogetherInk.skeletonHome,
          TogetherInk.meta,
          TogetherInk.meta,
          'Completed',
        ),
    };
    return Container(
      padding: compact
          ? const EdgeInsets.symmetric(horizontal: 9, vertical: 5)
          : const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(compact ? 9 : 10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          SizedBox(width: compact ? 5 : 6),
          Text(
            this.label ?? label,
            style: (compact ? TogetherText.small.copyWith(fontSize: 11)
                    : TogetherText.small)
                .copyWith(color: ink),
          ),
        ],
      ),
    );
  }
}

/// The idea + time card on Proposal Sent / Accepted: 15 DM Sans title, 13
/// meta, status pill; pad 20, gap 10.
class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.title,
    required this.meta,
    required this.status,
  });

  final String title;
  final String meta;
  final StatusPillTone status;

  @override
  Widget build(BuildContext context) {
    return OutlineCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TogetherText.rowTitle),
          const SizedBox(height: 10),
          Text(meta, style: TogetherText.meta.copyWith(color: TogetherInk.body)),
          const SizedBox(height: 10),
          StatusPill(status),
        ],
      ),
    );
  }
}

// ─── Tiles & states ──────────────────────────────────────────────────────────

/// A round tile holding a glyph (or the ✦ character on the match screens).
class RoundTile extends StatelessWidget {
  const RoundTile({
    super.key,
    required this.size,
    this.icon,
    this.glyph,
    this.iconSize = 24,
    this.color = TogetherInk.lilacTile,
    this.gradient,
    this.ink = TogetherInk.brand,
    this.radius,
  });

  final double size;

  /// A constant from [SmasherIcons].
  final String? icon;

  /// A text glyph such as "✦", drawn at [iconSize].
  final String? glyph;
  final double iconSize;
  final Color color;
  final Gradient? gradient;
  final Color ink;

  /// Defaults to fully round; the empty-state rows use r14.
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: gradient == null ? color : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius ?? size / 2),
      ),
      child: icon != null
          ? SmasherIcon(icon!, size: iconSize, color: ink)
          : Text(
              glyph ?? '',
              style: TogetherText.label.copyWith(
                fontSize: iconSize,
                color: ink,
              ),
            ),
    );
  }
}

/// Centred state block — 56px round tile, 18 DM Sans title, 13.5 body, then
/// full-width buttons; gap 16 throughout (Idea Deck empty / error, Together
/// error).
class TogetherState extends StatelessWidget {
  const TogetherState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.error = false,
    this.actions = const [],
  });

  final String icon;
  final String title;
  final String description;
  final bool error;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      RoundTile(
        size: 56,
        icon: icon,
        color: error ? TogetherInk.errorTint : TogetherInk.lilacTile,
        ink: error ? TogetherInk.errorGlyph : TogetherInk.brand,
      ),
      Text(title, textAlign: TextAlign.center, style: TogetherText.stateTitle),
      Text(
        description,
        textAlign: TextAlign.center,
        style: TogetherText.bodySmall.copyWith(color: TogetherInk.body),
      ),
      ...actions,
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          children[i],
          if (i != children.length - 1) const SizedBox(height: 16),
        ],
      ],
    );
  }
}

/// Figma: Empty/… row — white r20 card, pad 18, gap 14; 44px #EDE6FD tile at
/// r14; 15 DM Sans title, 12.5 body #6B6B78 (gap 3) and an optional inline
/// violet CTA with a 12px chevron.
class EmptyRowCard extends StatelessWidget {
  const EmptyRowCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.ctaLabel,
    this.onCta,
  });

  final String icon;
  final String title;
  final String description;
  final String? ctaLabel;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    return OutlineCard(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          RoundTile(size: 44, icon: icon, iconSize: 20, radius: 14),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TogetherText.rowTitle),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: TogetherText.caption.copyWith(color: TogetherInk.meta),
                ),
                if (ctaLabel != null) ...[
                  const SizedBox(height: 3),
                  GestureDetector(
                    onTap: onCta,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ctaLabel!,
                          style: TogetherText.cta.copyWith(
                            color: TogetherInk.brand,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const SmasherIcon(
                          SmasherIcons.chevronSmall,
                          size: 12,
                          color: TogetherInk.brand,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Figma: Offline Banner — #18181F r14, pad 12/16, gap 10, wifi-off glyph,
/// 13 Semi Bold title over 11.5 #D9D9E0 copy.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({
    super.key,
    this.message = "Some actions may be unavailable until you're connected.",
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: TogetherInk.offline,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: Center(
              child: SmasherIcon(
                SmasherIcons.wifiOff,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You're offline",
                  style: TogetherText.fieldLabel.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: TogetherText.tiny.copyWith(
                    color: TogetherInk.offlineSub,
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

/// A flat skeleton block.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    this.width = double.infinity,
    required this.height,
    required this.radius,
    this.color = TogetherInk.skeleton,
  });

  final double width;
  final double height;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

// ─── Fields ──────────────────────────────────────────────────────────────────

/// Field label + white r16 row with an 18px violet glyph (Suggest Time).
class PickerField extends StatelessWidget {
  const PickerField({
    super.key,
    required this.label,
    this.icon,
    required this.value,
    this.onTap,
    this.placeholder = false,
    this.error = false,
    this.below,
  });

  final String label;
  final String? icon;
  final String value;
  final VoidCallback? onTap;

  /// Value is a #9999A8 Regular hint ("Add a location").
  final bool placeholder;

  /// 1.5 #C4433D outline (P04 11 time conflict).
  final bool error;

  /// Shown 8px under the row — the conflict warning.
  final Widget? below;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TogetherText.fieldLabel),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: TogetherInk.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: error ? TogetherInk.danger : TogetherInk.cardBorder,
                width: error ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  SmasherIcon(icon!, size: 18, color: TogetherInk.brand),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    value,
                    style: placeholder
                        ? TogetherText.fieldValue.copyWith(
                            fontWeight: FontWeight.w400,
                            color: TogetherInk.placeholder,
                          )
                        : TogetherText.fieldValue,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (below != null) ...[const SizedBox(height: 8), below!],
      ],
    );
  }
}

/// Figma: Note Field — white r16, 1px #F0ECFC, pad 16, 14 Regular with a
/// #9999A8 placeholder. Min height 72 (64 on Suggest Time).
class NoteField extends StatelessWidget {
  const NoteField({
    super.key,
    required this.hint,
    this.minHeight = 72,
    this.controller,
    this.labelAbove,
  });

  final String hint;
  final double minHeight;
  final TextEditingController? controller;

  /// "Note" label drawn 8px above (the P04 forms).
  final String? labelAbove;

  @override
  Widget build(BuildContext context) {
    if (labelAbove != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelAbove!, style: TogetherText.fieldLabel),
          const SizedBox(height: 8),
          NoteField(hint: hint, minHeight: minHeight, controller: controller),
        ],
      );
    }
    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TogetherInk.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TogetherInk.cardBorder),
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        style: TogetherText.body,
        cursorColor: TogetherInk.brand,
        decoration: InputDecoration.collapsed(
          hintText: hint,
          hintStyle: TogetherText.body.copyWith(
            color: TogetherInk.placeholder,
          ),
        ),
      ),
    );
  }
}
