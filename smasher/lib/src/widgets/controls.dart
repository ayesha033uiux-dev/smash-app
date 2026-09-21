import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'primitives.dart';

/// Primary action button.
///
/// Figma: Button — h52, r999, pad 0/24, label Button/Large. The three states,
/// all measured off the P02 artboards:
///   primary   — brand GRADIENT #8B5CF6 → #6D28D9 + Brand Glow, white label
///   secondary — white fill, #E6E6EE border, #18181F label ("Done")
///   ghost     — no fill, no border, #52525E label ("Skip for now")
///   disabled  — white fill, #E6E6EE border, #71717F label (P02 02 as drawn)
///
/// The primary fill is a gradient, not the flat brand token — every full-width
/// CTA in the file is drawn with it.
class SmasherButton extends StatelessWidget {
  const SmasherButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.expand = true,
    this.height = SmasherSize.controlHeightLg,
  });

  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  /// A constant from [SmasherIcons].
  final String? icon;
  final bool expand;

  /// 52 everywhere except inside a Method card, which draws 48.
  final double height;

  bool get _enabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;

    Color fill = Colors.transparent;
    late final Color ink;
    Color? border;
    Gradient? gradient;
    List<BoxShadow> shadow = const [];

    if (!_enabled) {
      fill = c.screen.disabledFill;
      ink = c.screen.mutedText;
      border = c.screen.disabledBorder;
    } else {
      switch (variant) {
        case ButtonVariant.primary:
          gradient = SmasherGradient.brand;
          ink = c.brandOnPrimary;
          shadow = SmasherShadow.brandGlow;
        case ButtonVariant.secondary:
          fill = c.surfaceDefault;
          ink = c.textPrimary;
          border = c.screen.disabledBorder;
        case ButtonVariant.ghost:
          ink = c.textSecondary;
      }
    }

    final child = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: SmasherText.buttonLarge.copyWith(color: ink)),
        if (icon != null) ...[
          const SizedBox(width: 8),
          SmasherIcon(icon!, size: 18, color: ink),
        ],
      ],
    );

    return AnimatedContainer(
      duration: SmasherMotion.fast,
      height: height,
      decoration: BoxDecoration(
        color: gradient == null ? fill : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(SmasherRadius.button),
        border: border == null ? null : Border.all(color: border),
        boxShadow: shadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(SmasherRadius.button),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            // widthFactor 1 lets a non-expanding button hug its label;
            // a bare Center would still grow to the full row.
            child: Center(widthFactor: expand ? null : 1, child: child),
          ),
        ),
      ),
    );
  }
}

enum ButtonVariant { primary, secondary, ghost }

/// Pill button filled with the brand gradient.
/// Figma: the "Plan a Moment" CTA inside empty states — h52, r999, pad 0/24.
/// Hugs its label rather than filling the row.
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  /// A constant from [SmasherIcons].
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    final enabled = onPressed != null;

    return Container(
      height: SmasherSize.controlHeightLg,
      decoration: BoxDecoration(
        gradient: enabled ? SmasherGradient.brand : null,
        color: enabled ? null : c.screen.disabledFill,
        borderRadius: BorderRadius.circular(SmasherRadius.button),
        border: enabled
            ? null
            : Border.all(color: c.screen.disabledBorder),
        boxShadow: enabled ? SmasherShadow.brandGlow : const [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(SmasherRadius.button),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: SmasherText.buttonLarge.copyWith(
                    color: enabled ? c.brandOnPrimary : c.screen.mutedText,
                  ),
                ),
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  SmasherIcon(
                    icon!,
                    size: 18,
                    color: enabled ? c.brandOnPrimary : c.screen.mutedText,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Label / Field / Helper, stacked with the 8px gap from P02 02.
/// Field: h52, r14, surface fill, 1px #E4E4EB border, 16px horizontal padding.
class SmasherInput extends StatelessWidget {
  const SmasherInput({
    super.key,
    required this.label,
    this.hint,
    this.helper,
    this.controller,
    this.errorText,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
  });

  final String label;
  final String? hint;
  final String? helper;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field Label is 13 Inter Medium, not Regular.
        Text(
          label,
          style: SmasherText.bodySmallMedium.copyWith(color: c.textSecondary),
        ),
        const SizedBox(height: 8),
        Container(
          height: SmasherSize.controlHeightLg,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: c.surfaceDefault,
            borderRadius: BorderRadius.circular(SmasherRadius.input),
            border: Border.all(
              color: hasError ? c.error : c.borderSubtle,
              width: SmasherSize.borderWidth,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            cursorColor: c.brandPrimary,
            style: SmasherText.bodyDefault.copyWith(color: c.textPrimary),
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              hintText: hint,
              hintStyle:
                  SmasherText.bodyDefault.copyWith(color: c.textTertiary),
            ),
          ),
        ),
        if (helper != null || hasError) ...[
          const SizedBox(height: 8),
          Text(
            errorText ?? helper!,
            style: SmasherText.bodySmall
                .copyWith(color: hasError ? c.error : c.textTertiary),
          ),
        ],
      ],
    );
  }
}

