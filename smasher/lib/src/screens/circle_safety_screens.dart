import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app/routes.dart';
import '../theme/app_theme.dart';
import '../theme/together_tokens.dart';
import '../widgets/primitives.dart';
import '../widgets/together.dart';
import 'profile_screens.dart' show SettingsGroup, SmasherToggle;

/// P08 — Profile / Circle / Safety module (48 artboards).
///
/// Same flat dialect as P05–P07: #F9F9FB page, Header/Back h52 with a DM
/// Sans 17 title, Body pad 20/24, white r18 groups with #F0ECFC rules, flat
/// #7C3AED / #C4433D buttons.

// ─── Navigation ──────────────────────────────────────────────────────────────

void _go(BuildContext c, String r) => Navigator.of(c).pushNamed(r);
void _swap(BuildContext c, String r) =>
    Navigator.of(c).pushReplacementNamed(r);
void _pop(BuildContext c) => Navigator.of(c).maybePop();

/// Unwind to [route] if it is on the stack, otherwise to the first route.
void _unwindTo(BuildContext c, String route) => Navigator.of(c)
    .popUntil((r) => r.settings.name == route || r.isFirst);

void _toast(BuildContext c, String text) => ScaffoldMessenger.of(c)
    .showSnackBar(SnackBar(content: Text(text)));

// ─── Tokens / text ───────────────────────────────────────────────────────────

abstract final class _P {
  static const page = TogetherInk.pageAlt;
  static const chevron = Color(0xFFB0AFB8);
  static const muted = Color(0xFF8A8A96);
  static const choiceBorder = Color(0xFFDEDBE5);
  static const removedTile = Color(0xFFE8E5F0);
  static const star = Color(0xFFF7CE45);
  static const qrPaper = Color(0xFFF5F5F5);
}

TextStyle _dm(double size, [Color color = TogetherInk.ink]) =>
    GoogleFonts.dmSans(
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: color,
    );

TextStyle _in(
  double size, {
  FontWeight w = FontWeight.w400,
  Color color = TogetherInk.ink,
  double ls = 0,
}) =>
    GoogleFonts.inter(
      fontSize: size,
      fontWeight: w,
      color: color,
      letterSpacing: ls,
    );

Text _lead(String t) => Text(t, style: _in(14, color: TogetherInk.body));

Text _eyebrow(String t, {bool danger = false}) => Text(
      t,
      style: _in(
        11.5,
        w: FontWeight.w600,
        color: danger ? TogetherInk.danger : _P.muted,
        ls: 1.2,
      ),
    );

// ─── Demo state ──────────────────────────────────────────────────────────────

abstract final class DemoSafety {
  static bool sarahBlocked = false;
  static final Map<String, bool> activity = {
    "Show when I'm active": true,
    'Show last active time': true,
    'Read receipts': false,
  };
  static final Map<String, bool> messages = {
    'Read receipts': true,
    'Show typing status': true,
    'Message previews': false,
    'View-once media': true,
  };
  static final Map<String, bool> media = {
    'View-once media': true,
    'Allow media downloads': false,
    'Save received media': false,
    'Screenshot protection': true,
  };
}

// ─── Shared pieces ───────────────────────────────────────────────────────────

Widget _page({
  required String title,
  required List<Widget> children,
  List<Widget> bottom = const [],
  double gap = 20,
  bool white = false,
  EdgeInsets padding = const EdgeInsets.fromLTRB(24, 20, 24, 24),
}) {
  return TogetherScaffold(
    title: title,
    background: _P.page,
    bodyColor: white ? TogetherInk.surface : null,
    bottomSurface: true,
    padding: padding,
    gap: gap,
    bottom: bottom,
    children: children,
  );
}

/// Group row. With [icon] it leads with a 36 r12 tile; with [value] it ends
/// in a violet value; with [toggle] it ends in a switch.
class _R extends StatelessWidget {
  const _R(
    this.title, {
    this.icon,
    this.subtitle,
    this.value,
    this.toggle,
    this.onToggle,
    this.onTap,
    this.danger = false,
  });

  final String title;
  final String? icon;
  final String? subtitle;
  final String? value;
  final bool? toggle;
  final ValueChanged<bool>? onToggle;
  final VoidCallback? onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap ?? (toggle == null ? null : () => onToggle?.call(!toggle!)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            if (icon != null) ...[
              RoundTile(
                size: 36,
                radius: 12,
                icon: icon,
                iconSize: 17,
                color: danger ? TogetherInk.errorTint : TogetherInk.lilacTile,
                ink: danger ? TogetherInk.errorGlyph : TogetherInk.brand,
              ),
              const SizedBox(width: 14),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: _in(
                      14.5,
                      w: FontWeight.w600,
                      color: danger ? TogetherInk.danger : TogetherInk.ink,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: _in(12, color: TogetherInk.meta)),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (value != null) ...[
              Text(
                value!,
                style: _in(13, w: FontWeight.w600, color: TogetherInk.brand),
              ),
              const SizedBox(width: 12),
            ],
            if (toggle != null)
              SmasherToggle(value: toggle!, onChanged: onToggle)
            else
              SmasherIcon(
                SmasherIcons.chevronSmall,
                size: 14,
                color: danger ? TogetherInk.errorGlyph : _P.chevron,
              ),
          ],
        ),
      ),
    );
  }
}

/// Centred state artboard (no header unless [title] is set).
class _State extends StatelessWidget {
  const _State({
    required this.icon,
    required this.headline,
    this.body,
    this.title,
    this.tile = TogetherInk.lilacTile,
    this.ink = TogetherInk.brand,
    this.small = false,
    this.headlineSize = 24,
    this.top = 220,
    this.white = false,
    this.actions = const [],
  });

  final String icon;
  final String headline;
  final String? body;
  final String? title;
  final Color tile;
  final Color ink;

  /// 56px tile (r28) instead of 64.
  final bool small;
  final double headlineSize;
  final double top;
  final bool white;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      title: title,
      showHeader: title != null,
      background: white ? TogetherInk.surface : _P.page,
      padding: EdgeInsets.fromLTRB(24, title != null ? top - 52 : top, 24, 24),
      gap: 16,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundTile(
          size: small ? 56 : 64,
          icon: icon,
          iconSize: small ? 24 : 28,
          color: tile,
          ink: ink,
        ),
        Text(headline, textAlign: TextAlign.center, style: _dm(headlineSize)),
        if (body != null)
          Text(
            body!,
            textAlign: TextAlign.center,
            style: _in(headlineSize <= 19 ? 13.5 : 14, color: TogetherInk.body),
          ),
        ...actions,
      ],
    );
  }
}

