import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import '../theme/together_tokens.dart';
import '../widgets/primitives.dart';
import '../widgets/together.dart';

/// P05 — Profile module: edit profile, boundaries, privacy, security,
/// notifications, account, log out, delete, photo, Face ID, PIN, safeword,
/// pause, visibility. Same dialect as P03/P04 (flat buttons, DM Sans nav
/// title) on the violet wash.

// ─── Shared pieces ───────────────────────────────────────────────────────────

const _groupShadow = [
  BoxShadow(
    color: Color(0x0D5C21B5), // 5%
    offset: Offset(0, 4),
    blurRadius: 14,
    spreadRadius: -2,
  ),
];

/// White r18 group with 1px #F0ECFC rules between rows.
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.children, this.border});

  final List<Widget> children;

  /// The Delete account card: #FCE8E8 outline, no shadow.
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: TogetherInk.surface,
        borderRadius: BorderRadius.circular(18),
        border: border == null ? null : Border.all(color: border!),
        boxShadow: border == null ? _groupShadow : null,
      ),
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              const SizedBox(
                height: 1,
                child: ColoredBox(color: TogetherInk.cardBorder),
              ),
          ],
        ],
      ),
    );
  }
}

/// 44x26 r13 switch — on #7C3AED, off #E0DEE5, 20px white knob.
class SmasherToggle extends StatelessWidget {
  const SmasherToggle({super.key, required this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: AnimatedContainer(
        duration: SmasherMotion.fast,
        width: 44,
        height: 26,
        padding: const EdgeInsets.all(3),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        decoration: BoxDecoration(
          color: value ? TogetherInk.brand : const Color(0xFFE0DEE5),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

/// Settings row — pad 16/18; optional 36px #EDE6FD r12 icon tile (gap 14,
/// otherwise 12); 14.5 Semi Bold title over a 12 #6B6B78 line (gap 2);
/// trailing 14px chevron or a toggle.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
    this.toggle,
    this.onToggle,
    this.titleColor = TogetherInk.ink,
    this.subtitleSize = 12,
    this.dense = false,
  });

  final String title;
  final String? subtitle;
  final String? icon;
  final VoidCallback? onTap;

  /// When set, the row ends in a switch instead of a chevron.
  final bool? toggle;
  final ValueChanged<bool>? onToggle;
  final Color titleColor;
  final double subtitleSize;

  /// 58-high toggle rows (Circle privacy) with no subtitle.
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: toggle != null ? () => onToggle?.call(!toggle!) : onTap,
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
              ),
              const SizedBox(width: 14),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TogetherText.fieldValue.copyWith(color: titleColor),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: TogetherText.small.copyWith(
                        fontSize: subtitleSize,
                        fontWeight: FontWeight.w400,
                        color: TogetherInk.meta,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (toggle != null)
              SmasherToggle(value: toggle!, onChanged: onToggle)
            else
              const SmasherIcon(
                SmasherIcons.chevronSmall,
                size: 14,
                color: Color(0xFFB0AFB8),
              ),
          ],
        ),
      ),
    );
  }
}

