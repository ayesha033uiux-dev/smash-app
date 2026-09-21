import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app/routes.dart';
import '../theme/app_theme.dart';
import '../theme/together_tokens.dart';
import '../widgets/onboarding.dart';
import '../widgets/primitives.dart';
import '../widgets/together.dart';
import 'profile_screens.dart' show SettingsGroup;

/// Screens the Figma file does not draw but a shipping app needs:
/// notifications, new chat, legal and help pages, permission prompts,
/// Premium, appearance and language, app-wide states and the stories
/// archive. All of them reuse the P05–P08 dialect (#F9F9FB page, DM Sans
/// titles, white r18 groups, flat #7C3AED buttons) so they sit beside the
/// designed screens without looking bolted on.

// ─── App-wide demo state ─────────────────────────────────────────────────────

abstract final class AppSettings {
  /// Drives MaterialApp.themeMode (see main.dart).
  static final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);
  static String language = 'English';
}

abstract final class DemoPermissions {
  static bool notifications = false;
  static bool microphone = false;
  static bool camera = false;
}

abstract final class DemoPremium {
  static bool active = false;
  static bool yearly = true;
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

void _go(BuildContext c, String r) => Navigator.of(c).pushNamed(r);
void _swap(BuildContext c, String r) =>
    Navigator.of(c).pushReplacementNamed(r);
void _pop(BuildContext c, [Object? result]) => Navigator.of(c).pop(result);
void _toast(BuildContext c, String t) =>
    ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(t)));

const _page = TogetherInk.pageAlt;
const _chevron = Color(0xFFB0AFB8);
const _muted = Color(0xFF8A8A96);

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
  double? height,
}) =>
    GoogleFonts.inter(
      fontSize: size,
      fontWeight: w,
      color: color,
      letterSpacing: ls,
      height: height,
    );

Text _lead(String t) => Text(t, style: _in(14, color: TogetherInk.body));

Text _eyebrow(String t) =>
    Text(t, style: _in(11.5, w: FontWeight.w600, color: _muted, ls: 1.2));

Widget _scaffold({
  required String title,
  required List<Widget> children,
  List<Widget> bottom = const [],
  double gap = 20,
  EdgeInsets padding = const EdgeInsets.fromLTRB(24, 20, 24, 24),
}) =>
    TogetherScaffold(
      title: title,
      background: _page,
      bottomSurface: true,
      padding: padding,
      gap: gap,
      bottom: bottom,
      children: children,
    );

/// Centred state artboard in the P08 layout (tile, DM headline, body, CTAs).
class _State extends StatelessWidget {
  const _State({
    required this.icon,
    required this.headline,
    required this.body,
    this.actions = const [],
    this.tile = TogetherInk.lilacTile,
    this.ink = TogetherInk.brand,
    this.headlineSize = 22,
  });

  final String icon;
  final String headline;
  final String body;
  final List<Widget> actions;
  final Color tile;
  final Color ink;
  final double headlineSize;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      showHeader: false,
      background: _page,
      padding: const EdgeInsets.fromLTRB(24, 220, 24, 24),
      gap: 16,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundTile(size: 64, icon: icon, iconSize: 28, color: tile, ink: ink),
        Text(headline, textAlign: TextAlign.center, style: _dm(headlineSize)),
        Text(
          body,
          textAlign: TextAlign.center,
          style: _in(14, color: TogetherInk.body),
        ),
        ...actions,
      ],
    );
  }
}

/// Group row: optional 36 r12 tile, title, subtitle, trailing chevron.
class _Row extends StatelessWidget {
  const _Row(
    this.title, {
    this.icon,
    this.subtitle,
    this.onTap,
    this.danger = false,
    this.trailing,
  });

  final String title;
  final String? icon;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool danger;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
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
            trailing ??
                SmasherIcon(
                  SmasherIcons.chevronSmall,
                  size: 14,
                  color: danger ? TogetherInk.errorGlyph : _chevron,
                ),
          ],
        ),
      ),
    );
  }
}

