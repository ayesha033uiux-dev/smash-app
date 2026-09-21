import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app/routes.dart';
import '../theme/app_theme.dart';
import '../theme/together_tokens.dart';
import '../widgets/primitives.dart';
import '../widgets/together.dart';
import 'extras_screens.dart' show DemoPermissions;
import 'profile_screens.dart' show SettingsGroup, SmasherToggle;

/// P07 — Messages module (28 artboards).
///
/// #F9F9FB page, DM Sans titles, white r18–r20 cards on the #5C21B5 soft
/// shadow, flat #7C3AED buttons. The conversation is one stateful screen;
/// each artboard (actions sheet, reply bar, recording, paused…) is a mode of
/// it so the gallery can open any of them directly.

// ─── Navigation ──────────────────────────────────────────────────────────────

void _go(BuildContext c, String r) => Navigator.of(c).pushNamed(r);
void _swap(BuildContext c, String r) =>
    Navigator.of(c).pushReplacementNamed(r);
void _pop(BuildContext c) => Navigator.of(c).maybePop();

void _toMessages(BuildContext c) => Navigator.of(c)
    .pushNamedAndRemoveUntil(Routes.home, (_) => false, arguments: 3);

// ─── Tokens ──────────────────────────────────────────────────────────────────

abstract final class _M {
  static const page = TogetherInk.pageAlt;
  static const hairline = Color(0xFFE4E4EB);
  static const muted = Color(0xFF8A8A96);
  static const chevron = Color(0xFFB0AFB8);
  static const record = Color(0xFFDB3D3D);
  static const ghost = Color(0xFF52525E);
  static const brandWash = Color(0x147C3AED); // 8%
  static const scrim = Color(0x590D0814); // #0D0814 @ 35%
  static const dark = Color(0xFF17141C);

  static const sarah = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFF4C1D95)],
  );
  static const circle = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFA9966), Color(0xFFD9598C)],
  );
  static const alex = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF66BF99), Color(0xFF33808C)],
  );
  static const media = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF0E5D9), Color(0xFFD1C2AD)],
  );

  static const groupShadow = [
    BoxShadow(
      color: Color(0x0D5C21B5),
      offset: Offset(0, 4),
      blurRadius: 14,
      spreadRadius: -2,
    ),
  ];
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

// ─── Demo data ───────────────────────────────────────────────────────────────

typedef ThreadInfo = ({
  String name,
  String initials,
  Gradient gradient,
  Color solid,
  String time,
  String preview,
  int unread,
});

abstract final class DemoThreads {
  static const List<ThreadInfo> all = [
    (
      name: 'Sarah',
      initials: 'S',
      gradient: _M.sarah,
      solid: TogetherInk.brand,
      time: '8:42 PM',
      preview: "Can't wait for tonight ❤️",
      unread: 2,
    ),
    (
      name: 'Our Circle',
      initials: 'OC',
      gradient: _M.circle,
      solid: Color(0xFFD98C26),
      time: 'Yesterday',
      preview: 'Movie night sounds perfect',
      unread: 0,
    ),
    (
      name: 'Alex',
      initials: 'A',
      gradient: _M.alex,
      solid: Color(0xFF1F9154),
      time: 'Mon',
      preview: 'Photo',
      unread: 0,
    ),
  ];
}

void _openThread(BuildContext c, ThreadInfo t) =>
    _go(c, t.name == 'Our Circle' ? Routes.circleChat : Routes.conversation);

// ─── Shared pieces ───────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.initials,
    this.gradient,
    this.color,
    this.size = 50,
    this.fontSize = 16,
    this.dm = false,
  });

  final String initials;
  final Gradient? gradient;
  final Color? color;
  final double size;
  final double fontSize;
  final bool dm;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        gradient: color == null ? gradient : null,
      ),
      child: Text(
        initials,
        style: dm
            ? _dm(fontSize, Colors.white)
            : _in(fontSize, w: FontWeight.w600, color: Colors.white),
      ),
    );
  }
}

/// Header/Back page on #F9F9FB.
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
    background: _M.page,
    bodyColor: white ? TogetherInk.surface : null,
    bottomSurface: true,
    padding: padding,
    gap: gap,
    bottom: bottom,
    children: children,
  );
}

/// Centred state — tile, DM title, body, actions.
class _State extends StatelessWidget {
  const _State({
    required this.icon,
    required this.title,
    required this.body,
    this.tile = TogetherInk.lilacTile,
    this.ink = TogetherInk.brand,
    this.tileRadius = 32,
    this.iconSize = 26,
    this.actions = const [],
  });

  static const double titleSize = 20;
  static const double bodySize = 13.5;
  static const double gap = 20;