/// Success artboard — #E0F6E5 tile, #1F9254 check.
Widget _success(String headline, String body, String cta, VoidCallback onTap,
        {double size = 24,}) =>
    _State(
      icon: SmasherIcons.successCheck,
      tile: TogetherInk.successTint,
      ink: const Color(0xFF1F9254),
      headline: headline,
      headlineSize: size,
      body: body,
      actions: [TogetherButton(label: cta, onPressed: onTap)],
    );

/// Header/Back confirmation: 56 tile, DM 22 headline, two stacked buttons.
class _Confirm extends StatelessWidget {
  const _Confirm({
    required this.title,
    required this.headline,
    required this.body,
    required this.confirm,
    required this.onConfirm,
    this.cancel = 'Cancel',
    this.icon = SmasherIcons.alertCircle,
    this.danger = true,
    this.top = 32,
    this.gap = 12,
    this.extra,
  });

  final String title;
  final String headline;
  final String body;
  final String confirm;
  final VoidCallback? onConfirm;
  final String cancel;
  final String icon;
  final bool danger;
  final double top;
  final double gap;
  final Widget? extra;

  @override
  Widget build(BuildContext context) {
    return _page(
      title: title,
      gap: gap,
      padding: EdgeInsets.fromLTRB(24, top, 24, 24),
      bottom: [
        TogetherButton(
          label: confirm,
          tone: danger ? TogetherButtonTone.danger : TogetherButtonTone.primary,
          onPressed: onConfirm,
        ),
        TogetherButton(
          label: cancel,
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        RoundTile(
          size: 56,
          icon: icon,
          iconSize: 24,
          color: danger ? TogetherInk.errorTint : TogetherInk.lilacTile,
          ink: danger ? TogetherInk.errorGlyph : TogetherInk.brand,
        ),
        if (gap < 20) const SizedBox(height: 4),
        Text(headline, style: _dm(22)),
        Text(body, style: _in(14, color: TogetherInk.body)),
        if (extra != null) extra!,
      ],
    );
  }
}

/// Radio choice card — selected #F6EFFE with a 1.5 violet stroke.
class _Choice extends StatelessWidget {
  const _Choice({
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.idleBorder = TogetherInk.cardBorder,
    this.titleSize = 14.5,
    this.radius = 16,
  });

  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;
  final Color idleBorder;
  final double titleSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: selected ? TogetherInk.selectTint : TogetherInk.surface,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: selected ? TogetherInk.brand : idleBorder,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: _in(titleSize, w: FontWeight.w600)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle!,
                      style: _in(12.5, color: TogetherInk.meta),
                    ),
                  ],
                ],
              ),
            ),
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

/// Label 13 SB over a white r16 field with a #F0ECFC (or error) outline.
class _Field extends StatefulWidget {
  const _Field({
    required this.label,
    required this.hint,
    this.initial,
    this.obscure = false,
    this.error,
    this.controller,
    this.readOnly = false,
    this.lines = 1,
    this.showLabel = true,
  });

  final String label;
  final String hint;
  final String? initial;
  final bool obscure;
  final String? error;
  final TextEditingController? controller;
  final bool readOnly;
  final int lines;
  final bool showLabel;

  @override
  State<_Field> createState() => _FieldState();
}

class _FieldState extends State<_Field> {
  late bool _hidden = widget.obscure;
  late final _ctrl =
      widget.controller ?? TextEditingController(text: widget.initial);

  @override
  void dispose() {
    if (widget.controller == null) _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final error = widget.error != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel) ...[
          Text(widget.label, style: _in(13, w: FontWeight.w600)),
          const SizedBox(height: 8),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: TogetherInk.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: error ? TogetherInk.danger : TogetherInk.cardBorder,
              width: error ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: widget.lines > 1
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  readOnly: widget.readOnly,
                  obscureText: _hidden,
                  minLines: widget.lines,
                  maxLines: widget.lines,
                  cursorColor: TogetherInk.brand,
                  style: _in(
                    14.5,
                    w: widget.readOnly ? FontWeight.w600 : FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: widget.hint,
                    hintStyle: _in(14.5, color: TogetherInk.placeholder),
                  ),
                ),
              ),
              if (widget.obscure) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => setState(() => _hidden = !_hidden),
                  child: const SmasherIcon(
                    SmasherIcons.eyeLine,
                    size: 16,
                    color: _P.chevron,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (error) ...[
          const SizedBox(height: 8),
          Text(widget.error!, style: _in(12, color: TogetherInk.danger)),
        ],
      ],
    );
  }
}

/// Member avatar — solid disc, DM Sans initial.
Widget _avatar(String letter, Color color) => Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text(letter, style: _dm(15, Colors.white)),
    );