/// Uppercase 11.5 Semi Bold, ls 1, #8A8A96.
class _Section extends StatelessWidget {
  const _Section(this.label, this.child);

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TogetherText.eyebrowTight.copyWith(
            fontSize: 11.5,
            color: TogetherInk.counter,
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

Text _lead(String text) =>
    Text(text, style: TogetherText.body.copyWith(color: TogetherInk.body));

/// P05's two artboard generations: 01–11 keep the wash behind an 18px nav
/// title; the later 12–19 paint the body white under a 19px title.
TogetherScaffold _page({
  required String title,
  required List<Widget> children,
  List<Widget> bottom = const [],
  bool later = false,
  bool bottomSurface = false,
  double gap = 20,
  EdgeInsets padding = const EdgeInsets.fromLTRB(24, 16, 24, 24),
}) {
  return TogetherScaffold(
    title: title,
    titleSize: later ? 19 : 18,
    washed: true,
    bodyColor: later ? TogetherInk.surface : null,
    bottomSurface: bottomSurface || later,
    padding: padding,
    gap: gap,
    bottom: bottom,
    children: children,
  );
}

// ─── Demo state ──────────────────────────────────────────────────────────────

abstract final class DemoProfile {
  static String name = 'Ayesha';
  static String about = 'Quiet moments, loud laughter.';
  static const email = 'ayesha@email.com';
  static bool hasPhoto = true;
  static bool faceId = true;
  static bool hideOnline = true;
  static bool viewOnce = true;
  static final notifications = <String, bool>{
    'Messages': true,
    'Matches': true,
    'Moments': true,
    'Circle activity': false,
    'Security alerts': true,
  };
  static final circlePrivacy = <String, bool>{
    'Show my profile photo': true,
    'Show my activity': true,
    'Show my availability': false,
  };
  static final boundaries = <String, String>{
    'Intimate photos': 'Maybe',
  };
  static String visibility = 'Circle only';
}

// ─── P05 01 Edit Profile ─────────────────────────────────────────────────────

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    this.onSave,
    this.onChangePhoto,
    this.onRemovePhoto,
  });

  final VoidCallback? onSave;
  final VoidCallback? onChangePhoto;
  final VoidCallback? onRemovePhoto;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final _name = TextEditingController(text: DemoProfile.name);
  late final _about = TextEditingController(text: DemoProfile.about);

  Widget _field(String label, TextEditingController c, {int? max}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TogetherText.fieldLabel),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: TogetherInk.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: TogetherInk.cardBorder),
          ),
          child: TextField(
            controller: c,
            maxLines: max == null ? 1 : null,
            style: TogetherText.fieldValue,
            cursorColor: TogetherInk.brand,
            inputFormatters: [
              if (max != null) LengthLimitingTextInputFormatter(max),
            ],
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration.collapsed(hintText: '')
                .copyWith(counterText: ''),
          ),
        ),
        if (max != null) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${c.text.length} / $max',
              style: TogetherText.tiny.copyWith(
                color: TogetherInk.placeholder,
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Edit profile',
      gap: 26,
      bottom: [
        TogetherButton(
          label: 'Save changes',
          onPressed: () {
            DemoProfile.name = _name.text.trim();
            DemoProfile.about = _about.text.trim();
            widget.onSave?.call();
          },
        ),
      ],
      children: [
        Column(
          children: [
            Container(
              width: 88,
              height: 88,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: TogetherGradient.deep,
              ),
              child: Text(
                _name.text.isEmpty ? '' : _name.text[0].toUpperCase(),
                style: TogetherText.pageTitle.copyWith(
                  fontSize: 34,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PhotoAction(
                  'Change photo',
                  fill: TogetherInk.lilacTile,
                  ink: TogetherInk.brand,
                  onTap: widget.onChangePhoto,
                ),
                const SizedBox(width: 10),
                _PhotoAction(
                  'Remove photo',
                  fill: TogetherInk.surface,
                  ink: TogetherInk.placeholder,
                  onTap: widget.onRemovePhoto,
                ),
              ],
            ),
          ],
        ),
        _field('Name', _name),
        _field('About', _about, max: 160),
      ],
    );
  }
}

class _PhotoAction extends StatelessWidget {
  const _PhotoAction(this.label, {required this.fill, required this.ink, this.onTap});

  final String label;
  final Color fill;
  final Color ink;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(label, style: TogetherText.fieldLabel.copyWith(color: ink)),
      ),
    );
  }
}

// ─── P05 02 / 03 Boundaries ──────────────────────────────────────────────────

class BoundariesScreen extends StatelessWidget {
  const BoundariesScreen({super.key, this.onOpen});

  final ValueChanged<String>? onOpen;