  final String icon;
  final String title;
  final String body;
  final Color tile;
  final Color ink;
  final double tileRadius;
  final double iconSize;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      RoundTile(
        size: 64,
        radius: tileRadius,
        icon: icon,
        iconSize: iconSize,
        color: tile,
        ink: ink,
      ),
      Text(title, textAlign: TextAlign.center, style: _dm(titleSize)),
      Text(
        body,
        textAlign: TextAlign.center,
        style: _in(bodySize, color: TogetherInk.body),
      ),
      ...actions,
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          items[i],
          if (i != items.length - 1) const SizedBox(height: gap),
        ],
      ],
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton(this.label, this.onTap);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(shape: const StadiumBorder()),
        child: Text(
          label,
          style: TogetherText.button.copyWith(color: _M.ghost),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.icon, this.title, this.onTap, {this.danger = false});

  final String icon;
  final String title;
  final VoidCallback? onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final ink = danger ? TogetherInk.errorGlyph : TogetherInk.brand;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            RoundTile(
              size: 36,
              radius: 12,
              icon: icon,
              iconSize: 17,
              color: danger ? TogetherInk.errorTint : TogetherInk.lilacTile,
              ink: ink,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: _in(
                  14.5,
                  w: FontWeight.w600,
                  color: danger ? TogetherInk.danger : TogetherInk.ink,
                ),
              ),
            ),
            SmasherIcon(
              SmasherIcons.chevronSmall,
              size: 14,
              color: danger ? TogetherInk.errorGlyph : _M.chevron,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── 01 / 03 / 04 / 05 / 28 — Inbox ─────────────────────────────────────────

enum InboxState { active, empty, loading, error, offline }

/// Messages tab. Lives inside the app shell, so it draws no Scaffold.
class MessagesInbox extends StatelessWidget {
  const MessagesInbox({super.key, this.state = InboxState.active});

  final InboxState state;

  @override
  Widget build(BuildContext context) {
    final offline = state == InboxState.offline;
    final head = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: offline ? 9 : 6),
              Text('Messages', style: _dm(offline ? 28 : 32)),
              const SizedBox(height: 0),
              Text(
                'Private conversations with your circle.',
                style: _in(offline ? 13.5 : 14, color: TogetherInk.body),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => _go(context, Routes.newChat),
          child: Container(
            width: offline ? 40 : 44,
            height: offline ? 40 : 44,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: TogetherInk.brand,
              shape: BoxShape.circle,
            ),
            child: SmasherIcon(
              SmasherIcons.edit,
              size: offline ? 17 : 19,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => _go(context, Routes.messagesSearch),
          child: Container(
            width: offline ? 40 : 44,
            height: offline ? 40 : 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: offline ? TogetherInk.surface : const Color(0xEBFFFFFF),
              shape: BoxShape.circle,
            ),
            child: SmasherIcon(
              SmasherIcons.search,
              size: offline ? 18 : 20,
              color: TogetherInk.ink,
            ),
          ),
        ),
      ],
    );

    final List<Widget> body = switch (state) {
      InboxState.active => [
          const _PrivacyNote(),
          const SizedBox(height: 15),
          const _Eyebrow('RECENT'),
          const SizedBox(height: 12),
          for (final t in DemoThreads.all) ...[
            _ThreadCard(t, onTap: () => _openThread(context, t)),
            const SizedBox(height: 14),
          ],
        ],
      InboxState.loading => [
          const _PrivacyNote(),
          const SizedBox(height: 15),
          const _Eyebrow('RECENT'),
          const SizedBox(height: 12),
          for (var i = 0; i < 3; i++) ...[
            const _SkeletonCard(),
            const SizedBox(height: 14),
          ],
        ],
      InboxState.offline => [
          const SizedBox(height: 0),
          const OfflineBanner(
            message: "Messages will send when you're back online.",
          ),
          const SizedBox(height: 20),
          for (final t in DemoThreads.all.take(2)) ...[
            _CompactThread(t, onTap: () => _openThread(context, t)),
            const SizedBox(height: 8),
          ],
        ],
      InboxState.empty => [
          const SizedBox(height: 105),
          _State(
            icon: SmasherIcons.messages,
            tile: const Color(0x1A7C3AED),
            iconSize: 24,
            title: 'No conversations yet',
            body: 'When you connect with someone in your circle, your '
                'private conversations will appear here.',
            actions: [
              TogetherButton(
                label: 'View your circle',
                onPressed: () => _go(context, Routes.circleSwitcher),
              ),
              _GhostButton('Back', () => _toMessages(context)),
            ],
          ),
        ],
      InboxState.error => [
          const SizedBox(height: 105),
          _State(
            icon: SmasherIcons.alertCircle,
            tile: TogetherInk.errorTint,
            ink: TogetherInk.errorGlyph,
            tileRadius: 28,
            iconSize: 24,
            title: "Couldn't load your messages",
            body: 'Something went wrong. Check your connection and try again.',
            actions: [
              TogetherButton(
                label: 'Try again',
                onPressed: () => _toMessages(context),
              ),
              TogetherButton(
                label: 'Back',
                tone: TogetherButtonTone.secondary,
                onPressed: () => _pop(context),
              ),
            ],
          ),
        ],
    };

    return ColoredBox(
      color: _M.page,
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24, offline ? 9 : 14, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              head,
              SizedBox(height: offline ? 20 : 16),
              ...body,
            ],
          ),
        ),
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: _in(11.5, w: FontWeight.w600, color: _M.muted, ls: 1.2),
      );
}

