import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import 'primitives.dart';

/// Onboarding & Entry (sections 01–11) — the file's original component set:
/// Header/Back (h56), Button (Primary / Secondary / Tertiary / Link, with
/// Disabled), Input, Input/OTP, Input/PIN, Keypad, Checkbox, Feedback/Inline.
/// Values are the component masters' own.

// ─── Tokens ──────────────────────────────────────────────────────────────────

abstract final class ObInk {
  static const page = Color(0xFFF7F7FA);
  static const surface = Color(0xFFFFFFFF);
  static const ink = Color(0xFF18181F);
  static const body = Color(0xFF52525E);
  static const muted = Color(0xFF6B6B78);
  static const brand = Color(0xFF7C3AED);
  static const brandLight = Color(0xFFA855F7);

  static const field = Color(0xFFF1F1F5);
  static const fieldBorder = Color(0xFFD2D2DB);
  static const disabledBorder = Color(0xFFE4E4EB);
  static const disabledInk = Color(0xFFA0A0AE);

  static const error = Color(0xFFDC2626);
  static const errorTint = Color(0xFFFCE9E9);
  static const warning = Color(0xFFD97706);
  static const warningTint = Color(0xFFFBF1E6);
  static const success = Color(0xFF16A34A);
  static const successTint = Color(0xFFE8F6ED);

  static const onDark = Color(0xFFF7F7FA);
  static const pinRing = Color(0xFFF1EEE8);
  static const pinError = Color(0xFFF87171);
}

abstract final class ObGradient {
  /// Splash / Hero / PIN card — #2E1065 → #6D28D9 (55%) → #A855F7.
  static const night = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2E1065), Color(0xFF6D28D9), Color(0xFFA855F7)],
    stops: [0, 0.55, 1],
  );

  /// Icon tiles, Face ID disc, success disc — #7C3AED → #A855F7.
  static const brand = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ObInk.brand, ObInk.brandLight],
  );
}

abstract final class ObShadow {
  /// Button/Primary and the brand discs — #7C3AED 28%, y6 b16.
  static const glow = [
    BoxShadow(color: Color(0x477C3AED), offset: Offset(0, 6), blurRadius: 16),
  ];

  /// Cards — #18181F 5%, y4 b12.
  static const card = [
    BoxShadow(color: Color(0x0D18181F), offset: Offset(0, 4), blurRadius: 12),
  ];
}

abstract final class ObText {
  static TextStyle _dm(double s, double lh, double ls) => GoogleFonts.dmSans(
        fontSize: s,
        height: lh / s,
        letterSpacing: ls,
        fontWeight: FontWeight.w600,
        color: ObInk.ink,
      );

  static TextStyle _in(double s, double lh, FontWeight w, [double ls = 0]) =>
      GoogleFonts.inter(
        fontSize: s,
        height: lh / s,
        letterSpacing: ls,
        fontWeight: w,
        color: ObInk.ink,
      );

  /// 36/44, ls -1.5%.
  static TextStyle get headline => _dm(36, 44, -0.54);

  /// 32/40, ls -1%.
  static TextStyle get headlineSmall => _dm(32, 40, -0.32);
  static TextStyle get heroTitle => _dm(24, 32, -0.24);
  static TextStyle get digit => _dm(20, 28, -0.1);
  static TextStyle get wordmark => _dm(32, 40, -0.64);
  static TextStyle get wordmarkSmall => _dm(20, 28, -0.4);

  static TextStyle get body => _in(15, 22, FontWeight.w400);
  static TextStyle get bodyStrong => _in(15, 22, FontWeight.w600);
  static TextStyle get button => _in(15, 20, FontWeight.w600);
  static TextStyle get label => _in(13, 18, FontWeight.w500);
  static TextStyle get small => _in(13, 18, FontWeight.w400);
  static TextStyle get badge => _in(11, 16, FontWeight.w500, 0.22);
}

// ─── Page ────────────────────────────────────────────────────────────────────

/// Onboarding frame: #F7F7FA, optional Header/Back (h56), Body pad 0/24/24/24
/// split into a Top column (gap [gap]) and a Bottom column pinned to the end.
class ObScaffold extends StatelessWidget {
  const ObScaffold({
    super.key,
    this.back = true,
    this.onBack,
    required this.top,
    this.bottom = const [],
    this.gap = 20,
    this.bottomGap = 12,
    this.centerTop = false,
  });

  final bool back;
  final VoidCallback? onBack;
  final List<Widget> top;
  final List<Widget> bottom;
  final double gap;
  final double bottomGap;

  /// Face ID / Account Ready: the content block sits centred between two
  /// flex spacers.
  final bool centerTop;