/// Radio choice card, as on P08 Notification previews.
class _Choice extends StatelessWidget {
  const _Choice({
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.leading,
    this.badge,
  });

  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;
  final Widget? leading;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
            if (leading != null) ...[leading!, const SizedBox(width: 14)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: _in(15, w: FontWeight.w600)),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: TogetherInk.brand,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            badge!,
                            style: _in(
                              10.5,
                              w: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(subtitle!, style: _in(12.5, color: TogetherInk.meta)),
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

/// White r16 search box.
class _Search extends StatelessWidget {
  const _Search({required this.hint, this.onChanged});

  final String hint;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: TogetherInk.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TogetherInk.cardBorder),
      ),
      child: Row(
        children: [
          const SmasherIcon(SmasherIcons.search, size: 16, color: _chevron),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: _in(14),
              cursorColor: TogetherInk.brand,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: _in(14, color: TogetherInk.placeholder),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _avatar(String letter) => Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: TogetherGradient.deep,
      ),
      child: Text(letter, style: _dm(14.5, Colors.white)),
    );

// ─── Notifications ───────────────────────────────────────────────────────────

class _Note {
  _Note(this.who, this.text, this.time, this.route, {this.icon, this.unread = true});

  final String? who;
  final String text;
  final String time;
  final String route;
  final String? icon;
  bool unread;
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _today = [
    _Note('Sarah', 'replied to your story', '12m', Routes.storyReplyRef),
    _Note(
      null,
      'Movie night is confirmed for Saturday, 8:00 PM',
      '1h',
      Routes.momentDetail,
      icon: SmasherIcons.calendarPlain,
    ),
    _Note('Zara', 'shared a new story', '2h', Routes.storyViewer),
    _Note(
      null,
      "Today's question is ready",
      '4h',
      Routes.dailyQuestion,
      icon: SmasherIcons.sparkle,
    ),
  ];
  final _earlier = [
    _Note(
      'Bilal',
      'joined Our Circle',
      'Mon',
      Routes.circleOverview,
      unread: false,
    ),
    _Note(
      'Alex',
      'sent you a photo',
      'Sun',
      Routes.conversation,
      unread: false,
    ),
    _Note(
      null,
      'New sign-in on Mac',
      'Sep 12',
      Routes.activeSessionsP08,
      icon: SmasherIcons.monitor,
      unread: false,
    ),
  ];