  static const _sections = [
    (
      'Communication',
      [
        ('Messaging pace', 'How often you\'d like to hear from your circle.'),
        ('Check-ins', 'Whether you\'re open to daily check-ins.'),
      ],
    ),
    (
      'Photos',
      [('Intimate photos', 'Control who can send and view intimate media.')],
    ),
    (
      'Planning',
      [('Spontaneous plans', 'Whether last-minute moments work for you.')],
    ),
    (
      'Interaction',
      [('Physical closeness', 'What feels comfortable when you\'re together.')],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Boundaries',
      gap: 26,
      children: [
        _lead(
          'Choose what you\'re comfortable with. You can change these '
          'settings anytime.',
        ),
        for (final (label, rows) in _sections)
          _Section(
            label,
            SettingsGroup(
              children: [
                for (final (title, sub) in rows)
                  SettingsRow(
                    title: title,
                    subtitle: sub,
                    subtitleSize: 12.5,
                    onTap: () => onOpen?.call(title),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class BoundaryDetailScreen extends StatefulWidget {
  const BoundaryDetailScreen({
    super.key,
    this.title = 'Intimate photos',
    this.onSave,
  });

  final String title;
  final VoidCallback? onSave;

  @override
  State<BoundaryDetailScreen> createState() => _BoundaryDetailScreenState();
}

class _BoundaryDetailScreenState extends State<BoundaryDetailScreen> {
  late String _choice = DemoProfile.boundaries[widget.title] ?? 'Maybe';

  @override
  Widget build(BuildContext context) {
    return _page(
      title: widget.title,
      gap: 24,
      bottomSurface: true,
      bottom: [
        TogetherButton(
          label: 'Save changes',
          onPressed: () {
            DemoProfile.boundaries[widget.title] = _choice;
            widget.onSave?.call();
          },
        ),
      ],
      children: [
        _lead('Choose what feels comfortable for you.'),
        Column(
          children: [
            for (final o in const ['Yes', 'Maybe', 'No']) ...[
              OptionRow(
                label: o,
                selected: _choice == o,
                onTap: () => setState(() => _choice = o),
              ),
              if (o != 'No') const SizedBox(height: 12),
            ],
          ],
        ),
      ],
    );
  }
}

// ─── P05 04 Privacy / 17–19 visibility ───────────────────────────────────────

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key, this.onOpen});

  /// 'profile' | 'circle' | 'activity' | 'media'.
  final ValueChanged<String>? onOpen;

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Privacy',
      children: [
        _lead('You control who can see your information and activity.'),
        SettingsGroup(
          children: [
            SettingsRow(
              icon: SmasherIcons.eyeLine,
              title: 'Profile visibility',
              subtitle: 'Who can see your profile.',
              onTap: () => widget.onOpen?.call('profile'),
            ),
            SettingsRow(
              icon: SmasherIcons.peopleLine,
              title: 'Circle visibility',
              subtitle: 'Who can see which circles you\'re in.',
              onTap: () => widget.onOpen?.call('circle'),
            ),
            SettingsRow(
              icon: SmasherIcons.tick,
              title: 'Activity visibility',
              subtitle: 'Who can see your recent activity.',
              onTap: () => widget.onOpen?.call('activity'),
            ),
            SettingsRow(
              icon: SmasherIcons.image,
              title: 'Media privacy',
              subtitle: 'Control how private media is shared.',
              onTap: () => widget.onOpen?.call('media'),
            ),
            SettingsRow(
              icon: SmasherIcons.dot,
              title: 'Hide online status',
              subtitle: 'People in your circles won\'t see when you\'re '
                  'online.',
              toggle: DemoProfile.hideOnline,
              onToggle: (v) => setState(() => DemoProfile.hideOnline = v),
            ),
          ],
        ),
      ],
    );
  }
}

/// P05 19 Profile visibility (and Activity visibility, generated from it).
class VisibilityScreen extends StatefulWidget {
  const VisibilityScreen({
    super.key,
    this.title = 'Profile visibility',
    this.lead = 'Choose who can see your profile.',
    this.noun = 'profile',
  });

  final String title;
  final String lead;
  final String noun;

  @override
  State<VisibilityScreen> createState() => _VisibilityScreenState();
}

class _VisibilityScreenState extends State<VisibilityScreen> {
  late String _choice = DemoProfile.visibility;

  @override
  Widget build(BuildContext context) {
    final options = [
      (
        'Circle only',
        'Only members of your circles can see your ${widget.noun}.',
      ),
      (
        'Trusted connections',
        'People you\'ve marked as trusted can see your ${widget.noun}.',
      ),
      ('Private', 'Your ${widget.noun} is hidden from everyone except you.'),
    ];
    return _page(
      title: widget.title,
      later: true,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      children: [
        _lead(widget.lead),
        Column(
          children: [
            for (final (t, d) in options) ...[
              _DetailedOption(
                title: t,
                description: d,
                selected: _choice == t,
                onTap: () => setState(() {
                  _choice = t;
                  DemoProfile.visibility = t;
                }),
              ),
              if (t != 'Private') const SizedBox(height: 12),
            ],
          ],
        ),
      ],
    );
  }
}

/// Option Row with a description — pad 16/18, gap 3, 12.5 #6B6B78.
class _DetailedOption extends StatelessWidget {
  const _DetailedOption({
    required this.title,
    required this.description,
    required this.selected,
    this.onTap,
  });

  final String title;
  final String description;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: SmasherMotion.fast,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TogetherText.option),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: TogetherText.caption.copyWith(
                      color: TogetherInk.meta,
                    ),
                  ),
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

class CirclePrivacyScreen extends StatefulWidget {
  const CirclePrivacyScreen({super.key});

  @override
  State<CirclePrivacyScreen> createState() => _CirclePrivacyScreenState();
}

class _CirclePrivacyScreenState extends State<CirclePrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Circle privacy',
      later: true,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      children: [
        _lead(
          'Your circles are private spaces. Choose what other members can '
          'see.',
        ),
        SettingsGroup(
          children: [
            for (final e in DemoProfile.circlePrivacy.entries)
              SettingsRow(
                title: e.key,
                toggle: e.value,
                onToggle: (v) =>
                    setState(() => DemoProfile.circlePrivacy[e.key] = v),
              ),
          ],
        ),
      ],
    );
  }
}