  @override
  Widget build(BuildContext context) {
    List<Widget> spaced(List<Widget> items, double g) => [
          for (var i = 0; i < items.length; i++) ...[
            items[i],
            if (i != items.length - 1) SizedBox(height: g),
          ],
        ];

    return Scaffold(
      backgroundColor: ObInk.page,
      body: SafeArea(
        child: Column(
          children: [
            if (back)
              SizedBox(
                height: 56,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: InkResponse(
                        radius: 22,
                        onTap:
                            onBack ?? () => Navigator.of(context).maybePop(),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: SmasherIcon(
                            SmasherIcons.arrowLeft,
                            size: 24,
                            color: ObInk.ink,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    sliver: SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (centerTop) const Spacer(),
                          ...spaced(top, gap),
                          const Spacer(),
                          if (bottom.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            ...spaced(bottom, bottomGap),
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
      ),
    );
  }
}

/// 32px violet screen glyph above a headline.
class ObScreenIcon extends StatelessWidget {
  const ObScreenIcon(this.icon, {super.key});

  final String icon;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: SmasherIcon(icon, size: 32, color: ObInk.brand),
      );
}

/// White r20 card, y4 b12 5% shadow. [outlined] adds the 1px #E4E4EB edge
/// and pad 16 the Login / Forgot / Reset cards use.
class ObCard extends StatelessWidget {
  const ObCard({
    super.key,
    required this.children,
    this.outlined = false,
    this.center = false,
  });

  final List<Widget> children;
  final bool outlined;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(outlined ? 16 : 20),
      decoration: BoxDecoration(
        color: ObInk.surface,
        borderRadius: BorderRadius.circular(20),
        border: outlined ? Border.all(color: ObInk.disabledBorder) : null,
        boxShadow: ObShadow.card,
      ),
      child: Column(
        crossAxisAlignment:
            center ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

// ─── Buttons ─────────────────────────────────────────────────────────────────

enum ObButtonKind { primary, secondary, tertiary, link }

/// Button — h52 (Link h44), r999, 15/20 Semi Bold.
/// Primary #7C3AED + glow; Secondary #F1F1F5 / #D2D2DB; Tertiary bare
/// #52525E; Link #7C3AED. [enabled] false gives the Disabled state
/// (#F1F1F5 / #E4E4EB / #A0A0AE) — still tappable through [onDisabledTap].
class ObButton extends StatelessWidget {
  const ObButton({
    super.key,
    required this.label,
    this.kind = ObButtonKind.primary,
    this.onPressed,
    this.enabled = true,
    this.onDisabledTap,
    this.leadingIcon,
    this.expand = true,
  });

  final String label;
  final ObButtonKind kind;
  final VoidCallback? onPressed;
  final bool enabled;
  final VoidCallback? onDisabledTap;
  final String? leadingIcon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final disabled =
        !enabled && kind != ObButtonKind.tertiary && kind != ObButtonKind.link;
    final (fill, border, ink, shadow) = disabled
        ? (ObInk.field, ObInk.disabledBorder, ObInk.disabledInk, null)
        : switch (kind) {
            ObButtonKind.primary => (
                ObInk.brand,
                null,
                Colors.white,
                ObShadow.glow,
              ),
            ObButtonKind.secondary => (
                ObInk.field,
                ObInk.fieldBorder,
                ObInk.ink,
                null,
              ),
            ObButtonKind.tertiary => (null, null, ObInk.body, null),
            ObButtonKind.link => (null, null, ObInk.brand, null),
          };

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          SmasherIcon(leadingIcon!, size: 20, color: ink),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: ObText.button.copyWith(color: ink),
          ),
        ),
      ],
    );

    return GestureDetector(
      onTap: disabled ? onDisabledTap : onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: expand ? double.infinity : null,
        height: kind == ObButtonKind.link ? 44 : 52,
        padding: EdgeInsets.symmetric(
          horizontal: kind == ObButtonKind.link ? 0 : 24,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(999),
          border: border == null ? null : Border.all(color: border),
          boxShadow: shadow,
        ),
        child: content,
      ),
    );
  }
}

// ─── Inputs ──────────────────────────────────────────────────────────────────

/// Input — label 13/18 Medium #52525E, gap 8, field h52 #F1F1F5 / #D2D2DB
/// r14 pad 16; value 15/22. Error swaps the outline and helper to #DC2626.
class ObInput extends StatefulWidget {
  const ObInput({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.password = false,
    this.error,
    this.helper,
    this.keyboardType,
    this.onChanged,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool password;
  final String? error;
  final String? helper;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  State<ObInput> createState() => _ObInputState();
}

class _ObInputState extends State<ObInput> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final error = widget.error != null;
    final helper = widget.error ?? widget.helper;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label, style: ObText.label.copyWith(color: ObInk.body)),
        const SizedBox(height: 8),
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: ObInk.field,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: error ? ObInk.error : ObInk.fieldBorder),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.password && _obscure,
                  obscuringCharacter: '•',
                  keyboardType: widget.keyboardType,
                  onChanged: widget.onChanged,
                  style: ObText.body,
                  cursorColor: ObInk.brand,
                  decoration: InputDecoration.collapsed(
                    hintText: widget.hint,
                    hintStyle: ObText.body.copyWith(color: ObInk.muted),
                  ),
                ),
              ),
              if (widget.password) ...[
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  child: const SmasherIcon(
                    SmasherIcons.eye,
                    size: 20,
                    color: ObInk.muted,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (helper != null && helper.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            helper,
            style: ObText.small.copyWith(
              color: error ? ObInk.error : ObInk.muted,
            ),
          ),
        ],
      ],
    );
  }
}