/// Choice card with icon tile — Invite to circle.
class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard(this.icon, this.title, this.subtitle, this.onTap);

  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: TogetherInk.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D5C21B5),
              offset: Offset(0, 4),
              blurRadius: 14,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Row(
          children: [
            RoundTile(size: 46, radius: 14, icon: icon, iconSize: 21),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: _in(15, w: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: _in(12.5, color: TogetherInk.meta)),
                ],
              ),
            ),
            const SizedBox(width: 14),
            const SmasherIcon(
              SmasherIcons.chevronSmall,
              size: 14,
              color: _P.chevron,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── 01–05 — Circle ─────────────────────────────────────────────────────────

class CircleOverviewScreen extends StatelessWidget {
  const CircleOverviewScreen({super.key});

  static const _members = [
    ('Sarah', 'S', TogetherInk.brand, false),
    ('Alex', 'A', Color(0xFFD98C26), false),
    ('Ayesha', 'A', Color(0xFF1F9154), true),
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Your circle',
      bottom: [
        TogetherButton(
          label: 'Invite someone',
          onPressed: () => _go(context, Routes.inviteToCircle),
        ),
      ],
      children: [
        _lead('People you choose to connect with privately.'),
        _eyebrow('3 MEMBERS'),
        SettingsGroup(
          children: [
            for (final m in _members)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _go(
                  context,
                  m.$4 ? Routes.circleSettingsP08 : Routes.memberProfile,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      _avatar(m.$2, m.$3),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m.$1, style: _in(14.5, w: FontWeight.w600)),
                            const SizedBox(height: 2),
                            Text(
                              m.$4 ? 'You' : 'Connected',
                              style: _in(
                                12.5,
                                color: m.$4
                                    ? TogetherInk.brand
                                    : TogetherInk.meta,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!m.$4)
                        const SmasherIcon(
                          SmasherIcons.chevronSmall,
                          size: 14,
                          color: _P.chevron,
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class CircleEmptyScreen extends StatelessWidget {
  const CircleEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) => _State(
        title: 'Your circle',
        icon: SmasherIcons.users,
        headline: 'Your circle is waiting',
        headlineSize: 19,
        body: 'Invite someone you trust to start building your private circle.',
        top: 292,
        actions: [
          TogetherButton(
            label: 'Invite someone',
            onPressed: () => _go(context, Routes.inviteToCircle),
          ),
          TogetherButton(
            label: 'Back',
            tone: TogetherButtonTone.secondary,
            onPressed: () => _pop(context),
          ),
        ],
      );
}

class InviteToCircleScreen extends StatelessWidget {
  const InviteToCircleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Invite to circle',
      white: true,
      children: [
        _lead("Choose how you'd like to invite someone."),
        _ChoiceCard(
          SmasherIcons.share,
          'Share invite link',
          'Send a private link to invite someone.',
          () => _swap(context, Routes.inviteSent),
        ),
        _ChoiceCard(
          SmasherIcons.qrCode,
          'QR code',
          'Let someone scan a code to connect.',
          () => _go(context, Routes.qrInviteP08),
        ),
        _ChoiceCard(
          SmasherIcons.users,
          'From contacts',
          'Invite someone from your contacts.',
          () => _swap(context, Routes.inviteSent),
        ),
      ],
    );
  }
}

class QrInviteScreen extends StatelessWidget {
  const QrInviteScreen({super.key});

  /// Module positions on the 200px grid (col, row), in 1/12 steps.
  static const _cells = [
    (0, 0), (1, 0), (2, 0), (5, 0), (9, 0), (10, 0), (11, 0), //
    (0, 1), (1, 1), (2, 1), (6, 1), (9, 1), (10, 1), (11, 1), //
    (0, 2), (1, 2), (2, 2), (7, 2), (9, 2), (10, 2), (11, 2), //
    (3, 3), (8, 3), (4, 4), (9, 4), (0, 5), (5, 5), (10, 5), //
    (1, 6), (6, 6), (11, 6), (2, 7), (7, 7), (3, 8), (8, 8), //
    (0, 9), (1, 9), (2, 9), (4, 9), (9, 9), //
    (0, 10), (1, 10), (2, 10), (5, 10), (10, 10), //
    (0, 11), (1, 11), (2, 11), (6, 11), (11, 11), //
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'QR code',
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      bottom: [
        TogetherButton(
          label: 'Share code',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _toast(context, 'Share sheet not wired yet'),
        ),
      ],
      children: [
        Center(
          child: Container(
            width: 256,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: TogetherInk.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: TogetherShadow.soft,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    children: [
                      const Positioned.fill(
                        child: ColoredBox(color: _P.qrPaper),
                      ),
                      for (final c in _cells)
                        Positioned(
                          left: c.$1 * 200 / 12,
                          top: c.$2 * 200 / 12,
                          child: const SizedBox(
                            width: 15,
                            height: 15,
                            child: ColoredBox(color: TogetherInk.ink),
                          ),
                        ),
                      Positioned(
                        left: 78,
                        top: 78,
                        child: Container(
                          width: 44,
                          height: 44,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: TogetherInk.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: TogetherInk.cardBorder,
                              width: 2,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: TogetherInk.brand,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('A', style: _dm(15, Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text('Ayesha', style: _dm(16)),
              ],
            ),
          ),
        ),
        Text(
          'Scan this code to connect privately.',
          textAlign: TextAlign.center,
          style: _in(13, color: TogetherInk.body),
        ),
      ],
    );
  }
}

class InviteSentScreen extends StatelessWidget {
  const InviteSentScreen({super.key});

  @override
  Widget build(BuildContext context) => _State(
        icon: SmasherIcons.successCheck,
        tile: TogetherInk.successTint,
        ink: const Color(0xFF1F9254),
        headline: 'Invite sent',
        body: "They'll receive your invite to join your circle.",
        white: true,
        actions: [
          TogetherButton(
            label: 'Back to circle',
            onPressed: () => _unwindTo(context, Routes.circleOverview),
          ),
        ],
      );
}

// ─── 06–10 — Members ────────────────────────────────────────────────────────

class MemberProfileScreen extends StatelessWidget {
  const MemberProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Sarah',
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      children: [
        Column(
          children: [
            Container(
              width: 84,
              height: 84,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: TogetherGradient.deep,
              ),
              child: Text('S', style: _dm(32, Colors.white)),
            ),
            const SizedBox(height: 10),
            Text('Sarah', style: _dm(20)),
            const SizedBox(height: 10),
            Text(
              'Connected since June 2026',
              style: _in(13, color: TogetherInk.meta),
            ),
          ],
        ),
        SettingsGroup(
          children: [
            _R(
              'Message',
              icon: SmasherIcons.messageSquare,
              onTap: () => _go(context, Routes.conversation),
            ),
            _R(
              'Manage connection',
              icon: SmasherIcons.settings,
              onTap: () => _go(context, Routes.manageConnection),
            ),
            _R(
              'Boundaries with Sarah',
              icon: SmasherIcons.shield,
              onTap: () => _go(context, Routes.boundariesP08),
            ),
          ],
        ),
        SettingsGroup(
          border: TogetherInk.errorTint,
          children: [
            _R(
              'Block Sarah',
              icon: SmasherIcons.ban,
              danger: true,
              onTap: () => _go(context, Routes.blockPerson),
            ),
            _R(
              'Remove from circle',
              icon: SmasherIcons.logout,
              danger: true,
              onTap: () => _go(context, Routes.removeMember),
            ),
          ],
        ),
      ],
    );
  }
}

class ManageConnectionScreen extends StatefulWidget {
  const ManageConnectionScreen({super.key});

  @override
  State<ManageConnectionScreen> createState() => _ManageConnectionState();
}

class _ManageConnectionState extends State<ManageConnectionScreen> {
  bool _notify = true;

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Manage connection',
      children: [
        SettingsGroup(
          children: [
            _R(
              'Notifications',
              icon: SmasherIcons.bellSmall,
              toggle: _notify,
              onToggle: (v) => setState(() => _notify = v),
            ),
          ],
        ),
        SettingsGroup(
          children: [
            _R(
              'Pause conversation',
              icon: SmasherIcons.pause,
              onTap: () => _go(context, Routes.pauseConversation),
            ),
          ],
        ),
        _eyebrow('DANGER ZONE', danger: true),
        SettingsGroup(
          border: TogetherInk.errorTint,
          children: [
            _R(
              'Remove from circle',
              icon: SmasherIcons.logout,
              danger: true,
              onTap: () => _go(context, Routes.removeMember),
            ),
            _R(
              'Report',
              icon: SmasherIcons.alertTriangle,
              danger: true,
              onTap: () => _go(context, Routes.reportPerson),
            ),
            _R(
              'Block',
              icon: SmasherIcons.ban,
              danger: true,
              onTap: () => _go(context, Routes.blockPerson),
            ),
          ],
        ),
      ],
    );
  }
}

class RemoveMemberScreen extends StatelessWidget {
  const RemoveMemberScreen({super.key});

  @override
  Widget build(BuildContext context) => _Confirm(
        title: 'Remove member',
        icon: SmasherIcons.logout,
        headline: 'Remove Sarah from your circle?',
        body: 'You will no longer share private circle content with this '
            'person.',
        confirm: 'Remove from circle',
        cancel: 'Keep connection',
        onConfirm: () => _swap(context, Routes.memberRemoved),
      );
}

class MemberRemovedScreen extends StatelessWidget {
  const MemberRemovedScreen({super.key});

  @override
  Widget build(BuildContext context) => _State(
        icon: SmasherIcons.users,
        tile: _P.removedTile,
        ink: TogetherInk.body,
        headline: 'Sarah was removed from your circle.',
        headlineSize: 19,
        actions: [
          TogetherButton(
            label: 'Back to circle',
            onPressed: () => _unwindTo(context, Routes.circleOverview),
          ),
        ],
      );
}

class BlockedPeopleScreen extends StatefulWidget {
  const BlockedPeopleScreen({super.key});

  @override
  State<BlockedPeopleScreen> createState() => _BlockedPeopleState();
}

class _BlockedPeopleState extends State<BlockedPeopleScreen> {
  @override
  Widget build(BuildContext context) {
    if (!DemoSafety.sarahBlocked) {
      return const _State(
        title: 'Blocked people',
        icon: SmasherIcons.ban,
        headline: 'No blocked people',
        headlineSize: 19,
        body: 'People you block will no longer be able to message or interact '
            'with you.',
        top: 292,
      );
    }
    // Generated: the file only draws the empty list.
    return _page(
      title: 'Blocked people',
      children: [
        SettingsGroup(
          children: [
            _R(
              'Sarah',
              icon: SmasherIcons.ban,
              value: 'Unblock',
              onTap: () async {
                await Navigator.of(context).pushNamed(Routes.unblockPerson);
                if (mounted) setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }
}

// ─── 11–17 — Privacy & safety ───────────────────────────────────────────────

class PrivacySafetyScreen extends StatelessWidget {
  const PrivacySafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Privacy & safety',
      children: [
        _lead("You're in control of what you share and who can access it."),
        SettingsGroup(
          children: [
            _R(
              'Profile privacy',
              icon: SmasherIcons.eyeLine,
              subtitle: 'Who can see your profile.',
              onTap: () => _go(context, Routes.profilePrivacyP08),
            ),
            _R(
              'Activity visibility',
              icon: SmasherIcons.clock,
              subtitle: 'Online status and read receipts.',
              onTap: () => _go(context, Routes.activityPrivacy),
            ),
            _R(
              'Message privacy',
              icon: SmasherIcons.messageSquare,
              subtitle: 'Read receipts and previews.',
              onTap: () => _go(context, Routes.messagePrivacy),
            ),
            _R(
              'Media privacy',
              icon: SmasherIcons.image,
              subtitle: 'View-once and downloads.',
              onTap: () => _go(context, Routes.mediaPrivacyP08),
            ),
          ],
        ),
        SettingsGroup(
          children: [
            _R(
              'Blocked people',
              icon: SmasherIcons.ban,
              onTap: () => _go(context, Routes.blockedPeople),
            ),
            _R(
              'Safeword',
              icon: SmasherIcons.shield,
              subtitle: 'Pause an interaction instantly.',
              onTap: () => _go(context, Routes.safewordSettings),
            ),
            _R(
              'Pause settings',
              icon: SmasherIcons.pause,
              onTap: () => _go(context, Routes.pause),
            ),
          ],
        ),
      ],
    );
  }
}

class ProfilePrivacyScreen extends StatefulWidget {
  const ProfilePrivacyScreen({super.key});

  @override
  State<ProfilePrivacyScreen> createState() => _ProfilePrivacyState();
}

class _ProfilePrivacyState extends State<ProfilePrivacyScreen> {
  static const _levels = ['Everyone', 'Circle only', 'Private'];
  final _values = {
    'Profile photo': 'Circle only',
    'About': 'Circle only',
    'Activity': 'Private',
  };

  void _cycle(String k) => setState(() {
        final i = _levels.indexOf(_values[k]!);
        _values[k] = _levels[(i + 1) % _levels.length];
      });

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Profile privacy',
      children: [
        SettingsGroup(
          children: [
            _R(
              'Profile photo',
              subtitle: 'Who can see your profile photo.',
              value: _values['Profile photo'],
              onTap: () => _cycle('Profile photo'),
            ),
            _R(
              'About',
              value: _values['About'],
              onTap: () => _cycle('About'),
            ),
            _R(
              'Activity',
              value: _values['Activity'],
              onTap: () => _cycle('Activity'),
            ),
          ],
        ),
        TogetherButton(
          label: 'Save changes',
          onPressed: () {
            _toast(context, 'Profile privacy saved');
            _pop(context);
          },
        ),
      ],
    );
  }
}

/// Activity / Message / Media privacy — a lead line and a toggle group.
class TogglePrivacyScreen extends StatefulWidget {
  const TogglePrivacyScreen({
    super.key,
    required this.title,
    required this.lead,
    required this.values,
    this.subtitles = const {},
    this.footnote,
    this.white = false,
    this.links = const {},
  });

  final String title;
  final String lead;
  final Map<String, bool> values;
  final Map<String, String> subtitles;
  final String? footnote;
  final bool white;

  /// Rows whose label opens another screen (the switch still toggles).
  final Map<String, String> links;

  @override
  State<TogglePrivacyScreen> createState() => _TogglePrivacyState();
}

class _TogglePrivacyState extends State<TogglePrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    final v = widget.values;
    return _page(
      title: widget.title,
      white: widget.white,
      children: [
        _lead(widget.lead),
        SettingsGroup(
          children: [
            for (final k in v.keys)
              _R(
                k,
                subtitle: widget.subtitles[k],
                toggle: v[k],
                onToggle: (b) => setState(() => v[k] = b),
                onTap: widget.links[k] == null
                    ? null
                    : () => _go(context, widget.links[k]!),
              ),
          ],
        ),
        if (widget.footnote != null)
          Text(
            widget.footnote!,
            style: _in(12, color: TogetherInk.placeholder),
          ),
      ],
    );
  }
}

class ActiveSessionsP08Screen extends StatelessWidget {
  const ActiveSessionsP08Screen({super.key});

  Widget _device(
    BuildContext context,
    String icon,
    String name,
    String meta, {
    bool active = false,
  }) =>
      SettingsGroup(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                RoundTile(size: 36, radius: 12, icon: icon, iconSize: 17),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: _in(14.5, w: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(
                        meta,
                        style: _in(
                          12,
                          color: active
                              ? TogetherInk.success
                              : TogetherInk.meta,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!active)
                  GestureDetector(
                    onTap: () => _go(context, Routes.signOutDevice),
                    child: Text(
                      'Sign out',
                      style: _in(
                        13,
                        w: FontWeight.w600,
                        color: TogetherInk.danger,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Active sessions',
      children: [
        _lead('Review where your Smasher account is currently signed in.'),
        _eyebrow('THIS DEVICE'),
        _device(
          context,
          SmasherIcons.phone,
          'iPhone 15 Pro',
          'Active now',
          active: true,
        ),
        _eyebrow('OTHER DEVICES'),
        _device(context, SmasherIcons.monitor, 'Mac', '2 days ago'),
      ],
    );
  }
}

class SignOutDeviceScreen extends StatelessWidget {
  const SignOutDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) => _Confirm(
        title: 'Sign out device',
        icon: SmasherIcons.logout,
        headline: 'Sign out this device?',
        body: "You'll need to sign in again on this device.",
        confirm: 'Sign out',
        onConfirm: () {
          final messenger = ScaffoldMessenger.of(context);
          _pop(context);
          messenger.showSnackBar(
            const SnackBar(content: Text('Mac signed out')),
          );
        },
      );
}

// ─── 18–22 — Block, report ──────────────────────────────────────────────────

class BlockPersonScreen extends StatelessWidget {
  const BlockPersonScreen({super.key});

  @override
  Widget build(BuildContext context) => _Confirm(
        title: 'Block',
        icon: SmasherIcons.ban,
        headline: 'Block Sarah?',
        body: "Sarah won't be able to message you or interact with you "
            'through Smasher.',
        confirm: 'Block',
        onConfirm: () {
          DemoSafety.sarahBlocked = true;
          _swap(context, Routes.blockedPeople);
        },
      );
}

class UnblockPersonScreen extends StatelessWidget {
  const UnblockPersonScreen({super.key});

  @override
  Widget build(BuildContext context) => _Confirm(
        title: 'Unblock',
        icon: SmasherIcons.ban,
        headline: 'Unblock Sarah?',
        body: "Sarah will be able to interact with you again if you're still "
            'connected.',
        confirm: 'Unblock',
        danger: false,
        onConfirm: () {
          DemoSafety.sarahBlocked = false;
          _pop(context);
        },
      );
}

class ReportPersonScreen extends StatefulWidget {
  const ReportPersonScreen({super.key});

  @override
  State<ReportPersonScreen> createState() => _ReportPersonState();
}

class _ReportPersonState extends State<ReportPersonScreen> {
  static const _reasons = [
    'Unwanted content',
    'Harassment',
    'Safety concern',
    'Impersonation',
    'Something else',
  ];
  int _picked = 0;

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Report Sarah',
      bottom: [
        TogetherButton(
          label: 'Continue',
          onPressed: () => _go(context, Routes.reportDetails),
        ),
        TogetherButton(
          label: 'Cancel',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        _lead('Tell us what happened. Your report is private.'),
        Column(
          children: [
            for (var i = 0; i < _reasons.length; i++) ...[
              _Choice(
                title: _reasons[i],
                selected: i == _picked,
                onTap: () => setState(() => _picked = i),
              ),
              if (i != _reasons.length - 1) const SizedBox(height: 10),
            ],
          ],
        ),
      ],
    );
  }
}

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Tell us more',
      gap: 12,
      bottom: [
        TogetherButton(
          label: 'Submit report',
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.reportSubmitted,
            (r) => r.settings.name == Routes.memberProfile || r.isFirst,
          ),
        ),
        TogetherButton(
          label: 'Back',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        const _Field(
          label: 'Details',
          hint: 'Describe what happened…',
          lines: 5,
          showLabel: false,
        ),
        Text(
          "Please don't include passwords or other sensitive information.",
          style: _in(12, color: TogetherInk.placeholder),
        ),
      ],
    );
  }
}

class ReportSubmittedScreen extends StatelessWidget {
  const ReportSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) => _success(
        'Report submitted',
        "Thank you. We'll review your report and take appropriate action.",
        'Done',
        () => _pop(context),
      );
}