/// #7C3AED@8 r14 note — lock, "Private conversations", sub-copy.
class _PrivacyNote extends StatelessWidget {
  const _PrivacyNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _M.brandWash,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const SmasherIcon(
            SmasherIcons.lockSmall,
            size: 16,
            color: TogetherInk.brand,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Private conversations',
                  style: _in(12.5, w: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  'Shared only with people in your circle.',
                  style: _in(11, color: TogetherInk.body),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 342x78 r20 thread card — 50px gradient avatar, name + time, preview and
/// an unread badge.
class _ThreadCard extends StatelessWidget {
  const _ThreadCard(this.t, {this.onTap});

  final ThreadInfo t;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final unread = t.unread > 0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: TogetherInk.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: TogetherShadow.soft,
        ),
        child: Row(
          children: [
            _Avatar(initials: t.initials, gradient: t.gradient),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          t.name,
                          style: _in(14.5, w: FontWeight.w600),
                        ),
                      ),
                      Text(t.time, style: _in(11.5, color: _M.muted)),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          t.preview,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: unread
                              ? _in(13, w: FontWeight.w600)
                              : _in(13, color: TogetherInk.body),
                        ),
                      ),
                      if (unread)
                        Container(
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: TogetherInk.brand,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${t.unread}',
                            style: _in(
                              10.5,
                              w: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
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

/// P07 28 — the offline artboard's flatter 66px row with a solid avatar.
class _CompactThread extends StatelessWidget {
  const _CompactThread(this.t, {this.onTap});

  final ThreadInfo t;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 11, 14, 11),
        decoration: BoxDecoration(
          color: TogetherInk.surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            _Avatar(
              initials: t.initials,
              color: t.solid,
              size: 44,
              dm: true,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          t.name,
                          style: _in(14.5, w: FontWeight.w600),
                        ),
                      ),
                      Text(
                        t.time,
                        style: _in(11.5, color: TogetherInk.placeholder),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t.preview,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _in(12.5, color: TogetherInk.meta),
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

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TogetherInk.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFE5E5EB),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonBox(
                width: 90,
                height: 12,
                radius: 6,
                color: Color(0xFFE5E5EB),
              ),
              SizedBox(height: 8),
              SkeletonBox(
                width: 180,
                height: 10,
                radius: 5,
                color: Color(0xFFEDEDF2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Inbox states as standalone routes (gallery / deep links).
class InboxStateScreen extends StatelessWidget {
  const InboxStateScreen(this.state, {super.key});

  final InboxState state;

  @override
  Widget build(BuildContext context) =>
      Scaffold(backgroundColor: _M.page, body: MessagesInbox(state: state));
}

// ─── 02 — Search ────────────────────────────────────────────────────────────

class MessagesSearchScreen extends StatefulWidget {
  const MessagesSearchScreen({super.key});

  @override
  State<MessagesSearchScreen> createState() => _MessagesSearchScreenState();
}

class _MessagesSearchScreenState extends State<MessagesSearchScreen> {
  String _q = '';

  // The artboard lists Sarah, Alex, Our Circle in that order.
  static final _order = [
    DemoThreads.all[0],
    DemoThreads.all[2],
    DemoThreads.all[1],
  ];

  @override
  Widget build(BuildContext context) {
    final q = _q.toLowerCase();
    final hits = _order.where(
      (t) =>
          t.name.toLowerCase().contains(q) ||
          t.preview.toLowerCase().contains(q),
    );
    return _page(
      title: 'Search messages',
      gap: 12,
      children: [
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: TogetherInk.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _M.hairline),
          ),
          child: Row(
            children: [
              const SmasherIcon(
                SmasherIcons.search,
                size: 16,
                color: TogetherInk.meta,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  autofocus: true,
                  onChanged: (v) => setState(() => _q = v),
                  style: _in(15),
                  cursorColor: TogetherInk.brand,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: 'Search conversations',
                    hintStyle: _in(15, color: TogetherInk.meta),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 0),
        for (final t in hits)
          GestureDetector(
            onTap: () => _openThread(context, t),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: TogetherInk.surface,
                borderRadius: BorderRadius.circular(18),
                boxShadow: TogetherShadow.soft,
              ),
              child: Row(
                children: [
                  _Avatar(
                    initials: t.initials,
                    gradient: t.gradient,
                    size: 42,
                    fontSize: 14,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.name, style: _in(14.5, w: FontWeight.w600)),
                        const SizedBox(height: 3),
                        Text(
                          t.preview,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: _in(13, color: TogetherInk.body),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// ─── 06–09, 14, 15, 17, 18, 23, 24 — Conversation ──────────────────────────

enum ChatMode {
  normal,
  actions,
  attach,
  reply,
  recording,
  voiceMessage,
  paused,
  storyReply,
  moment,

  /// Generated: an outgoing message that failed to send.
  failed,
}

enum _Kind { text, voice, media, viewOnce }

class _Msg {
  _Msg(
    this.text, {
    this.mine = false,
    this.time,
    this.kind = _Kind.text,
    this.sender,
    this.replyTo,
    this.failed = false,
  });

  final String text;
  final bool mine;
  String? time;
  final _Kind kind;
  final String? sender;
  final String? replyTo;

  /// Not delivered — the bubble offers "Tap to retry".
  bool failed;

  /// One reaction chip under the bubble.
  String? reaction;
}

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    super.key,
    this.mode = ChatMode.normal,
    this.circle = false,
  });

  final ChatMode mode;

  /// P07 18 — group thread with sender names and a stacked avatar.
  final bool circle;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

enum _Sheet { none, actions, attach }

class _ConversationScreenState extends State<ConversationScreen> {
  final _input = TextEditingController();
  late _Sheet _sheet = switch (widget.mode) {
    ChatMode.actions => _Sheet.actions,
    ChatMode.attach => _Sheet.attach,
    _ => _Sheet.none,
  };
  late String? _replyTo =
      widget.mode == ChatMode.reply ? "Can't wait for tonight." : null;
  late bool _paused = widget.mode == ChatMode.paused;
  late bool _recording = widget.mode == ChatMode.recording;
  int _seconds = 8;
  Timer? _timer;
  int? _selected;

  late final List<_Msg> _messages = widget.circle
      ? [
          _Msg('Movie night sounds good', sender: 'Zara'),
          _Msg("I'm in!", sender: 'Bilal'),
        ]
      : [
          if (widget.mode == ChatMode.voiceMessage)
            _Msg('0:08', kind: _Kind.voice)
          else
            _Msg('Hey, are you free tonight?', time: '8:34 PM'),
          _Msg("Yes, I'd love that.", mine: true, time: 'Read'),
          if (widget.mode == ChatMode.failed)
            _Msg('See you at 8?', mine: true, failed: true),
        ];
  bool _typing = false;

  @override
  void initState() {
    super.initState();
    if (_recording) _startTimer();
    _input.addListener(() => setState(() {}));
    if (widget.mode == ChatMode.actions) _selected = 1;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _input.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() => _seconds++),
    );
  }

  void _send() {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Msg(text, mine: true, time: 'Sent', replyTo: _replyTo));
      _replyTo = null;
      _input.clear();
    });
    if (widget.circle) return;
    // Demo: Sarah reads it, types, and answers.
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) setState(() => _typing = true);
    });
    Future.delayed(const Duration(milliseconds: 2300), () {
      if (!mounted) return;
      setState(() {
        _typing = false;
        _messages.last.time = 'Read';
        _messages.add(_Msg('❤️', time: 'Now'));
      });
    });
  }

  Future<bool> _ensure({required bool mic}) async {
    if (mic ? DemoPermissions.microphone : DemoPermissions.camera) return true;
    final ok = await Navigator.of(context).pushNamed(
      mic ? Routes.micPermission : Routes.cameraPermission,
    );
    return ok == true;
  }

  Future<void> _startRecording() async {
    setState(() => _sheet = _Sheet.none);
    if (!await _ensure(mic: true) || !mounted) return;
    setState(() {
      _recording = true;
      _seconds = 0;
    });
    _startTimer();
  }

  Future<void> _openCamera() async {
    setState(() => _sheet = _Sheet.none);
    if (!await _ensure(mic: false) || !mounted) return;
    await _pickMedia();
  }

  void _stopRecording({required bool send}) {
    _timer?.cancel();
    setState(() {
      if (send) {
        final t = '0:${_seconds.toString().padLeft(2, '0')}';
        _messages.add(_Msg(t, mine: true, kind: _Kind.voice, time: 'Sent'));
      }
      _recording = false;
      _seconds = 0;
    });
  }

  Future<void> _pickMedia() async {
    setState(() => _sheet = _Sheet.none);
    final viewOnce =
        await Navigator.of(context).pushNamed(Routes.messageMediaPicker);
    if (viewOnce is bool && mounted) {
      setState(() {
        _messages.add(
          _Msg(
            'Photo',
            mine: true,
            time: 'Sent',
            kind: viewOnce ? _Kind.viewOnce : _Kind.media,
          ),
        );
      });
    }
  }

  Future<void> _deleteSelected() async {
    final i = _selected;
    setState(() => _sheet = _Sheet.none);
    final ok = await Navigator.of(context).pushNamed(Routes.deleteMessage);
    if (ok == true && i != null && mounted) {
      setState(() {
        _messages.removeAt(i);
        _selected = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _M.page,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                _ChatHeader(circle: widget.circle),
                Expanded(child: _thread()),
                _composerArea(),
              ],
            ),
          ),
          if (_sheet != _Sheet.none) ..._sheetLayer(),
        ],
      ),
    );
  }

  Widget _thread() {
    final items = <Widget>[];
    if (widget.mode == ChatMode.storyReply) {
      items
        ..add(const _StoryReplyCard())
        ..add(const SizedBox(height: 20));
    }
    if (widget.mode == ChatMode.moment) {
      items
        ..add(const _MomentCard())
        ..add(const SizedBox(height: 20));
    }
    if (!widget.circle) {
      items
        ..add(
          Center(
            child: Text(
              'TODAY',
              style: _in(10.5, w: FontWeight.w600, color: _M.muted),
            ),
          ),
        )
        ..add(const SizedBox(height: 8));
    }
    for (var i = 0; i < _messages.length; i++) {
      items.add(
        _Bubble(
          _messages[i],
          highlighted: _selected == i && _sheet == _Sheet.actions,
          onLongPress: () => setState(() {
            _selected = i;
            _sheet = _Sheet.actions;
          }),
          onOpenMedia: () => _go(
            context,
            _messages[i].kind == _Kind.media
                ? Routes.photoViewer
                : Routes.viewOnce,
          ),
          onRetry: () => setState(() {
            _messages[i]
              ..failed = false
              ..time = 'Sent';
          }),
        ),
      );
      items.add(SizedBox(height: widget.circle ? 22 : 8));
    }
    if (_typing) items.add(const _TypingBubble());
    return ListView(
      padding: EdgeInsets.fromLTRB(24, widget.circle ? 16 : 20, 24, 16),
      children: items,
    );
  }

  Widget _composerArea() {
    if (_paused) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: _PausedPanel(
          onResume: () => setState(() => _paused = false),
          onSafeword: () => _go(context, Routes.safewordSend),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_replyTo != null) ...[
            _ReplyBar(
              quote: _replyTo!,
              onClose: () => setState(() => _replyTo = null),
            ),
            const SizedBox(height: 20),
          ],
          if (_recording) ...[
            Text('Recording…', style: _in(12, color: _M.record)),
            const SizedBox(height: 4),
          ],
          _recording ? _recorder() : _composer(),
        ],
      ),
    );
  }

  Widget _composer() {
    final canSend = _input.text.trim().isNotEmpty;
    return Container(
      height: 52,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: TogetherInk.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: _M.hairline),
      ),
      child: Row(
        children: [
          _Disc(
            fill: _M.brandWash,
            icon: SmasherIcons.plus,
            ink: TogetherInk.brand,
            iconSize: 18,
            onTap: () => setState(() => _sheet = _Sheet.attach),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _input,
              onSubmitted: (_) => _send(),
              style: _in(14.5),
              cursorColor: TogetherInk.brand,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: 'Write a message…',
                hintStyle: _in(14.5, color: TogetherInk.meta),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _startRecording,
            child: const SmasherIcon(
              SmasherIcons.mic,
              size: 20,
              color: TogetherInk.meta,
            ),
          ),
          const SizedBox(width: 10),
          _Disc(
            fill: canSend ? TogetherInk.brand : const Color(0x807C3AED),
            icon: SmasherIcons.sendSmall,
            ink: Colors.white,
            iconSize: 16,
            onTap: canSend ? _send : null,
          ),
        ],
      ),
    );
  }

  Widget _recorder() {
    const bars = [8.0, 14, 20, 12, 18, 10, 16, 9, 13, 7];
    final t = '0:${_seconds.toString().padLeft(2, '0')}';
    return Container(
      height: 52,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: TogetherInk.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: _M.hairline),
      ),
      child: Row(
        children: [
          _Disc(
            fill: const Color(0x1418181F),
            icon: SmasherIcons.trash,
            ink: TogetherInk.body,
            iconSize: 16,
            onTap: () => _stopRecording(send: false),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              children: [
                for (final h in bars) ...[
                  Container(
                    width: 3,
                    height: h.toDouble(),
                    decoration: BoxDecoration(
                      color: _M.record,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                  const SizedBox(width: 3),
                ],
              ],
            ),
          ),
          Text(t, style: _in(13, w: FontWeight.w600, color: _M.record)),
          const SizedBox(width: 10),
          _Disc(
            fill: _M.record,
            icon: SmasherIcons.stop,
            ink: Colors.white,
            iconSize: 14,
            onTap: () => _stopRecording(send: true),
          ),
        ],
      ),
    );
  }

  List<Widget> _sheetLayer() {
    final actions = _sheet == _Sheet.actions;
    final rows = actions
        ? <(String, String, VoidCallback, bool)>[
            (
              SmasherIcons.reply,
              'Reply',
              () => setState(() {
                    final m = _selected == null ? null : _messages[_selected!];
                    _replyTo = m?.text ?? "Can't wait for tonight.";
                    _sheet = _Sheet.none;
                  }),
              false,
            ),
            (
              SmasherIcons.smile,
              'React',
              () => setState(() {
                    if (_selected != null) {
                      final m = _messages[_selected!];
                      m.reaction = m.reaction == null ? '❤️' : null;
                    }
                    _sheet = _Sheet.none;
                  }),
              false,
            ),
            (
              SmasherIcons.copy,
              'Copy',
              () {
                final m = _selected == null ? null : _messages[_selected!];
                Clipboard.setData(ClipboardData(text: m?.text ?? ''));
                setState(() => _sheet = _Sheet.none);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied')),
                );
              },
              false,
            ),
            (
              SmasherIcons.alertTriangle,
              'Report',
              () {
                setState(() => _sheet = _Sheet.none);
                _go(context, Routes.reportPerson);
              },
              true,
            ),
            (SmasherIcons.trash, 'Delete', _deleteSelected, true),
          ]
        : <(String, String, VoidCallback, bool)>[
            (SmasherIcons.image, 'Photo', _pickMedia, false),
            (SmasherIcons.video, 'Video', _pickMedia, false),
            (SmasherIcons.cameraSmall, 'Camera', _openCamera, false),
            (SmasherIcons.mic, 'Voice', _startRecording, false),
          ];
    return [
      Positioned.fill(
        child: GestureDetector(
          onTap: () => setState(() => _sheet = _Sheet.none),
          child: const ColoredBox(color: _M.scrim),
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          padding: const EdgeInsets.only(top: 12),
          decoration: const BoxDecoration(
            color: TogetherInk.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0x2618181F),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                for (var i = 0; i < rows.length; i++) ...[
                  _SheetRow(
                    icon: rows[i].$1,
                    label: rows[i].$2,
                    onTap: rows[i].$3,
                    danger: rows[i].$4,
                  ),
                  if (i != rows.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        height: 1,
                        child: ColoredBox(color: TogetherInk.cardBorder),
                      ),
                    ),
                ],
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    ];
  }
}