class MediaPrivacyScreen extends StatefulWidget {
  const MediaPrivacyScreen({super.key});

  @override
  State<MediaPrivacyScreen> createState() => _MediaPrivacyScreenState();
}

class _MediaPrivacyScreenState extends State<MediaPrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Media privacy',
      gap: 16,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      children: [
        _lead('Control how private media is shared and viewed.'),
        SettingsGroup(
          children: [
            SettingsRow(
              title: 'View-once media',
              subtitle: 'Media disappears after it has been viewed.',
              toggle: DemoProfile.viewOnce,
              onToggle: (v) => setState(() => DemoProfile.viewOnce = v),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── P05 05 Security / 14 Face ID / 15 PIN ───────────────────────────────────

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({
    super.key,
    this.onPin,
    this.onSessions,
    this.onLogout,
  });

  final VoidCallback? onPin;
  final VoidCallback? onSessions;
  final VoidCallback? onLogout;

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Security',
      children: [
        _lead('Protect your private Smasher account.'),
        SettingsGroup(
          children: [
            SettingsRow(
              icon: SmasherIcons.lockSmall,
              title: 'PIN',
              subtitle: 'PIN is enabled',
              onTap: widget.onPin,
            ),
            SettingsRow(
              icon: SmasherIcons.faceSmall,
              title: 'Face ID',
              subtitle: 'Unlock Smasher quickly and privately.',
              toggle: DemoProfile.faceId,
              onToggle: (v) => setState(() => DemoProfile.faceId = v),
            ),
            SettingsRow(
              icon: SmasherIcons.monitor,
              title: 'Active sessions',
              subtitle: 'See where you\'re signed in.',
              onTap: widget.onSessions,
            ),
            SettingsRow(
              icon: SmasherIcons.logout,
              title: 'Log out',
              onTap: widget.onLogout,
            ),
          ],
        ),
      ],
    );
  }
}

/// Active sessions — not drawn in the file; built from the Security rows.
class ActiveSessionsScreen extends StatelessWidget {
  const ActiveSessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Active sessions',
      children: [
        _lead('Devices signed in to your Smasher account.'),
        const SettingsGroup(
          children: [
            _SessionRow('iPhone 14', 'This device · Active now', current: true),
            _SessionRow('MacBook Air', 'Last active 2 days ago'),
          ],
        ),
      ],
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow(this.device, this.meta, {this.current = false});

  final String device;
  final String meta;
  final bool current;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          const RoundTile(
            size: 36,
            radius: 12,
            icon: SmasherIcons.monitor,
            iconSize: 17,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(device, style: TogetherText.fieldValue),
                const SizedBox(height: 2),
                Text(
                  meta,
                  style: TogetherText.small.copyWith(
                    fontWeight: FontWeight.w400,
                    color: TogetherInk.meta,
                  ),
                ),
              ],
            ),
          ),
          if (!current)
            Text(
              'Sign out',
              style: TogetherText.fieldLabel.copyWith(
                color: TogetherInk.dangerText,
              ),
            ),
        ],
      ),
    );
  }
}