// ─── 23 — Boundaries ────────────────────────────────────────────────────────

class BoundariesP08Screen extends StatefulWidget {
  const BoundariesP08Screen({super.key});

  @override
  State<BoundariesP08Screen> createState() => _BoundariesP08State();
}

class _BoundariesP08State extends State<BoundariesP08Screen> {
  final _yes = {
    'Spontaneous plans': true,
    'Daily check-ins': true,
    'Video calls': false,
  };
  final _no = {'Surprise visits': true, 'Sharing location': false};
  bool _ask = true;

  Widget _chips(Map<String, bool> m) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final k in m.keys)
            GestureDetector(
              onTap: () => setState(() => m[k] = !m[k]!),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  color: m[k]! ? TogetherInk.lilacTile : TogetherInk.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: m[k]! ? TogetherInk.brand : _P.choiceBorder,
                    width: m[k]! ? 1.5 : 1.2,
                  ),
                ),
                child: Text(
                  k,
                  style: _in(
                    13,
                    w: FontWeight.w600,
                    color: m[k]! ? TogetherInk.brand : TogetherInk.body,
                  ),
                ),
              ),
            ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Boundaries',
      bottom: [
        TogetherButton(
          label: 'Save changes',
          onPressed: () {
            _toast(context, 'Boundaries saved');
            _pop(context);
          },
        ),
      ],
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _eyebrow('COMFORTABLE WITH'),
            const SizedBox(height: 10),
            _chips(_yes),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _eyebrow('NOT COMFORTABLE WITH'),
            const SizedBox(height: 10),
            _chips(_no),
          ],
        ),
        SettingsGroup(
          children: [
            _R(
              'Ask before sharing',
              subtitle: 'Your circle will ask before sharing things about you.',
              toggle: _ask,
              onToggle: (v) => setState(() => _ask = v),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── 24–28 — Email, password ────────────────────────────────────────────────

class ChangeEmailScreen extends StatelessWidget {
  const ChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Change email',
      bottom: [
        TogetherButton(
          label: 'Continue',
          onPressed: () => _go(context, Routes.verifyNewEmail),
        ),
      ],
      children: [
        const _Field(
          label: 'Current email',
          hint: '',
          initial: 'ayesha@email.com',
          readOnly: true,
        ),
        const _Field(label: 'New email', hint: 'Enter new email'),
        Text(
          "We'll send a verification code to your new email.",
          style: _in(12.5, color: TogetherInk.placeholder),
        ),
      ],
    );
  }
}

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmailScreen> {
  final _ctrl = TextEditingController(text: '34');
  final _focus = FocusNode();

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final code = _ctrl.text;
    return _page(
      title: 'Check your inbox',
      bottom: [
        TogetherButton(
          label: 'Verify email',
          onPressed: code.length == 6
              ? () => _swap(context, Routes.emailUpdated)
              : null,
        ),
      ],
      children: [
        _lead('We sent a 6-digit verification code to newemail@example.com'),
        GestureDetector(
          onTap: () => _focus.requestFocus(),
          child: Stack(
            children: [
              Row(
                children: [
                  for (var i = 0; i < 6; i++) ...[
                    Expanded(
                      child: Container(
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TogetherInk.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: i < code.length
                                ? TogetherInk.brand
                                : TogetherInk.cardBorder,
                            width: i < code.length ? 1.5 : 1,
                          ),
                        ),
                        child: Text(
                          i < code.length ? code[i] : '',
                          style: _dm(18),
                        ),
                      ),
                    ),
                    if (i != 5) const SizedBox(width: 10),
                  ],
                ],
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0,
                  child: TextField(
                    controller: _ctrl,
                    focusNode: _focus,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(counterText: ''),
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: () => _toast(context, 'Code resent'),
            child: Text(
              'Resend code',
              style: _in(13.5, w: FontWeight.w600, color: TogetherInk.brand),
            ),
          ),
        ),
      ],
    );
  }
}

class EmailUpdatedScreen extends StatelessWidget {
  const EmailUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) => _success(
        'Email updated',
        'Your new email address is now connected to your account.',
        'Done',
        () => _unwindTo(context, Routes.account),
      );
}

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, this.showError = false});

  /// Gallery: P08 27 draws the "incorrect" state.
  final bool showError;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordScreen> {
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();
  late bool _error = widget.showError;

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    final ok = _current.text.isNotEmpty &&
        _next.text.length >= 8 &&
        _next.text == _confirm.text;
    if (!ok) {
      setState(() => _error = _current.text.isEmpty);
      if (_current.text.isNotEmpty) {
        _toast(context, 'Check the new password rules.');
      }
      return;
    }
    _swap(context, Routes.passwordUpdatedP08);
  }

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Change password',
      white: true,
      gap: 18,
      bottom: [TogetherButton(label: 'Update password', onPressed: _submit)],
      children: [
        _Field(
          label: 'Current password',
          hint: 'Enter current password',
          obscure: true,
          controller: _current,
          error: _error ? 'Current password is incorrect.' : null,
        ),
        _Field(
          label: 'New password',
          hint: 'Enter new password',
          obscure: true,
          controller: _next,
        ),
        _Field(
          label: 'Confirm new password',
          hint: 'Re-enter new password',
          obscure: true,
          controller: _confirm,
        ),
        Text(
          'Use at least 8 characters, including a number and a symbol.',
          style: _in(12.5, color: TogetherInk.placeholder),
        ),
      ],
    );
  }
}