  Widget _row(_Note n) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() => n.unread = false);
        _go(context, n.route);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            if (n.who != null)
              _avatar(n.who![0])
            else
              RoundTile(size: 40, icon: n.icon, iconSize: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        if (n.who != null)
                          TextSpan(
                            text: '${n.who} ',
                            style: _in(13.5, w: FontWeight.w600),
                          ),
                        TextSpan(
                          text: n.text,
                          style: _in(
                            13.5,
                            color: n.unread
                                ? TogetherInk.ink
                                : TogetherInk.body,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(n.time, style: _in(12, color: _muted)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: n.unread ? TogetherInk.brand : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final anyUnread = [..._today, ..._earlier].any((n) => n.unread);
    return _scaffold(
      title: 'Notifications',
      children: [
        Row(
          children: [
            Expanded(child: _eyebrow('TODAY')),
            GestureDetector(
              onTap: anyUnread
                  ? () => setState(() {
                        for (final n in [..._today, ..._earlier]) {
                          n.unread = false;
                        }
                      })
                  : null,
              child: Text(
                'Mark all as read',
                style: _in(
                  13,
                  w: FontWeight.w600,
                  color: anyUnread ? TogetherInk.brand : _chevron,
                ),
              ),
            ),
          ],
        ),
        SettingsGroup(children: [for (final n in _today) _row(n)]),
        _eyebrow('EARLIER'),
        SettingsGroup(children: [for (final n in _earlier) _row(n)]),
        Center(
          child: GestureDetector(
            onTap: () => _go(context, Routes.notificationSettings),
            child: Text(
              'Notification settings',
              style: _in(13.5, w: FontWeight.w600, color: TogetherInk.brand),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── New chat ────────────────────────────────────────────────────────────────

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  String _q = '';

  static const _people = [
    ('Sarah', 'Connected', Routes.conversation),
    ('Alex', 'Connected', Routes.conversation),
    ('Bilal', 'Connected', Routes.conversation),
  ];

  @override
  Widget build(BuildContext context) {
    final hits = _people
        .where((p) => p.$1.toLowerCase().contains(_q.toLowerCase()))
        .toList();
    return _scaffold(
      title: 'New message',
      children: [
        _Search(
          hint: 'Search your circle',
          onChanged: (v) => setState(() => _q = v),
        ),
        SettingsGroup(
          children: [
            _Row(
              'Message Our Circle',
              icon: SmasherIcons.users,
              subtitle: '3 members',
              onTap: () => _swap(context, Routes.circleChat),
            ),
          ],
        ),
        _eyebrow('PEOPLE IN YOUR CIRCLE'),
        if (hits.isEmpty)
          Text(
            'No one in your circle matches "$_q".',
            style: _in(13.5, color: TogetherInk.body),
          )
        else
          SettingsGroup(
            children: [
              for (final p in hits)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _swap(context, p.$3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        _avatar(p.$1[0]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.$1, style: _in(14.5, w: FontWeight.w600)),
                              const SizedBox(height: 2),
                              Text(
                                p.$2,
                                style: _in(12.5, color: TogetherInk.meta),
                              ),
                            ],
                          ),
                        ),
                        const SmasherIcon(
                          SmasherIcons.chevronSmall,
                          size: 14,
                          color: _chevron,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        Center(
          child: GestureDetector(
            onTap: () => _go(context, Routes.inviteToCircle),
            child: Text(
              'Invite someone to your circle',
              style: _in(13.5, w: FontWeight.w600, color: TogetherInk.brand),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Legal & help ────────────────────────────────────────────────────────────

class LegalScreen extends StatelessWidget {
  const LegalScreen._(this.title, this.sections, {super.key});

  factory LegalScreen.terms({Key? key}) => LegalScreen._(
        'Terms of Service',
        const [
          (
            'Using Smasher',
            'Smasher is a private space for people you choose. You must be old '
                'enough to use it where you live and keep your sign-in details '
                'secure.',
          ),
          (
            'Your content',
            'You own what you share. You give Smasher permission to store and '
                'deliver it to the people you share it with, and nothing more.',
          ),
          (
            'Respect your circle',
            "Don't share content that harms, harasses or impersonates others. "
                'We may suspend accounts that break these rules.',
          ),
          (
            'Changes',
            "If these terms change we'll tell you in the app before the change "
                'takes effect.',
          ),
        ],
        key: key,
      );

  factory LegalScreen.privacy({Key? key}) => LegalScreen._(
        'Privacy Policy',
        const [
          (
            'What we collect',
            'Your account details, the content you share with your circle, and '
                'basic device information needed to keep your account secure.',
          ),
          (
            'How we use it',
            'Only to run Smasher: delivering messages, stories and moments to '
                'the people you choose. We do not sell your data.',
          ),
          (
            'Your controls',
            'You can download your data, change who sees what in Privacy & '
                'safety, or delete your account at any time.',
          ),
          (
            'Contact',
            'Questions about your privacy? Reach us from Help & support.',
          ),
        ],
        key: key,
      );

  final String title;
  final List<(String, String)> sections;

  @override
  Widget build(BuildContext context) {
    return _scaffold(
      title: title,
      gap: 22,
      children: [
        Text('Last updated September 1, 2026', style: _in(12.5, color: _muted)),
        for (final s in sections)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(s.$1, style: _dm(16)),
              const SizedBox(height: 8),
              Text(
                s.$2,
                style: _in(14, color: TogetherInk.body, height: 1.5),
              ),
            ],
          ),
      ],
    );
  }
}

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  static const _faqs = [
    (
      'Who can see what I share?',
      'Only the people in the circle you choose when you share. Nothing on '
          'Smasher is public.',
    ),
    (
      'How does the safeword work?',
      'Sending your safeword pauses the conversation immediately for both of '
          'you. Set it up in Privacy & safety → Safeword.',
    ),
    (
      'What is view-once media?',
      'Photos and videos sent as view-once can be opened a single time, then '
          'they disappear.',
    ),
    (
      'I forgot my PIN',
      'Sign in with your email and password, then set a new PIN in '
          'Security → PIN.',
    ),
    (
      'How do I leave a circle?',
      'Open Your circle → Circle settings → Leave circle.',
    ),
  ];

  String _q = '';
  int? _open;

  @override
  Widget build(BuildContext context) {
    final hits = [
      for (var i = 0; i < _faqs.length; i++)
        if ('${_faqs[i].$1} ${_faqs[i].$2}'
            .toLowerCase()
            .contains(_q.toLowerCase()))
          i,
    ];
    return _scaffold(
      title: 'Help Center',
      children: [
        _Search(
          hint: 'Search help articles',
          onChanged: (v) => setState(() => _q = v),
        ),
        _eyebrow('POPULAR QUESTIONS'),
        if (hits.isEmpty)
          _lead('No articles match. Try different words or contact us.')
        else
          SettingsGroup(
            children: [
              for (final i in hits)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _open = _open == i ? null : i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                _faqs[i].$1,
                                style: _in(14.5, w: FontWeight.w600),
                              ),
                            ),
                            AnimatedRotation(
                              turns: _open == i ? 0.25 : 0,
                              duration: const Duration(milliseconds: 150),
                              child: const SmasherIcon(
                                SmasherIcons.chevronSmall,
                                size: 14,
                                color: _chevron,
                              ),
                            ),
                          ],
                        ),
                        if (_open == i) ...[
                          const SizedBox(height: 8),
                          Text(
                            _faqs[i].$2,
                            style: _in(
                              13.5,
                              color: TogetherInk.body,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        TogetherButton(
          label: 'Contact us',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _go(context, Routes.contactUs),
        ),
      ],
    );
  }
}

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  static const _topics = ['Account', 'Privacy & safety', 'Something broke', 'Other'];
  int _topic = 0;
  final _msg = TextEditingController();

  @override
  void dispose() {
    _msg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold(
      title: 'Contact us',
      bottom: [
        TogetherButton(
          label: 'Send message',
          onPressed: _msg.text.trim().isEmpty
              ? null
              : () => _swap(context, Routes.contactSent),
        ),
      ],
      children: [
        _lead("Tell us what's going on. We usually reply within a day."),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var i = 0; i < _topics.length; i++)
              GestureDetector(
                onTap: () => setState(() => _topic = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: i == _topic ? TogetherInk.ink : TogetherInk.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: i == _topic
                        ? null
                        : Border.all(color: TogetherInk.cardBorder),
                  ),
                  child: Text(
                    _topics[i],
                    style: _in(
                      13,
                      w: FontWeight.w600,
                      color: i == _topic ? Colors.white : TogetherInk.body,
                    ),
                  ),
                ),
              ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TogetherInk.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: TogetherInk.cardBorder),
          ),
          child: TextField(
            controller: _msg,
            minLines: 5,
            maxLines: 5,
            onChanged: (_) => setState(() {}),
            style: _in(14.5),
            cursorColor: TogetherInk.brand,
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              hintText: 'Describe your question or issue…',
              hintStyle: _in(14.5, color: TogetherInk.placeholder),
            ),
          ),
        ),
        Text(
          "Please don't include passwords or other sensitive information.",
          style: _in(12, color: TogetherInk.placeholder),
        ),
      ],
    );
  }
}

class ContactSentScreen extends StatelessWidget {
  const ContactSentScreen({super.key});

  @override
  Widget build(BuildContext context) => _State(
        icon: SmasherIcons.successCheck,
        tile: TogetherInk.successTint,
        ink: const Color(0xFF1F9254),
        headline: 'Message sent',
        body: "Thanks for reaching out. We'll reply to ayesha@email.com.",
        actions: [
          TogetherButton(label: 'Done', onPressed: () => _pop(context)),
        ],
      );
}

// ─── Permissions ─────────────────────────────────────────────────────────────

/// Onboarding step after Face ID — asks for notifications in the Ob dialect.
class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key, this.onDone});

  final VoidCallback? onDone;

  @override
  Widget build(BuildContext context) {
    void done(bool allowed) {
      DemoPermissions.notifications = allowed;
      onDone?.call();
    }

    return ObScaffold(
      centerTop: true,
      gap: 24,
      top: [
        const Center(child: ObDisc(icon: SmasherIcons.bell)),
        Text(
          'Stay in the loop',
          textAlign: TextAlign.center,
          style: ObText.headlineSmall,
        ),
        Text(
          'Get notified when someone in your circle messages you, shares a '
          'story or confirms a moment. Previews stay private.',
          textAlign: TextAlign.center,
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        ObButton(
          label: 'Turn on notifications',
          onPressed: () => done(true),
        ),
        ObButton(
          label: 'Not now',
          kind: ObButtonKind.tertiary,
          onPressed: () => done(false),
        ),
      ],
      bottom: [
        Text(
          'You can change this anytime in Notification settings.',
          textAlign: TextAlign.center,
          style: ObText.small.copyWith(color: ObInk.muted),
        ),
      ],
    );
  }
}

/// Microphone / camera prompt — pops `true` when access is allowed.
class PermissionScreen extends StatelessWidget {
  const PermissionScreen.microphone({super.key})
      : icon = SmasherIcons.mic,
        headline = 'Allow microphone access',
        body = 'Smasher needs your microphone to record voice messages. '
            "We only listen while you're recording.",
        mic = true;

  const PermissionScreen.camera({super.key})
      : icon = SmasherIcons.cameraSmall,
        headline = 'Allow camera access',
        body = 'Smasher needs your camera to take photos and videos you '
            'choose to share with your circle.',
        mic = false;

  final String icon;
  final String headline;
  final String body;
  final bool mic;

  @override
  Widget build(BuildContext context) => _State(
        icon: icon,
        headline: headline,
        body: body,
        headlineSize: 20,
        actions: [
          TogetherButton(
            label: 'Allow access',
            onPressed: () {
              if (mic) {
                DemoPermissions.microphone = true;
              } else {
                DemoPermissions.camera = true;
              }
              _pop(context, true);
            },
          ),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: TextButton(
              onPressed: () => _pop(context, false),
              style: TextButton.styleFrom(shape: const StadiumBorder()),
              child: Text(
                'Not now',
                style: TogetherText.button.copyWith(
                  color: const Color(0xFF52525E),
                ),
              ),
            ),
          ),
        ],
      );
}

// ─── Premium ─────────────────────────────────────────────────────────────────

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool _yearly = DemoPremium.yearly;

  static const _features = [
    (SmasherIcons.users, 'More circles', 'Keep separate spaces for partner, friends and family.'),
    (SmasherIcons.time, 'Stories that last longer', 'Keep stories up for up to 7 days.'),
    (SmasherIcons.image, 'Full-quality media', 'Share photos and videos without compression.'),
    (SmasherIcons.sparkle, 'More ideas & questions', 'Unlock the full Together idea deck.'),
  ];

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      title: 'Smasher Premium',
      background: _page,
      washed: true,
      bottomSurface: true,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      gap: 18,
      bottom: [
        TogetherButton(
          label: 'Continue',
          onPressed: () {
            DemoPremium.active = true;
            DemoPremium.yearly = _yearly;
            _swap(context, Routes.premiumWelcome);
          },
        ),
        GestureDetector(
          onTap: () => _toast(context, 'No previous purchases found'),
          child: Text(
            'Restore purchases',
            style: _in(13.5, w: FontWeight.w600, color: TogetherInk.brand),
          ),
        ),
      ],
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: TogetherGradient.ideaCard,
            borderRadius: BorderRadius.circular(24),
            boxShadow: TogetherShadow.ideaCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RoundTile(
                size: 44,
                radius: 14,
                icon: SmasherIcons.sparkleSolid,
                iconSize: 22,
                color: Color(0x33FFFFFF),
                ink: Colors.white,
              ),
              const SizedBox(height: 16),
              Text('More room for your people', style: _dm(24, Colors.white)),
              const SizedBox(height: 6),
              Text(
                'Everything in Smasher, with more space to share.',
                style: _in(14, color: const Color(0xD9FFFFFF)),
              ),
            ],
          ),
        ),
        SettingsGroup(
          children: [
            for (final f in _features)
              _Row(
                f.$2,
                icon: f.$1,
                subtitle: f.$3,
                trailing: const SmasherIcon(
                  SmasherIcons.tick,
                  size: 16,
                  color: TogetherInk.brand,
                ),
              ),
          ],
        ),
        _Choice(
          title: 'Yearly',
          subtitle: r'$39.99 / year · 7-day free trial',
          badge: 'SAVE 33%',
          selected: _yearly,
          onTap: () => setState(() => _yearly = true),
        ),
        _Choice(
          title: 'Monthly',
          subtitle: r'$4.99 / month',
          selected: !_yearly,
          onTap: () => setState(() => _yearly = false),
        ),
        Text(
          'Cancel anytime in Settings. Payment is charged to your app store '
          'account and renews automatically unless cancelled at least 24 hours '
          'before the end of the period.',
          style: _in(11.5, color: TogetherInk.placeholder, height: 1.4),
        ),
      ],
    );
  }
}