/// The segmented invite-code entry.
///
/// Figma: Code Field — h64, gap 10. A fixed prefix chip (93x64, r16, #F1ECFD,
/// pad h14, label DM Sans SemiBold 18/24 in #6D28D9), an en-dash in #C4C4CE,
/// then one 48x64 cell per digit at r16: white, 1px #E6E6EE, or 1.5px #7C3AED
/// while focused, with a 2x24 violet caret where the character will land.
class CodeField extends StatefulWidget {
  const CodeField({
    super.key,
    required this.prefix,
    this.length = 4,
    this.onChanged,
    this.onCompleted,
  });

  final String prefix;
  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<CodeField> createState() => _CodeFieldState();
}

class _CodeFieldState extends State<CodeField> {
  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _handle(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9A-Za-z]'), '').toUpperCase();
    final clipped = digits.length > widget.length
        ? digits.substring(0, widget.length)
        : digits;
    if (clipped != value) {
      _controller.value = TextEditingValue(
        text: clipped,
        selection: TextSelection.collapsed(offset: clipped.length),
      );
    }
    setState(() {});
    widget.onChanged?.call(clipped);
    if (clipped.length == widget.length) widget.onCompleted?.call(clipped);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    final text = _controller.text;

    return Stack(
      children: [
        // The real field is invisible and sits behind the cells; it owns the
        // keyboard, selection and paste handling so the cells stay dumb.
        Positioned.fill(
          child: Opacity(
            opacity: 0,
            child: TextField(
              controller: _controller,
              focusNode: _focus,
              showCursor: false,
              enableInteractiveSelection: false,
              keyboardType: TextInputType.visiblePassword,
              textCapitalization: TextCapitalization.characters,
              onChanged: _handle,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _focus.requestFocus(),
          child: Row(
            children: [
              Container(
                height: 64,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: c.screen.stripTint,
                  borderRadius:
                      BorderRadius.circular(SmasherRadius.infoStrip),
                ),
                child: Text(
                  widget.prefix,
                  style: SmasherText.codePrefix
                      .copyWith(color: c.brandPressed),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '–',
                style: SmasherText.bodyMedium.copyWith(
                  fontSize: 18,
                  color: c.screen.dashInk,
                ),
              ),
              const SizedBox(width: 10),
              for (var i = 0; i < widget.length; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                _CodeCell(
                  char: i < text.length ? text[i] : null,
                  focused: _focus.hasFocus && i == text.length,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _CodeCell extends StatelessWidget {
  const _CodeCell({required this.char, required this.focused});

  final String? char;
  final bool focused;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Expanded(
      child: Container(
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: c.surfaceDefault,
          borderRadius: BorderRadius.circular(SmasherRadius.infoStrip),
          border: Border.all(
            color: focused ? c.brandPrimary : c.screen.disabledBorder,
            width: focused ? 1.5 : 1,
          ),
        ),
        child: char != null
            ? Text(
                char!,
                style: SmasherText.codeDigit.copyWith(color: c.textPrimary),
              )
            : focused
                ? Container(
                    width: 2,
                    height: 24,
                    decoration: BoxDecoration(
                      color: c.brandPrimary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  )
                : const SizedBox.shrink(),
      ),
    );
  }
}

/// The action bar pinned to the bottom of task screens.
///
/// Figma: Bottom — pad 14/24/10/24, gap 6, 1px top hairline #EDEDF3 and a
/// TRANSPARENT fill, so the screen's wash shows through. h76 with one button,
/// h134 with two stacked.
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key, required this.children, this.solid = false});

  /// Convenience for the common single-button bar.
  BottomActionBar.single(Widget child, {super.key, this.solid = false})
      : children = [child];

  final List<Widget> children;

  /// White bar with the upward y-6 b18 s-8 5% shadow — the Circle Switcher's
  /// Bottom. Every other bar in the file is transparent over the page.
  final bool solid;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Container(
      padding: const EdgeInsets.fromLTRB(
        SmasherScreen.padding,
        14,
        SmasherScreen.padding,
        10,
      ),
      decoration: BoxDecoration(
        color: solid ? c.surfaceDefault : null,
        border: Border(top: BorderSide(color: c.screen.barHairline)),
        boxShadow: solid
            ? const [
                BoxShadow(
                  color: Color(0x0D171724),
                  offset: Offset(0, -6),
                  blurRadius: 18,
                  spreadRadius: -8,
                ),
              ]
            : null,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1) const SizedBox(height: 6),
            ],
          ],
        ),
      ),
    );
  }
}

/// 44x44 round outlined icon button — the notification bell on module homes.
/// Figma: r22, white fill, 1px #E8DEFC border, 20px icon, optional 9px dot.
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.showBadge = false,
  });

  /// A constant from [SmasherIcons].
  final String icon;
  final VoidCallback? onPressed;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return SizedBox(
      width: SmasherSize.touchMin,
      height: SmasherSize.touchMin,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Material(
            color: c.surfaceDefault,
            shape: CircleBorder(side: BorderSide(color: c.screen.pillBorder)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              child: Center(
                child: SmasherIcon(icon, size: 20, color: c.textPrimary),
              ),
            ),
          ),
          if (showBadge)
            Positioned(
              top: 8,
              right: 9,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: c.brandPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(color: c.surfaceDefault, width: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