class _SheetRow extends StatelessWidget {
  const _SheetRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              RoundTile(
                size: 36,
                radius: 12,
                icon: icon,
                iconSize: 20,
                color: danger ? TogetherInk.errorTint : TogetherInk.lilacTile,
                ink: danger ? TogetherInk.errorGlyph : TogetherInk.brand,
              ),
              const SizedBox(width: 14),
              Text(
                label,
                style: _in(
                  15,
                  color: danger ? TogetherInk.danger : TogetherInk.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Disc extends StatelessWidget {
  const _Disc({
    required this.fill,
    required this.icon,
    required this.ink,
    required this.iconSize,
    this.onTap,
  });

  final Color fill;
  final String icon;
  final Color ink;
  final double iconSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: fill, shape: BoxShape.circle),
        child: SmasherIcon(icon, size: iconSize, color: ink),
      ),
    );
  }
}

/// Back arrow, 38px avatar, DM 16 name over "Private conversation", and the
/// settings glyph. The circle variant stacks three 28px member dots.
class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.circle});

  final bool circle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => _pop(context),
              child: const SmasherIcon(
                SmasherIcons.arrowLeft,
                size: 24,
                color: TogetherInk.ink,
              ),
            ),
            const SizedBox(width: 12),
            if (circle)
              const SizedBox(
                width: 58,
                height: 28,
                child: Stack(
                  children: [
                    Positioned(left: 0, child: _Dot(TogetherInk.brand)),
                    Positioned(left: 15, child: _Dot(Color(0xFFD98C26))),
                    Positioned(left: 30, child: _Dot(Color(0xFF1F9154))),
                  ],
                ),
              )
            else
              const _Avatar(
                initials: 'S',
                gradient: _M.sarah,
                size: 38,
                fontSize: 14,
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: circle
                    ? [
                        Text('Our Circle', style: _in(15, w: FontWeight.w600)),
                        Text(
                          '3 members',
                          style: _in(12.5, color: TogetherInk.meta),
                        ),
                      ]
                    : [
                        Text('Sarah', style: _dm(16)),
                        Text(
                          'Private conversation',
                          style: _in(11.5, color: _M.muted),
                        ),
                      ],
              ),
            ),
            GestureDetector(
              onTap: () => _go(context, Routes.conversationSettings),
              child: const SmasherIcon(
                SmasherIcons.moreVertical,
                size: 18,
                color: TogetherInk.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.color);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}