class PremiumWelcomeScreen extends StatelessWidget {
  const PremiumWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => _State(
        icon: SmasherIcons.sparkleSolid,
        headline: 'Welcome to Premium',
        headlineSize: 24,
        body: 'Your new features are ready. Thank you for supporting Smasher.',
        actions: [
          TogetherButton(label: 'Done', onPressed: () => _pop(context)),
        ],
      );
}

class ManageSubscriptionScreen extends StatefulWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  State<ManageSubscriptionScreen> createState() =>
      _ManageSubscriptionScreenState();
}

class _ManageSubscriptionScreenState extends State<ManageSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    final plan = DemoPremium.yearly ? 'Yearly' : 'Monthly';
    return _scaffold(
      title: 'Subscription',
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: TogetherGradient.deep,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const RoundTile(
                size: 44,
                radius: 14,
                icon: SmasherIcons.sparkleSolid,
                iconSize: 22,
                color: Color(0x33FFFFFF),
                ink: Colors.white,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Premium · $plan', style: _dm(17, Colors.white)),
                    const SizedBox(height: 3),
                    Text(
                      DemoPremium.yearly
                          ? 'Renews on September 21, 2027'
                          : 'Renews on October 21, 2026',
                      style: _in(12.5, color: const Color(0xD9FFFFFF)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SettingsGroup(
          children: [
            _Row(
              'Change plan',
              icon: SmasherIcons.layers,
              subtitle: DemoPremium.yearly
                  ? r'Switch to monthly · $4.99'
                  : r'Switch to yearly · $39.99',
              onTap: () => setState(
                () => DemoPremium.yearly = !DemoPremium.yearly,
              ),
            ),
            _Row(
              'Restore purchases',
              icon: SmasherIcons.refresh,
              onTap: () => _toast(context, 'Purchases restored'),
            ),
          ],
        ),
        SettingsGroup(
          border: TogetherInk.errorTint,
          children: [
            _Row(
              'Cancel subscription',
              icon: SmasherIcons.xCircle,
              danger: true,
              onTap: () => _go(context, Routes.cancelSubscription),
            ),
          ],
        ),
      ],
    );
  }
}