/// Input/OTP — six 48x56 r14 cells, gap 8. The next empty cell gets a 2px
/// #A0A0AE ring; error outlines every cell in #DC2626. Typing goes through a
/// hidden field so the platform keyboard and paste both work.
class ObOtpInput extends StatefulWidget {
  const ObOtpInput({
    super.key,
    required this.onChanged,
    this.error,
    this.initial = '',
  });

  final ValueChanged<String> onChanged;
  final String? error;
  final String initial;

  @override
  State<ObOtpInput> createState() => _ObOtpInputState();
}

class _ObOtpInputState extends State<ObOtpInput> {
  late final _controller = TextEditingController(text: widget.initial);
  final _focus = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final code = _controller.text;
    final error = widget.error != null;
    return GestureDetector(
      onTap: () => _focus.requestFocus(),
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 6; i++) ...[
                    Container(
                      width: 48,
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ObInk.field,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: error
                              ? ObInk.error
                              : i == code.length
                                  ? ObInk.disabledInk
                                  : ObInk.fieldBorder,
                          width: !error && i == code.length ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        i < code.length ? code[i] : '',
                        style: ObText.digit,
                      ),
                    ),
                    if (i != 5) const SizedBox(width: 8),
                  ],
                ],
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0,
                  child: TextField(
                    controller: _controller,
                    focusNode: _focus,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (v) {
                      setState(() {});
                      widget.onChanged(v);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.error ?? 'Enter the 6-digit code',
            textAlign: TextAlign.center,
            style: ObText.small.copyWith(
              color: error ? ObInk.error : ObInk.muted,
            ),
          ),
        ],
      ),
    );
  }
}

enum PinState { idle, error, disabled }

/// Input/PIN (Dark) — six 14px dots, gap 20. Empty: 1.5 #F1EEE8 ring;
/// filled #F7F7FA; error fills all six #F87171.
class ObPinDots extends StatelessWidget {
  const ObPinDots({
    super.key,
    required this.length,
    this.state = PinState.idle,
    this.helper,
  });

  final int length;
  final PinState state;
  final String? helper;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < 6; i++) ...[
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: state == PinState.error
                      ? ObInk.pinError
                      : state != PinState.disabled && i < length
                          ? ObInk.onDark
                          : null,
                  border: state == PinState.error ||
                          (state != PinState.disabled && i < length)
                      ? null
                      : Border.all(color: ObInk.pinRing, width: 1.5),
                ),
              ),
              if (i != 5) const SizedBox(width: 20),
            ],
          ],
        ),
        if (helper != null) ...[
          const SizedBox(height: 16),
          Text(
            helper!,
            textAlign: TextAlign.center,
            style: ObText.small.copyWith(color: ObInk.onDark),
          ),
        ],
      ],
    );
  }
}

/// The night-gradient card that holds the PIN dots.
class ObPinCard extends StatelessWidget {
  const ObPinCard({
    super.key,
    required this.child,
    this.tall = false,
    this.showLock = false,
  });

  final Widget child;

  /// Create PIN: 150 tall, r28, with the lock above the dots.
  final bool tall;
  final bool showLock;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: tall ? 150 : 104,
      decoration: BoxDecoration(
        gradient: ObGradient.night,
        borderRadius: BorderRadius.circular(tall ? 28 : 24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showLock) ...[
            const SmasherIcon(
              SmasherIcons.lock,
              size: 24,
              color: ObInk.onDark,
            ),
            const SizedBox(height: 14),
          ],
          child,
        ],
      ),
    );
  }
}