/// Bubbles — incoming white with a #E4E4EB rule, outgoing #7C3AED, r18,
/// pad 10/14, 14.5 text; 10.5 meta under each.
class _Bubble extends StatelessWidget {
  const _Bubble(
    this.m, {
    this.highlighted = false,
    this.onLongPress,
    this.onOpenMedia,
    this.onRetry,
  });

  final _Msg m;
  final bool highlighted;
  final VoidCallback? onLongPress;
  final VoidCallback? onOpenMedia;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final mine = m.mine;
    final Widget content = switch (m.kind) {
      _Kind.voice => _VoiceContent(m.text, mine: mine),
      _Kind.media => GestureDetector(
          onTap: onOpenMedia,
          child: Container(
            width: 200,
            height: 240,
            decoration: BoxDecoration(
              gradient: _M.media,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      _Kind.viewOnce => GestureDetector(
          onTap: onOpenMedia,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SmasherIcon(
                SmasherIcons.eyeLine,
                size: 14,
                color: mine ? Colors.white : TogetherInk.brand,
              ),
              const SizedBox(width: 6),
              Text(
                'Photo · View once',
                style: _in(
                  14.5,
                  w: FontWeight.w600,
                  color: mine ? Colors.white : TogetherInk.ink,
                ),
              ),
            ],
          ),
        ),
      _Kind.text => Text(
          m.text,
          style: _in(
            m.sender != null ? 14 : 14.5,
            color: mine ? Colors.white : TogetherInk.ink,
          ),
        ),
    };

    final bubble = GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        constraints: BoxConstraints(maxWidth: m.sender != null ? 228 : 260),
        padding: m.kind == _Kind.media
            ? const EdgeInsets.all(4)
            : const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: mine ? TogetherInk.brand : TogetherInk.surface,
          borderRadius: BorderRadius.circular(18),
          border: highlighted
              ? Border.all(color: Colors.white, width: 2)
              : mine || m.sender != null
                  ? null
                  : Border.all(color: _M.hairline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (m.replyTo != null) ...[
              Text(
                m.replyTo!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: _in(12, color: const Color(0xCCFFFFFF)),
              ),
              const SizedBox(height: 4),
            ],
            content,
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment:
          mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (m.sender != null) ...[
          Text(
            m.sender!,
            style: _in(12, w: FontWeight.w600, color: TogetherInk.brand),
          ),
          const SizedBox(height: 3),
        ],
        Opacity(opacity: m.failed ? 0.6 : 1, child: bubble),
        if (m.reaction != null)
          Transform.translate(
            offset: const Offset(0, -6),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: TogetherInk.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _M.hairline),
              ),
              child: Text(m.reaction!, style: const TextStyle(fontSize: 12)),
            ),
          ),
        if (m.failed)
          GestureDetector(
            onTap: onRetry,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SmasherIcon(
                    SmasherIcons.alertCircle,
                    size: 12,
                    color: TogetherInk.danger,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Not sent · Tap to retry',
                    style: _in(
                      10.5,
                      w: FontWeight.w600,
                      color: TogetherInk.danger,
                    ),
                  ),
                ],
              ),
            ),
          )
        else if (m.time != null) ...[
          const SizedBox(height: 4),
          Text(m.time!, style: _in(10.5, color: _M.muted)),
        ],
      ],
    );
  }
}