class FaceIdSettingsScreen extends StatefulWidget {
  const FaceIdSettingsScreen({super.key});

  @override
  State<FaceIdSettingsScreen> createState() => _FaceIdSettingsScreenState();
}

class _FaceIdSettingsScreenState extends State<FaceIdSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Face ID',
      later: true,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      children: [
        const RoundTile(size: 56, icon: SmasherIcons.faceId),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use Face ID to unlock Smasher',
              style: TogetherText.matchedTitle,
            ),
            const SizedBox(height: 20),
            _lead(
              'Unlock Smasher quickly while keeping your account private.',
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: TogetherInk.surface,
            borderRadius: BorderRadius.circular(18),
            boxShadow: _groupShadow,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text('Face ID', style: TogetherText.fieldValue),
              ),
              SmasherToggle(
                value: DemoProfile.faceId,
                onChanged: (v) => setState(() => DemoProfile.faceId = v),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PinSettingsScreen extends StatelessWidget {
  const PinSettingsScreen({super.key, this.onChange, this.onTurnOff});

  final VoidCallback? onChange;
  final VoidCallback? onTurnOff;

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'PIN',
      later: true,
      gap: 8,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      children: [
        const StatusPill(
          StatusPillTone.confirmed,
          label: 'PIN is enabled',
        ),
        TogetherButton(label: 'Change PIN', onPressed: onChange),
        TogetherButton(
          label: 'Turn off PIN',
          tone: TogetherButtonTone.secondary,
          onPressed: onTurnOff,
        ),
      ],
    );
  }
}

// ─── P05 06 Notifications ────────────────────────────────────────────────────

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  static const _rows = [
    ('Messages', 'New messages from your circle.', SmasherIcons.messageSquare),
    ('Matches', 'When you match on a mutual idea.', SmasherIcons.sparkleSolid),
    ('Moments', 'Reminders about upcoming plans.', SmasherIcons.calendarPlain),
    ('Circle activity', 'Updates from your circle.', SmasherIcons.bellSmall),
    ('Security alerts', 'Sign-in and account changes.', SmasherIcons.errorCircle),
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Notifications',
      children: [
        _lead('Choose which notifications you receive.'),
        SettingsGroup(
          children: [
            for (final (t, s, i) in _rows)
              SettingsRow(
                icon: i,
                title: t,
                subtitle: s,
                toggle: DemoProfile.notifications[t],
                onToggle: (v) =>
                    setState(() => DemoProfile.notifications[t] = v),
              ),
          ],
        ),
      ],
    );
  }
}