/// Keypad — 3x4 grid of 106x56 #F1F1F5 r14 keys, gap 12; DM Sans 20/28.
class ObKeypad extends StatelessWidget {
  const ObKeypad({
    super.key,
    required this.onDigit,
    required this.onDelete,
    this.enabled = true,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onDelete;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    Widget key(String d) => Expanded(
          child: GestureDetector(
            onTap: enabled ? () => onDigit(d) : null,
            child: Container(
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ObInk.field,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(d, style: ObText.digit),
            ),
          ),
        );

    Widget row(List<Widget> keys) => Row(
          children: [
            keys[0],
            const SizedBox(width: 12),
            keys[1],
            const SizedBox(width: 12),
            keys[2],
          ],
        );

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Column(
        children: [
          row([key('1'), key('2'), key('3')]),
          const SizedBox(height: 12),
          row([key('4'), key('5'), key('6')]),
          const SizedBox(height: 12),
          row([key('7'), key('8'), key('9')]),
          const SizedBox(height: 12),
          row([
            const Expanded(child: SizedBox(height: 56)),
            key('0'),
            Expanded(
              child: GestureDetector(
                onTap: enabled ? onDelete : null,
                behavior: HitTestBehavior.opaque,
                child: const SizedBox(
                  height: 56,
                  child: Center(
                    child: SmasherIcon(
                      SmasherIcons.delete,
                      size: 24,
                      color: ObInk.ink,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

enum CheckState { idle, selected, error }

/// Checkbox — 22px r6 box; idle 1.5 #D2D2DB, error 1.5 #DC2626, selected
/// #7C3AED with a 10x2 white bar. Label 15/22, gap 12.
class ObCheckbox extends StatelessWidget {
  const ObCheckbox({
    super.key,
    required this.label,
    required this.state,
    this.onTap,
  });

  final String label;
  final CheckState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final selected = state == CheckState.selected;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? ObInk.brand : null,
              borderRadius: BorderRadius.circular(6),
              border: selected
                  ? null
                  : Border.all(
                      color: state == CheckState.error
                          ? ObInk.error
                          : ObInk.fieldBorder,
                      width: 1.5,
                    ),
            ),
            child: selected
                ? Container(
                    width: 10,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: ObText.body)),
        ],
      ),
    );
  }
}

enum FeedbackKind { error, warning, success }

/// Feedback/Inline — r14, pad 12/16, gap 12, 24px glyph, 13/18 message.
class ObFeedback extends StatelessWidget {
  const ObFeedback(this.message, {super.key, this.kind = FeedbackKind.error});

  final String message;
  final FeedbackKind kind;

  @override
  Widget build(BuildContext context) {
    final (bg, ink, icon) = switch (kind) {
      FeedbackKind.error => (
          ObInk.errorTint,
          ObInk.error,
          SmasherIcons.alertCircle,
        ),
      FeedbackKind.warning => (
          ObInk.warningTint,
          ObInk.warning,
          SmasherIcons.alertTriangle,
        ),
      FeedbackKind.success => (
          ObInk.successTint,
          ObInk.success,
          SmasherIcons.checkCircle,
        ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmasherIcon(icon, size: 24, color: ink),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(message, style: ObText.small),
            ),
          ),
        ],
      ),
    );
  }
}

/// Round gradient disc with a white glyph (Face ID 80/34, success 104/44,
/// Forgot Password 80/34) and the brand glow.
class ObDisc extends StatelessWidget {
  const ObDisc({
    super.key,
    required this.icon,
    this.size = 80,
    this.iconSize = 34,
    this.color,
    this.ink = Colors.white,
    this.border,
  });

  final String icon;
  final double size;
  final double iconSize;

  /// Flat tint instead of the gradient (the warning / error variants).
  final Color? color;
  final Color ink;
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        gradient: color == null ? ObGradient.brand : null,
        border: border == null ? null : Border.all(color: border!),
        boxShadow: color == null ? ObShadow.glow : null,
      ),
      child: SmasherIcon(icon, size: iconSize, color: ink),
    );
  }
}

/// Logo — ring mark with an off-centre dot, then the wordmark.
class ObLogo extends StatelessWidget {
  const ObLogo({super.key, this.large = false});

  final bool large;

  @override
  Widget build(BuildContext context) {
    final s = large ? 40.0 : 24.0;
    final dot = large ? 18.0 : 11.0;
    final ring = large ? ObInk.onDark : ObInk.ink;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: s,
          height: s,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ring, width: large ? 2 : 1.5),
                ),
              ),
              Positioned(
                left: large ? 17 : 10,
                top: large ? 11 : 7,
                child: Container(
                  width: dot,
                  height: dot,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: large ? const Color(0xFFA78BFA) : ObInk.brand,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: large ? 12 : 8),
        Text(
          'Smasher',
          style: (large ? ObText.wordmark : ObText.wordmarkSmall)
              .copyWith(color: ring),
        ),
      ],
    );
  }
}