/// Generated: three pulsing dots in an incoming bubble.
class _TypingBubble extends StatefulWidget {
  const _TypingBubble();

  @override
  State<_TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<_TypingBubble>
    with SingleTickerProviderStateMixin {
  late final _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: TogetherInk.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _M.hairline),
        ),
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < 3; i++) ...[
                Opacity(
                  opacity: 0.35 +
                      0.65 *
                          (1 - ((_c.value * 3 - i) % 3).clamp(0.0, 1.0)),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: _M.muted,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                if (i != 2) const SizedBox(width: 4),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// P07 15 — 32px play disc, 11 waveform bars at #7C3AED 40%, duration.
class _VoiceContent extends StatefulWidget {
  const _VoiceContent(this.duration, {required this.mine});

  final String duration;
  final bool mine;

  @override
  State<_VoiceContent> createState() => _VoiceContentState();
}

class _VoiceContentState extends State<_VoiceContent> {
  bool _playing = false;

  static const _bars = [6.0, 10, 14, 8, 16, 7, 12, 9, 13, 6, 10];

  @override
  Widget build(BuildContext context) {
    final mine = widget.mine;
    final barColor = mine ? const Color(0x99FFFFFF) : const Color(0x667C3AED);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => setState(() => _playing = !_playing),
          child: Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: mine ? Colors.white : TogetherInk.brand,
              shape: BoxShape.circle,
            ),
            child: SmasherIcon(
              _playing ? SmasherIcons.pause : SmasherIcons.play,
              size: 12,
              color: mine ? TogetherInk.brand : Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        for (final h in _bars) ...[
          Container(
            width: 2.5,
            height: h.toDouble(),
            decoration: BoxDecoration(
              color: barColor,
              borderRadius: BorderRadius.circular(1.25),
            ),
          ),
          const SizedBox(width: 2.5),
        ],
        const SizedBox(width: 7.5),
        Text(
          widget.duration,
          style: _in(12, color: mine ? const Color(0xCCFFFFFF) : _M.muted),
        ),
      ],
    );
  }
}

/// P07 08 — #7C3AED@6 r14 bar with a 3px rule and a close glyph.
class _ReplyBar extends StatelessWidget {
  const _ReplyBar({required this.quote, required this.onClose});

  final String quote;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0x0F7C3AED),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 28,
            decoration: BoxDecoration(
              color: TogetherInk.brand,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Replying to Sarah',
                  style: _in(12, w: FontWeight.w600, color: TogetherInk.brand),
                ),
                const SizedBox(height: 2),
                Text(
                  quote,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _in(12, color: TogetherInk.body),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onClose,
            child: const SmasherIcon(
              SmasherIcons.cross,
              size: 18,
              color: TogetherInk.body,
            ),
          ),
        ],
      ),
    );
  }
}

/// P07 17 — paused panel replacing the composer.
class _PausedPanel extends StatelessWidget {
  const _PausedPanel({required this.onResume, required this.onSafeword});