class PasswordUpdatedScreen2 extends StatelessWidget {
  const PasswordUpdatedScreen2({super.key});

  @override
  Widget build(BuildContext context) => _success(
        'Password updated',
        'Your password has been changed successfully.',
        'Done',
        () => _unwindTo(context, Routes.account),
      );
}

// ─── 29–32 — Notifications, safeword ────────────────────────────────────────

class NotificationPreviewScreen extends StatefulWidget {
  const NotificationPreviewScreen({super.key});

  @override
  State<NotificationPreviewScreen> createState() => _NotificationPreviewState();
}

class _NotificationPreviewState extends State<NotificationPreviewScreen> {
  static const _options = [
    ('Always show', 'Show sender and message content.'),
    ('When unlocked', 'Only show previews when your phone is unlocked.'),
    ('Never', 'Hide all message content in notifications.'),
  ];
  int _picked = 1;

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Notification previews',
      children: [
        _lead('Choose how much message content appears in notifications.'),
        for (var i = 0; i < _options.length; i++)
          _Choice(
            title: _options[i].$1,
            subtitle: _options[i].$2,
            selected: i == _picked,
            titleSize: 15,
            radius: 18,
            onTap: () => setState(() => _picked = i),
          ),
      ],
    );
  }
}

class SafewordSettingsScreen extends StatelessWidget {
  const SafewordSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Safeword',
      children: [
        _lead(
          'Your safeword can immediately pause an interaction when you need '
          'it.',
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: TogetherInk.successTint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: TogetherInk.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Safeword configured',
                  style: _in(
                    13,
                    w: FontWeight.w600,
                    color: TogetherInk.success,
                  ),
                ),
              ],
            ),
          ),
        ),
        SettingsGroup(
          children: [
            _R(
              'Change safeword',
              onTap: () => _go(context, Routes.setSafeword),
            ),
            _R(
              'Test pause',
              onTap: () => _go(context, Routes.pausedConversation),
            ),
            _R(
              'Turn off',
              danger: true,
              onTap: () {
                _toast(context, 'Safeword turned off');
                _pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class SetSafewordScreen extends StatefulWidget {
  const SetSafewordScreen({super.key});

  @override
  State<SetSafewordScreen> createState() => _SetSafewordState();
}

class _SetSafewordState extends State<SetSafewordScreen> {
  final _a = TextEditingController();
  final _b = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _a.dispose();
    _b.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Set your safeword',
      bottom: [
        TogetherButton(
          label: 'Save safeword',
          onPressed: () {
            if (_a.text.trim().isEmpty || _a.text != _b.text) {
              setState(() => _error = "Safewords don't match.");
              return;
            }
            _swap(context, Routes.safewordSaved);
          },
        ),
        TogetherButton(
          label: 'Cancel',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        _lead(
          'Choose a word that is easy for you to remember and unlikely to be '
          'used accidentally.',
        ),
        _Field(label: 'Enter safeword', hint: 'Enter safeword', controller: _a),
        _Field(
          label: 'Confirm safeword',
          hint: 'Confirm safeword',
          controller: _b,
          error: _error,
        ),
      ],
    );
  }
}

class SafewordSavedScreen extends StatelessWidget {
  const SafewordSavedScreen({super.key});

  @override
  Widget build(BuildContext context) => _success(
        'Safeword is ready',
        'You can use it anytime to pause an interaction.',
        'Done',
        () => _pop(context),
      );
}

// ─── 33–36 — Delete account ─────────────────────────────────────────────────

class DeleteAccountP08Screen extends StatelessWidget {
  const DeleteAccountP08Screen({super.key});

  @override
  Widget build(BuildContext context) => _Confirm(
        title: 'Delete account',
        icon: SmasherIcons.trash,
        headline: 'Delete your Smasher account?',
        body: 'Your account and associated data may be permanently removed. '
            'Some information may remain where required by law',
        confirm: 'Continue',
        cancel: 'Keep account',
        top: 28,
        gap: 20,
        onConfirm: () => _go(context, Routes.deleteReason),
      );
}

class DeleteReasonScreen extends StatefulWidget {
  const DeleteReasonScreen({super.key});

  @override
  State<DeleteReasonScreen> createState() => _DeleteReasonState();
}

class _DeleteReasonState extends State<DeleteReasonScreen> {
  static const _reasons = [
    "I don't use Smasher anymore",
    'Privacy concerns',
    'I had trouble using the app',
    "I'm taking a break",
    'Other',
  ];
  int _picked = 0;

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Before you go',
      bottom: [
        TogetherButton(
          label: 'Continue',
          onPressed: () => _go(context, Routes.deleteConfirmP08),
        ),
      ],
      children: [
        _lead('Why are you leaving? This is optional.'),
        for (var i = 0; i < _reasons.length; i++)
          _Choice(
            title: _reasons[i],
            selected: i == _picked,
            titleSize: 14,
            idleBorder: _P.choiceBorder,
            onTap: () => setState(() => _picked = i),
          ),
      ],
    );
  }
}

class DeleteConfirmP08Screen extends StatefulWidget {
  const DeleteConfirmP08Screen({super.key});

  @override
  State<DeleteConfirmP08Screen> createState() => _DeleteConfirmP08State();
}

class _DeleteConfirmP08State extends State<DeleteConfirmP08Screen> {
  bool _agreed = true;

  @override
  Widget build(BuildContext context) {
    return _Confirm(
      title: "This can't be undone",
      icon: SmasherIcons.trash,
      headline: "This can't be undone",
      body: "Deleting your account is permanent. Make sure you're ready before "
          'continuing.',
      confirm: 'Delete my account',
      cancel: 'Keep my account',
      top: 28,
      gap: 20,
      onConfirm: _agreed
          ? () => Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.deleteSuccessP08,
                (_) => false,
              )
          : null,
      extra: GestureDetector(
        onTap: () => setState(() => _agreed = !_agreed),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TogetherInk.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _P.choiceBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _agreed ? TogetherInk.brand : TogetherInk.surface,
                  borderRadius: BorderRadius.circular(6),
                  border: _agreed
                      ? null
                      : Border.all(color: TogetherInk.radioRing, width: 1.5),
                ),
                child: _agreed
                    ? const SmasherIcon(
                        SmasherIcons.tick,
                        size: 13,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'I understand that my account will be permanently deleted.',
                  style: _in(13.5, w: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteSuccessP08Screen extends StatelessWidget {
  const DeleteSuccessP08Screen({super.key});

  @override
  Widget build(BuildContext context) => _State(
        icon: SmasherIcons.trash,
        tile: _P.removedTile,
        ink: TogetherInk.body,
        headline: 'Your account has been deleted',
        headlineSize: 22,
        body: 'Thank you for using Smasher.',
        top: 240,
        actions: [
          TogetherButton(
            label: 'Close',
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.welcome, (_) => false),
          ),
        ],
      );
}

// ─── 37–40 — Session, errors, offline, unsaved ──────────────────────────────

class SessionExpiredScreen extends StatelessWidget {
  const SessionExpiredScreen({super.key});

  @override
  Widget build(BuildContext context) => _State(
        icon: SmasherIcons.clock,
        headline: 'Your session has expired',
        headlineSize: 20,
        body: 'For your security, please sign in again to continue.',
        top: 240,
        actions: [
          TogetherButton(
            label: 'Sign in',
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.login, (_) => false),
          ),
        ],
      );
}

class ProfileLoadErrorScreen extends StatelessWidget {
  const ProfileLoadErrorScreen({super.key});

  @override
  Widget build(BuildContext context) => _State(
        title: 'Profile',
        icon: SmasherIcons.alertCircle,
        tile: TogetherInk.errorTint,
        ink: TogetherInk.errorGlyph,
        small: true,
        headline: "Couldn't load your profile",
        headlineSize: 18,
        body: 'Check your connection and try again.',
        top: 292,
        actions: [
          TogetherButton(
            label: 'Try again',
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home,
              (_) => false,
              arguments: 4,
            ),
          ),
        ],
      );
}

class OfflineProfileScreen extends StatelessWidget {
  const OfflineProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Profile',
      gap: 16,
      children: [
        const OfflineBanner(
          message: "Some settings can't be changed right now.",
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: TogetherInk.surface,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: TogetherInk.lilacTile,
                  shape: BoxShape.circle,
                ),
                child: Text('A', style: _dm(24, TogetherInk.brand)),
              ),
              const SizedBox(height: 10),
              Text('Ayesha', style: _dm(16)),
            ],
          ),
        ),
      ],
    );
  }
}