class CancelSubscriptionScreen extends StatelessWidget {
  const CancelSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _scaffold(
      title: 'Cancel subscription',
      gap: 12,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      bottom: [
        TogetherButton(
          label: 'Cancel subscription',
          tone: TogetherButtonTone.danger,
          onPressed: () {
            DemoPremium.active = false;
            final messenger = ScaffoldMessenger.of(context);
            Navigator.of(context)
                .popUntil((r) => r.settings.name == Routes.account || r.isFirst);
            messenger.showSnackBar(
              const SnackBar(content: Text('Subscription cancelled')),
            );
          },
        ),
        TogetherButton(
          label: 'Keep Premium',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        const RoundTile(
          size: 56,
          icon: SmasherIcons.xCircle,
          iconSize: 24,
          color: TogetherInk.errorTint,
          ink: TogetherInk.errorGlyph,
        ),
        const SizedBox(height: 4),
        Text('Cancel Premium?', style: _dm(22)),
        Text(
          "You'll keep Premium until the end of this billing period, then "
          'return to the free plan. Your content stays safe.',
          style: _in(14, color: TogetherInk.body),
        ),
      ],
    );
  }
}

// ─── Chat photo viewer ───────────────────────────────────────────────────────

class PhotoViewerScreen extends StatelessWidget {
  const PhotoViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17141C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Column(
            children: [
              SizedBox(
                height: 52,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _pop(context),
                      child: const SmasherIcon(
                        SmasherIcons.cross,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You',
                            style: _in(
                              14,
                              w: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Today, 8:41 PM',
                            style: _in(11.5, color: const Color(0xBFFFFFFF)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _toast(context, 'Saved to your photos'),
                      child: const SmasherIcon(
                        SmasherIcons.download,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InteractiveViewer(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFF0E5D9), Color(0xFFD1C2AD)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
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

// ─── Appearance & language ───────────────────────────────────────────────────

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  Widget _swatch(Color bg, Color card) => Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: TogetherInk.cardBorder),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppSettings.themeMode,
      builder: (context, mode, _) => _scaffold(
        title: 'Appearance',
        gap: 12,
        children: [
          _lead('Choose how Smasher looks on this device.'),
          const SizedBox(height: 8),
          _Choice(
            title: 'Light',
            leading: _swatch(const Color(0xFFF6F6F9), Colors.white),
            selected: mode == ThemeMode.light,
            onTap: () => AppSettings.themeMode.value = ThemeMode.light,
          ),
          _Choice(
            title: 'Dark',
            leading: _swatch(const Color(0xFF17141C), const Color(0xFF2A2631)),
            selected: mode == ThemeMode.dark,
            onTap: () => AppSettings.themeMode.value = ThemeMode.dark,
          ),
          _Choice(
            title: 'System',
            subtitle: "Match your phone's setting.",
            leading: _swatch(const Color(0xFFEDE6FD), const Color(0xFF7C3AED)),
            selected: mode == ThemeMode.system,
            onTap: () => AppSettings.themeMode.value = ThemeMode.system,
          ),
        ],
      ),
    );
  }
}

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  static const _languages = [
    ('English', 'English'),
    ('Español', 'Spanish'),
    ('Français', 'French'),
    ('Deutsch', 'German'),
    ('العربية', 'Arabic'),
    ('اردو', 'Urdu'),
  ];

  @override
  Widget build(BuildContext context) {
    return _scaffold(
      title: 'Language',
      gap: 10,
      children: [
        _lead('Choose the language Smasher uses.'),
        const SizedBox(height: 8),
        for (final l in _languages)
          _Choice(
            title: l.$1,
            subtitle: l.$2 == l.$1 ? null : l.$2,
            selected: AppSettings.language == l.$2,
            onTap: () {
              if (l.$2 != 'English') {
                _toast(context, '${l.$2} is coming soon');
                return;
              }
              setState(() => AppSettings.language = l.$2);
            },
          ),
      ],
    );
  }
}

// ─── App-wide states ─────────────────────────────────────────────────────────

class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) => _State(
        icon: SmasherIcons.download,
        headline: 'Update Smasher',
        headlineSize: 24,
        body: 'A new version is available with important privacy and security '
            'improvements. Update to keep using Smasher.',
        actions: [
          TogetherButton(
            label: 'Update now',
            onPressed: () => _toast(context, 'Opening the app store…'),
          ),
        ],
      );
}

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) => _State(
        icon: SmasherIcons.settings,
        headline: "We'll be right back",
        headlineSize: 24,
        body: "Smasher is getting a quick update. Your circle and everything "
            "you've shared are safe.",
        actions: [
          TogetherButton(
            label: 'Try again',
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.splash,
              (_) => false,
            ),
          ),
        ],
      );
}

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) => _State(
        icon: SmasherIcons.wifiOff,
        headline: "You're offline",
        headlineSize: 24,
        body: 'Check your Wi-Fi or mobile data. Anything you send will go out '
            "when you're back online.",
        actions: [
          TogetherButton(
            label: 'Try again',
            onPressed: () => _pop(context),
          ),
        ],
      );
}