// ─── P05 07 Account ──────────────────────────────────────────────────────────

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({
    super.key,
    this.onEmail,
    this.onPassword,
    this.onSecurity,
    this.onPrivacy,
    this.onNotifications,
    this.onData,
    this.onHelp,
    this.onSubscription,
    this.onAppearance,
    this.onLanguage,
    this.subscriptionLabel = 'Free plan',
    this.onAbout,
    this.onLogout,
    this.onDelete,
  });

  final VoidCallback? onEmail;
  final VoidCallback? onData;
  final VoidCallback? onSubscription;
  final VoidCallback? onAppearance;
  final VoidCallback? onLanguage;
  final String subscriptionLabel;
  final VoidCallback? onHelp;
  final VoidCallback? onAbout;
  final VoidCallback? onPassword;
  final VoidCallback? onSecurity;
  final VoidCallback? onPrivacy;
  final VoidCallback? onNotifications;
  final VoidCallback? onLogout;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Account',
      children: [
        SettingsGroup(
          children: [
            SettingsRow(
              title: 'Email',
              subtitle: DemoProfile.email,
              onTap: onEmail,
            ),
            SettingsRow(
              title: 'Password',
              subtitle: 'Last changed 3 months ago',
              onTap: onPassword,
            ),
            SettingsRow(
              title: 'Security',
              subtitle: 'PIN, Face ID and sign-in.',
              onTap: onSecurity,
            ),
            SettingsRow(
              title: 'Privacy',
              subtitle: 'Control what your circle can see.',
              onTap: onPrivacy,
            ),
          ],
        ),
        SettingsGroup(
          children: [
            SettingsRow(
              title: 'Smasher Premium',
              subtitle: subscriptionLabel,
              onTap: onSubscription,
            ),
            SettingsRow(
              title: 'Appearance',
              subtitle: 'Light, dark or match your phone.',
              onTap: onAppearance,
            ),
            SettingsRow(
              title: 'Language',
              subtitle: 'English',
              onTap: onLanguage,
            ),
          ],
        ),
        SettingsGroup(
          children: [
            SettingsRow(
              title: 'Data & storage',
              subtitle: 'Download your data and storage usage.',
              onTap: onData,
            ),
            SettingsRow(
              title: 'Help & support',
              subtitle: 'Help Center, contact us and rating.',
              onTap: onHelp,
            ),
            SettingsRow(title: 'About', onTap: onAbout),
          ],
        ),
        SettingsGroup(
          children: [SettingsRow(title: 'Log out', onTap: onLogout)],
        ),
        SettingsGroup(
          border: TogetherInk.errorTint,
          children: [
            SettingsRow(
              title: 'Delete account',
              subtitle: 'Permanently remove your account.',
              titleColor: TogetherInk.danger,
              onTap: onDelete,
            ),
          ],
        ),
      ],
    );
  }
}

// ─── P05 08 Logout / 09–11 Delete ────────────────────────────────────────────

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key, this.onLogout, this.onStay});

  final VoidCallback? onLogout;
  final VoidCallback? onStay;

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Log out',
      gap: 12,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
      children: [
        const RoundTile(size: 56, icon: SmasherIcons.logout),
        Text('Log out?', style: TogetherText.sectionTitle),
        _lead('You\'ll need to sign in again to access your account.'),
        const SizedBox(height: 18),
        TogetherButton(label: 'Log out', onPressed: onLogout),
        TogetherButton(
          label: 'Stay signed in',
          tone: TogetherButtonTone.secondary,
          onPressed: onStay,
        ),
      ],
    );
  }
}

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key, this.onDelete, this.onKeep});

  final VoidCallback? onDelete;
  final VoidCallback? onKeep;

  @override
  Widget build(BuildContext context) {
    const items = [
      'Your profile will be removed.',
      'Your account access will be removed.',
      'Your private data will be deleted according to Smasher\'s privacy '
          'policy.',
    ];
    return _page(
      title: 'Delete account',
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      bottomSurface: true,
      bottom: [
        TogetherButton(
          label: 'Delete account',
          tone: TogetherButtonTone.danger,
          onPressed: onDelete,
        ),
        TogetherButton(
          label: 'Keep account',
          tone: TogetherButtonTone.secondary,
          onPressed: onKeep,
        ),
      ],
      children: [
        const RoundTile(
          size: 56,
          icon: SmasherIcons.trash,
          color: TogetherInk.errorTint,
          ink: TogetherInk.errorGlyph,
        ),
        Text(
          'Delete your Smasher account?',
          style: TogetherText.cardTitleLarge,
        ),
        _lead('This permanently removes your account and associated data.'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: TogetherInk.surface,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              for (final t in items) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 5),
                      decoration: const BoxDecoration(
                        color: TogetherInk.danger,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        t,
                        style: TogetherText.bodySmall.copyWith(
                          color: TogetherInk.body,
                        ),
                      ),
                    ),
                  ],
                ),
                if (t != items.last) const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class DeleteConfirmScreen extends StatefulWidget {
  const DeleteConfirmScreen({super.key, this.onConfirm, this.onKeep});

  final VoidCallback? onConfirm;
  final VoidCallback? onKeep;

  @override
  State<DeleteConfirmScreen> createState() => _DeleteConfirmScreenState();
}