class UnsavedChangesScreen extends StatelessWidget {
  const UnsavedChangesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      showHeader: false,
      background: _P.page,
      gap: 12,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      bottomSurface: true,
      bottom: [
        TogetherButton(
          label: 'Save changes',
          onPressed: () {
            _toast(context, 'Changes saved');
            _pop(context);
          },
        ),
        TogetherButton(
          label: 'Discard changes',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        const RoundTile(size: 56, icon: SmasherIcons.edit, iconSize: 24),
        const SizedBox(height: 4),
        Text('You have unsaved changes', style: _dm(21)),
        Text(
          "If you leave now, your changes won't be saved.",
          style: _in(14, color: TogetherInk.body),
        ),
      ],
    );
  }
}

// ─── 41 / 42 — Circle settings ──────────────────────────────────────────────

class CircleSettingsP08Screen extends StatelessWidget {
  const CircleSettingsP08Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Circle settings',
      gap: 22,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      bottom: [
        TogetherButton(
          label: 'Save changes',
          onPressed: () {
            _toast(context, 'Circle updated');
            _pop(context);
          },
        ),
      ],
      children: [
        Column(
          children: [
            const RoundTile(size: 80, icon: SmasherIcons.users, iconSize: 32),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _go(context, Routes.mediaPicker),
              child: Text(
                'Change photo',
                style: _in(
                  13.5,
                  w: FontWeight.w600,
                  color: TogetherInk.brand,
                ),
              ),
            ),
          ],
        ),
        const _Field(
          label: 'Circle name',
          hint: 'Circle name',
          initial: 'Our Circle',
        ),
        SettingsGroup(
          children: [
            _R(
              'Invitations',
              icon: SmasherIcons.mail,
              subtitle: 'Pending invites to this circle.',
              onTap: () => _go(context, Routes.invitations),
            ),
          ],
        ),
        _eyebrow('DANGER ZONE', danger: true),
        SettingsGroup(
          border: TogetherInk.errorTint,
          children: [
            _R(
              'Leave circle',
              danger: true,
              onTap: () => _go(context, Routes.leaveCircle),
            ),
          ],
        ),
      ],
    );
  }
}