// ─── Stories archive ─────────────────────────────────────────────────────────

class StoriesArchiveScreen extends StatelessWidget {
  const StoriesArchiveScreen({super.key});

  static const _months = [
    (
      'SEPTEMBER 2026',
      [
        ('Sep 18', 'A quiet evening at home, finally.', 0),
        ('Sep 14', 'Sunday market haul', 1),
        ('Sep 9', 'First coffee of autumn', 2),
        ('Sep 2', 'New plant, who dis', 1),
      ],
    ),
    (
      'AUGUST 2026',
      [
        ('Aug 27', 'Beach day with the circle', 0),
        ('Aug 19', 'Rainy reading nook', 2),
        ('Aug 6', 'Birthday cake attempt #2', 1),
      ],
    ),
  ];

  static const _fills = [
    TogetherGradient.deep,
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFF0E5D9), Color(0xFFD1C2AD)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF7AB19E), Color(0xFF33808C)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _scaffold(
      title: 'Past stories',
      children: [
        _lead('Only you can see your past stories.'),
        for (final m in _months)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _eyebrow(m.$1),
              const SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.66,
                children: [
                  for (final s in m.$2)
                    GestureDetector(
                      onTap: () => _go(context, Routes.myStory),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: _fills[s.$3],
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s.$1,
                              style: _in(
                                11,
                                w: FontWeight.w600,
                                color: s.$3 == 1
                                    ? TogetherInk.ink
                                    : Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              s.$2,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: _dm(
                                12,
                                s.$3 == 1 ? TogetherInk.ink : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