  final VoidCallback onResume;
  final VoidCallback onSafeword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: _M.brandWash,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '⏸ Conversation paused',
            style: _in(13.5, w: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            'Messages are paused for now.',
            style: _in(12, color: TogetherInk.body),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _SmallPill(
                  label: 'Resume',
                  filled: true,
                  onTap: onResume,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SmallPill(label: 'View safeword', onTap: onSafeword),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmallPill extends StatelessWidget {
  const _SmallPill({
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: filled ? TogetherInk.brand : null,
          shape: StadiumBorder(
            side: filled
                ? BorderSide.none
                : const BorderSide(color: Color(0xB3252525)),
          ),
        ),
        child: Text(
          label,
          style: TogetherText.button.copyWith(
            color: filled ? Colors.white : _M.ghost,
          ),
        ),
      ),
    );
  }
}

/// P07 23 — story reference card, 60px gradient strip.
class _StoryReplyCard extends StatelessWidget {
  const _StoryReplyCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _go(context, Routes.storyViewer),
      child: Container(
        height: 66,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: TogetherInk.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: _M.groupShadow,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 60,
              height: 66,
              child: DecoratedBox(
                decoration: BoxDecoration(gradient: _M.sarah),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Replying to Sarah's story",
                      style: _in(
                        11.5,
                        w: FontWeight.w600,
                        color: TogetherInk.brand,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text("Can't wait for tonight.", style: _in(13.5)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// P07 24 — moment reference card.
class _MomentCard extends StatelessWidget {
  const _MomentCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: TogetherInk.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: _M.groupShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const RoundTile(
                size: 36,
                radius: 12,
                icon: SmasherIcons.calendarPlain,
                iconSize: 17,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Movie night', style: _dm(15)),
                    const SizedBox(height: 2),
                    Text(
                      'Saturday · 8:00 PM',
                      style: _in(12.5, color: TogetherInk.meta),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Our Circle', style: _in(12.5, color: TogetherInk.meta)),
          const SizedBox(height: 8),
          Row(
            children: [
              const StatusPill(StatusPillTone.confirmed, compact: true),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _go(context, Routes.momentDetail),
                child: Text(
                  'View moment',
                  style: _in(
                    12.5,
                    w: FontWeight.w600,
                    color: TogetherInk.brand,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── 10 / 11 — Media ────────────────────────────────────────────────────────

class MessageMediaPickerScreen extends StatefulWidget {
  const MessageMediaPickerScreen({super.key});

  @override
  State<MessageMediaPickerScreen> createState() =>
      _MessageMediaPickerScreenState();
}

class _MessageMediaPickerScreenState extends State<MessageMediaPickerScreen> {
  int _tab = 0;
  int _picked = 0;

  static const _tiles = [
    Color(0xFFF0E5D9),
    Color(0xFFD9E0F0),
    Color(0xFFF0DBDB),
    Color(0xFFE0EBDE),
    Color(0xFFEBDEF0),
    Color(0xFFDEE5F0),
    Color(0xFFF0E8D1),
    Color(0xFFDBE3EB),
    Color(0xFFEDD9E0),
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Choose media',
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      gap: 18,
      bottom: [
        TogetherButton(
          label: 'Add media',
          onPressed: () async {
            final nav = Navigator.of(context);
            final result = await nav.pushNamed(Routes.messageMediaPreview);
            if (result is bool) nav.pop(result);
          },
        ),
      ],
      children: [
        Wrap(
          spacing: 8,
          children: [
            for (final (i, l) in const ['Recent', 'Favorites', 'Albums'].indexed)
              GestureDetector(
                onTap: () => setState(() => _tab = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: i == _tab ? TogetherInk.ink : TogetherInk.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: i == _tab
                        ? null
                        : Border.all(color: TogetherInk.cardBorder),
                  ),
                  child: Text(
                    l,
                    style: _in(
                      13,
                      w: FontWeight.w600,
                      color: i == _tab ? Colors.white : TogetherInk.body,
                    ),
                  ),
                ),
              ),
          ],
        ),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 7.5,
          crossAxisSpacing: 7.5,
          children: [
            for (var i = 0; i < _tiles.length; i++)
              GestureDetector(
                onTap: () => setState(() => _picked = i),
                child: Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _tiles[i],
                    borderRadius: BorderRadius.circular(14),
                    border: i == _picked
                        ? Border.all(color: TogetherInk.brand, width: 2.5)
                        : null,
                  ),
                  child: i == _picked
                      ? Container(
                          width: 22,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: TogetherInk.brand,
                            shape: BoxShape.circle,
                          ),
                          child: const SmasherIcon(
                            SmasherIcons.tick,
                            size: 12,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// P07 11 — pops `true` for view-once, `false` otherwise.
class MessageMediaPreviewScreen extends StatefulWidget {
  const MessageMediaPreviewScreen({super.key});

  @override
  State<MessageMediaPreviewScreen> createState() =>
      _MessageMediaPreviewScreenState();
}

class _MessageMediaPreviewScreenState extends State<MessageMediaPreviewScreen> {
  bool _viewOnce = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _M.page,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 49),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: _M.media,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Positioned(
                        top: 14,
                        left: 14,
                        child: GestureDetector(
                          onTap: () => _pop(context),
                          child: const SmasherIcon(
                            SmasherIcons.cross,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: TogetherInk.surface,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: TogetherInk.cardBorder),
                ),
                child: TextField(
                  style: _in(14),
                  cursorColor: TogetherInk.brand,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true,
                    hintText: "Can't wait for tonight.",
                    hintStyle: _in(14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: TogetherInk.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: TogetherInk.cardBorder),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SmasherIcon(
                                SmasherIcons.eyeLine,
                                size: 14,
                                color: TogetherInk.ink,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'View once',
                                style: _in(14, w: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                          Text(
                            'Can be opened once',
                            style: _in(10.5, color: TogetherInk.meta),
                          ),
                        ],
                      ),
                    ),
                    SmasherToggle(
                      value: _viewOnce,
                      onChanged: (v) => setState(() => _viewOnce = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TogetherButton(
                label: 'Send',
                onPressed: () => Navigator.of(context).pop(_viewOnce),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: TextButton(
                  onPressed: () => _pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFEDEDF0),
                    shape: const StadiumBorder(),
                  ),
                  child: Text('Cancel', style: TogetherText.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── 12 / 13 — View once ────────────────────────────────────────────────────

class ViewOnceScreen extends StatelessWidget {
  const ViewOnceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _M.dark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => _swap(context, Routes.viewOnceExpired),
                  child: const SizedBox(
                    height: 46,
                    child: Center(
                      child: SmasherIcon(
                        SmasherIcons.cross,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: _M.media,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 39),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SmasherIcon(
                    SmasherIcons.eyeLine,
                    size: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'View once',
                    style: _in(13, w: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewOnceExpiredScreen extends StatelessWidget {
  const ViewOnceExpiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      background: _M.page,
      padding: const EdgeInsets.fromLTRB(24, 201, 24, 24),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _State(
          icon: SmasherIcons.eyeLine,
          tileRadius: 28,
          iconSize: 24,
          title: 'This photo is no longer available',
          body: 'View-once media can only be opened once.',
          actions: [
            TogetherButton(
              label: 'Back to conversation',
              onPressed: () => _pop(context),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── 16 / 19 — Pause, settings ──────────────────────────────────────────────

class PauseConversationScreen extends StatelessWidget {
  const PauseConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      title: 'Pause conversation',
      background: _M.page,
      padding: const EdgeInsets.fromLTRB(24, 201, 24, 24),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _State(
          icon: SmasherIcons.pause,
          tileRadius: 28,
          iconSize: 24,
          title: 'Need a pause?',
          body: 'Pause this conversation when you need some space. Messages '
              'will be temporarily paused until you resume.',
          actions: [
            TogetherButton(
              label: 'Pause conversation',
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.pausedConversation,
                (r) => r.isFirst,
              ),
            ),
            _GhostButton('Not now', () => _pop(context)),
          ],
        ),
      ],
    );
  }
}

class ConversationSettingsScreen extends StatelessWidget {
  const ConversationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Conversation',
      white: true,
      children: [
        SettingsGroup(
          children: [
            _Row(
              SmasherIcons.bellSmall,
              'Notifications',
              () => _go(context, Routes.notificationSettings),
            ),
            _Row(
              SmasherIcons.image,
              'Media & files',
              () => _go(context, Routes.mediaPrivacy),
            ),
            _Row(
              SmasherIcons.lockSmall,
              'Privacy',
              () => _go(context, Routes.privacySettings),
            ),
          ],
        ),
        SettingsGroup(
          children: [
            _Row(
              SmasherIcons.pause,
              'Pause conversation',
              () => _go(context, Routes.pauseConversation),
            ),
            _Row(
              SmasherIcons.shield,
              'Safeword',
              () => _go(context, Routes.safewordSend),
            ),
          ],
        ),
        SettingsGroup(
          border: TogetherInk.errorTint,
          children: [
            _Row(
              SmasherIcons.eraser,
              'Clear conversation',
              () => _go(context, Routes.clearConversation),
              danger: true,
            ),
            _Row(
              SmasherIcons.alertTriangle,
              'Report conversation',
              () => _go(context, Routes.reportPerson),
              danger: true,
            ),
            _Row(
              SmasherIcons.logout,
              'Leave conversation',
              () => _go(context, Routes.leaveConversation),
              danger: true,
            ),
          ],
        ),
      ],
    );
  }
}

// ─── 20 / 21 / 22 — Safeword ────────────────────────────────────────────────

class SafewordSendScreen extends StatelessWidget {
  const SafewordSendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Safeword',
      white: true,
      gap: 12,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      bottom: [
        TogetherButton(
          label: 'Send safeword',
          onPressed: () => _swap(context, Routes.safewordSent),
        ),
      ],
      children: [
        const RoundTile(size: 56, icon: SmasherIcons.shield, iconSize: 24),
        const SizedBox(height: 4),
        Text('Safeword', style: _dm(24)),
        Text(
          'If you need to stop an interaction immediately, send your '
          'safeword.',
          style: _in(14, color: TogetherInk.body),
        ),
      ],
    );
  }
}

class _WhiteState extends StatelessWidget {
  const _WhiteState({
    required this.icon,
    required this.tile,
    required this.ink,
    required this.title,
    required this.titleSize,
    required this.body,
    required this.button,
    required this.onTap,
  });

  final String icon;
  final Color tile;
  final Color ink;
  final String title;
  final double titleSize;
  final String body;
  final String button;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      showHeader: false,
      background: TogetherInk.surface,
      padding: const EdgeInsets.fromLTRB(24, 220, 24, 24),
      gap: 16,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundTile(size: 64, icon: icon, iconSize: 28, color: tile, ink: ink),
        Text(title, textAlign: TextAlign.center, style: _dm(titleSize)),
        Text(
          body,
          textAlign: TextAlign.center,
          style: _in(14, color: TogetherInk.body),
        ),
        TogetherButton(label: button, onPressed: onTap),
      ],
    );
  }
}

class SafewordSentScreen extends StatelessWidget {
  const SafewordSentScreen({super.key});

  @override
  Widget build(BuildContext context) => _WhiteState(
        icon: SmasherIcons.successCheck,
        tile: TogetherInk.successTint,
        ink: const Color(0xFF1F9254),
        title: 'Safeword sent',
        titleSize: 24,
        body: 'The conversation has been paused.',
        button: 'Back to conversation',
        onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.pausedConversation,
          (r) => r.isFirst,
        ),
      );
}

class SafewordReceivedScreen extends StatelessWidget {
  const SafewordReceivedScreen({super.key});

  @override
  Widget build(BuildContext context) => _WhiteState(
        icon: SmasherIcons.shield,
        tile: TogetherInk.lilacTile,
        ink: TogetherInk.brand,
        title: 'Conversation paused',
        titleSize: 22,
        body: 'A safeword was used.',
        button: 'Acknowledge',
        onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.pausedConversation,
          (r) => r.isFirst,
        ),
      );
}

// ─── 25 / 26 / 27 — Confirmations ───────────────────────────────────────────

class _Confirm extends StatelessWidget {
  const _Confirm({
    required this.navTitle,
    required this.icon,
    required this.title,
    required this.body,
    required this.confirm,
    required this.keep,
    required this.onConfirm,
  });

  final String navTitle;
  final String icon;
  final String title;
  final String body;
  final String confirm;
  final String keep;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      title: navTitle,
      background: _M.page,
      gap: 12,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      bottom: [
        TogetherButton(
          label: confirm,
          tone: TogetherButtonTone.danger,
          onPressed: onConfirm,
        ),
        TogetherButton(
          label: keep,
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        RoundTile(
          size: 56,
          icon: icon,
          iconSize: 24,
          color: TogetherInk.errorTint,
          ink: TogetherInk.errorGlyph,
        ),
        const SizedBox(height: 4),
        Text(title, style: _dm(22)),
        Text(body, style: _in(14, color: TogetherInk.body)),
      ],
    );
  }
}

class DeleteMessageScreen extends StatelessWidget {
  const DeleteMessageScreen({super.key});

  @override
  Widget build(BuildContext context) => _Confirm(
        navTitle: 'Delete message',
        icon: SmasherIcons.trash,
        title: 'Delete this message?',
        body: 'This message will be removed from your conversation.',
        confirm: 'Delete message',
        keep: 'Keep message',
        onConfirm: () => Navigator.of(context).pop(true),
      );
}

class ClearConversationScreen extends StatelessWidget {
  const ClearConversationScreen({super.key});

  @override
  Widget build(BuildContext context) => _Confirm(
        navTitle: 'Clear conversation',
        icon: SmasherIcons.eraser,
        title: 'Clear conversation?',
        body: 'Messages will be removed from your view.',
        confirm: 'Clear conversation',
        keep: 'Keep messages',
        onConfirm: () {
          final messenger = ScaffoldMessenger.of(context);
          _toMessages(context);
          messenger.showSnackBar(
            const SnackBar(content: Text('Conversation cleared')),
          );
        },
      );
}

class LeaveConversationScreen extends StatelessWidget {
  const LeaveConversationScreen({super.key});

  @override
  Widget build(BuildContext context) => _Confirm(
        navTitle: 'Leave conversation',
        icon: SmasherIcons.logout,
        title: 'Leave this conversation?',
        body: 'You will no longer receive messages from this conversation.',
        confirm: 'Leave conversation',
        keep: 'Keep conversation',
        onConfirm: () => _toMessages(context),
      );
}