class LeaveCircleScreen extends StatelessWidget {
  const LeaveCircleScreen({super.key});

  @override
  Widget build(BuildContext context) => _Confirm(
        title: 'Leave circle',
        icon: SmasherIcons.logout,
        headline: 'Leave this circle?',
        body: "You'll no longer see shared content from this circle, and "
            'members will no longer see yours.',
        confirm: 'Leave circle',
        cancel: 'Stay in circle',
        onConfirm: () => Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.circleEntry, (_) => false),
      );
}

// ─── 43–48 — Data, about, help ──────────────────────────────────────────────

class DataStorageScreen extends StatelessWidget {
  const DataStorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Data & storage',
      children: [
        _lead("Manage your data and how it's stored."),
        SettingsGroup(
          children: [
            _R(
              'Download your data',
              icon: SmasherIcons.download,
              subtitle: 'Get a copy of your Smasher data.',
              onTap: () => _go(context, Routes.downloadData),
            ),
            _R(
              'Storage usage',
              icon: SmasherIcons.layers,
              subtitle: '1.2 GB used',
              onTap: () => _toast(context, '1.2 GB of media and messages'),
            ),
          ],
        ),
      ],
    );
  }
}

class DownloadDataScreen extends StatelessWidget {
  const DownloadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Download your data',
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      bottom: [
        TogetherButton(
          label: 'Request download',
          onPressed: () => _swap(context, Routes.downloadRequested),
        ),
      ],
      children: [
        const RoundTile(size: 56, icon: SmasherIcons.download, iconSize: 24),
        Text('Get a copy of your data', style: _dm(21)),
        Text(
          "We'll prepare a file with your profile, messages, and account "
          'information. This may take a few days.',
          style: _in(14, color: TogetherInk.body),
        ),
      ],
    );
  }
}