class _DeleteConfirmScreenState extends State<DeleteConfirmScreen> {
  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = _controller.text.length;
    return _page(
      title: 'Confirm',
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      children: [
        const RoundTile(
          size: 56,
          icon: SmasherIcons.errorCircle,
          color: TogetherInk.errorTint,
          ink: TogetherInk.errorGlyph,
        ),
        Text('Are you sure?', style: TogetherText.sectionTitle),
        _lead('This action can\'t be undone.'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter your PIN', style: TogetherText.fieldLabel),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _focus.requestFocus(),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < 4; i++) ...[
                        Container(
                          width: 56,
                          height: 56,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: TogetherInk.cardBorder),
                          ),
                          child: i < n
                              ? Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: TogetherInk.ink,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                        ),
                        if (i != 3) const SizedBox(width: 12),
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Opacity(
          opacity: n == 4 ? 1 : 0.5,
          child: TogetherButton(
            label: 'Permanently delete account',
            tone: TogetherButtonTone.danger,
            onPressed: n == 4 ? widget.onConfirm : null,
          ),
        ),
        TogetherButton(
          label: 'Keep my account',
          tone: TogetherButtonTone.secondary,
          onPressed: widget.onKeep,
        ),
      ],
    );
  }
}

class DeleteSuccessScreen extends StatelessWidget {
  const DeleteSuccessScreen({super.key, this.onDone});

  final VoidCallback? onDone;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      showHeader: false,
      washed: true,
      padding: const EdgeInsets.fromLTRB(24, 220, 24, 24),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const RoundTile(
          size: 64,
          icon: SmasherIcons.successCheck,
          iconSize: 28,
          color: TogetherInk.skeletonHome,
          ink: TogetherInk.body,
        ),
        Text(
          'Your account has been deleted',
          textAlign: TextAlign.center,
          style: TogetherText.cardTitleLarge,
        ),
        Text(
          'Your Smasher account has been removed.',
          textAlign: TextAlign.center,
          style: TogetherText.body.copyWith(color: TogetherInk.body),
        ),
        TogetherButton(label: 'Done', onPressed: onDone),
      ],
    );
  }
}

// ─── P05 12 Media Picker / 13 Remove Photo ───────────────────────────────────

class MediaPickerScreen extends StatelessWidget {
  const MediaPickerScreen({super.key, this.onPick, this.onCancel});

  final VoidCallback? onPick;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Change photo',
      later: true,
      gap: 12,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      children: [
        SettingsGroup(
          children: [
            _PickerRow(SmasherIcons.image, 'Choose from Photos', onPick),
            _PickerRow(SmasherIcons.cameraSmall, 'Take a Photo', onPick),
          ],
        ),
        GestureDetector(
          onTap: onCancel,
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: TogetherInk.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              'Cancel',
              style: TogetherText.fieldValue.copyWith(
                color: TogetherInk.placeholder,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PickerRow extends StatelessWidget {
  const _PickerRow(this.icon, this.label, this.onTap);

  final String icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            RoundTile(size: 36, radius: 12, icon: icon, iconSize: 17),
            const SizedBox(width: 14),
            Text(label, style: TogetherText.fieldValue),
          ],
        ),
      ),
    );
  }
}

/// One confirm layout shared by Remove photo, Pause (and Safeword's bar).
class _ConfirmPage extends StatelessWidget {
  const _ConfirmPage({
    required this.title,
    required this.icon,
    required this.heading,
    required this.headingSize,
    required this.body,
    required this.primary,
    required this.secondary,
    this.danger = false,
    this.iconSize = 24,
    this.gap = 12,
    this.onPrimary,
    this.onSecondary,
  });

  final String title;
  final String icon;
  final String heading;
  final double headingSize;
  final String body;
  final String primary;
  final String secondary;
  final bool danger;
  final double iconSize;
  final double gap;
  final VoidCallback? onPrimary;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    return _page(
      title: title,
      later: true,
      gap: gap,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      bottom: [
        TogetherButton(
          label: primary,
          tone: danger ? TogetherButtonTone.danger : TogetherButtonTone.primary,
          onPressed: onPrimary,
        ),
        TogetherButton(
          label: secondary,
          tone: TogetherButtonTone.secondary,
          onPressed: onSecondary,
        ),
      ],
      children: [
        RoundTile(
          size: 56,
          icon: icon,
          iconSize: iconSize,
          color: danger ? TogetherInk.errorTint : TogetherInk.lilacTile,
          ink: danger ? TogetherInk.errorGlyph : TogetherInk.brand,
        ),
        Text(
          heading,
          style: TogetherText.cardTitleLarge.copyWith(fontSize: headingSize),
        ),
        _lead(body),
      ],
    );
  }
}

class RemovePhotoScreen extends StatelessWidget {
  const RemovePhotoScreen({super.key, this.onRemove, this.onKeep});

  final VoidCallback? onRemove;
  final VoidCallback? onKeep;

  @override
  Widget build(BuildContext context) => _ConfirmPage(
        title: 'Remove photo',
        icon: SmasherIcons.trash,
        heading: 'Remove profile photo?',
        headingSize: 22,
        body: 'Your profile photo will be removed from your profile.',
        primary: 'Remove photo',
        secondary: 'Keep photo',
        danger: true,
        onPrimary: onRemove,
        onSecondary: onKeep,
      );
}

class PauseScreen extends StatelessWidget {
  const PauseScreen({super.key, this.onPause, this.onKeep});

  final VoidCallback? onPause;
  final VoidCallback? onKeep;

  @override
  Widget build(BuildContext context) => _ConfirmPage(
        title: 'Pause',
        icon: SmasherIcons.pause,
        iconSize: 22,
        gap: 16,
        heading: 'Pause your interactions',
        headingSize: 21,
        body: 'Pause lets you temporarily step away from conversations and '
            'shared activity.',
        primary: 'Pause Smasher',
        secondary: 'Keep active',
        onPrimary: onPause,
        onSecondary: onKeep,
      );
}

// ─── P05 16 Safeword ─────────────────────────────────────────────────────────

class SafewordScreen extends StatefulWidget {
  const SafewordScreen({super.key, this.onSave, this.onRemove});

  final VoidCallback? onSave;
  final VoidCallback? onRemove;

  @override
  State<SafewordScreen> createState() => _SafewordScreenState();
}

class _SafewordScreenState extends State<SafewordScreen> {
  final _controller = TextEditingController(text: 'pinecone');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Safeword',
      later: true,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      bottom: [
        TogetherButton(label: 'Save safeword', onPressed: widget.onSave),
        TogetherButton(
          label: 'Remove safeword',
          tone: TogetherButtonTone.secondary,
          onPressed: () {
            _controller.clear();
            widget.onRemove?.call();
          },
        ),
      ],
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your safeword', style: TogetherText.matchedTitle),
            const SizedBox(height: 4),
            _lead(
              'Use a private word to quickly communicate that you want to '
              'pause an interaction.',
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Safeword', style: TogetherText.fieldLabel),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: TogetherInk.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: TogetherInk.cardBorder),
              ),
              child: TextField(
                controller: _controller,
                obscureText: true,
                obscuringCharacter: '•',
                style: TogetherText.option.copyWith(
                  fontSize: 16,
                  letterSpacing: 4,
                ),
                cursorColor: TogetherInk.brand,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Choose a word',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