class DownloadRequestedScreen extends StatelessWidget {
  const DownloadRequestedScreen({super.key});

  @override
  Widget build(BuildContext context) => _success(
        'Download requested',
        "We'll email you a link when your data is ready to download.",
        'Done',
        () => _pop(context),
        size: 22,
      );
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'About',
      gap: 24,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      children: [
        Center(
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: TogetherGradient.deep,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('S', style: _dm(28, Colors.white)),
              ),
              const SizedBox(height: 24),
              Text(
                'Version 2.4.1',
                style: _in(13.5, color: TogetherInk.meta),
              ),
            ],
          ),
        ),
        SettingsGroup(
          children: [
            _R(
              'Terms of Service',
              icon: SmasherIcons.note,
              onTap: () => _go(context, Routes.terms),
            ),
            _R(
              'Privacy Policy',
              icon: SmasherIcons.lock,
              onTap: () => _go(context, Routes.privacyPolicy),
            ),
            _R(
              'Licenses',
              icon: SmasherIcons.layers,
              onTap: () => showLicensePage(
                context: context,
                applicationName: 'Smasher',
                applicationVersion: '2.4.1',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Help & support',
      children: [
        _lead("We're here if you need anything."),
        SettingsGroup(
          children: [
            _R(
              'Help Center',
              icon: SmasherIcons.helpCircle,
              subtitle: 'Find answers to common questions.',
              onTap: () => _go(context, Routes.helpCenter),
            ),
            _R(
              'Contact us',
              icon: SmasherIcons.mail,
              subtitle: 'Reach out to our support team.',
              onTap: () => _go(context, Routes.contactUs),
            ),
            _R(
              'Rate Smasher',
              icon: SmasherIcons.star,
              onTap: () => _go(context, Routes.rateSmasher),
            ),
          ],
        ),
      ],
    );
  }
}

class RateSmasherScreen extends StatefulWidget {
  const RateSmasherScreen({super.key});

  @override
  State<RateSmasherScreen> createState() => _RateSmasherState();
}

class _RateSmasherState extends State<RateSmasherScreen> {
  int _stars = 5;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      showHeader: false,
      background: _P.page,
      gap: 20,
      padding: const EdgeInsets.fromLTRB(24, 220, 24, 24),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const RoundTile(size: 64, icon: SmasherIcons.star, iconSize: 28),
        Text('Enjoying Smasher?', style: _dm(22)),
        Text(
          'A quick rating helps other couples discover Smasher.',
          textAlign: TextAlign.center,
          style: _in(14, color: TogetherInk.body),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 1; i <= 5; i++) ...[
              GestureDetector(
                onTap: () => setState(() => _stars = i),
                child: SmasherIcon(
                  i <= _stars ? SmasherIcons.starFilled : SmasherIcons.star,
                  size: 32,
                  color: i <= _stars ? _P.star : _P.chevron,
                ),
              ),
              if (i != 5) const SizedBox(width: 8),
            ],
          ],
        ),
        TogetherButton(
          label: 'Rate on App Store',
          onPressed: () {
            _toast(context, 'Thanks for rating Smasher $_stars★');
            _pop(context);
          },
        ),
        GestureDetector(
          onTap: () => _pop(context),
          child: Text(
            'Not now',
            style: _in(
              14,
              w: FontWeight.w600,
              color: TogetherInk.placeholder,
            ),
          ),
        ),
      ],
    );
  }
}
