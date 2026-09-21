import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app/routes.dart';
import '../theme/app_theme.dart';
import '../theme/together_tokens.dart';
import '../widgets/module.dart';
import '../widgets/primitives.dart';
import '../widgets/together.dart';
import 'profile_screens.dart' show SettingsGroup;

/// P06 — Stories module (43 artboards).
///
/// Same flat dialect as P03–P05: #F9F9FB page, Header/Back h52 with a DM Sans
/// 17 title, Body pad 20/24, white r18 groups on a #5C21B5 5% shadow, flat
/// #7C3AED buttons. The editors (Text, Photo, Video) and the viewer are the
/// module's only dark artboards.

// ─── Navigation ──────────────────────────────────────────────────────────────

void _go(BuildContext c, String r) => Navigator.of(c).pushNamed(r);
void _swap(BuildContext c, String r) => Navigator.of(c).pushReplacementNamed(r);
void _pop(BuildContext c) => Navigator.of(c).maybePop();

/// Back to the shell on the Stories tab (index 2), clearing the flow.
void _toStories(BuildContext c) => Navigator.of(c)
    .pushNamedAndRemoveUntil(Routes.home, (_) => false, arguments: 2);

// ─── Tokens ──────────────────────────────────────────────────────────────────

abstract final class _S {
  static const page = TogetherInk.pageAlt; // #F9F9FB
  static const chevron = Color(0xFFB0AFB8);
  static const ringIdle = Color(0xFFBFBACC);
  static const ringSeen = Color(0xFFDEDBE5);
  static const textStory = Color(0xFF7C3AED);
  static const photoStory = Color(0xFF17141C);
  static const media = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF0E5D9), Color(0xFFD1C2AD)],
  );

  /// Journal card — #5C21B5 6%, y6 b18 s-2.
  static const cardShadow = TogetherShadow.soft;

  /// Choice cards / groups — #5C21B5 5%, y4 b14 s-2.
  static const groupShadow = [
    BoxShadow(
      color: Color(0x0D5C21B5),
      offset: Offset(0, 4),
      blurRadius: 14,
      spreadRadius: -2,
    ),
  ];

  /// Selectable rows — #5C21B5 4%, y3 b12 s-1.
  static const rowShadow = [
    BoxShadow(
      color: Color(0x0A5C21B5),
      offset: Offset(0, 3),
      blurRadius: 12,
      spreadRadius: -1,
    ),
  ];
}

TextStyle _dm(double size, [Color color = TogetherInk.ink]) =>
    GoogleFonts.dmSans(fontSize: size, fontWeight: FontWeight.w600, color: color);

TextStyle _in(double size, {FontWeight w = FontWeight.w400, Color color = TogetherInk.ink, double ls = 0}) =>
    GoogleFonts.inter(fontSize: size, fontWeight: w, color: color, letterSpacing: ls);

// ─── Shared pieces ───────────────────────────────────────────────────────────

/// Header/Back page on #F9F9FB, Body pad 20/24, white bottom surface.
Widget _page({
  required String title,
  required List<Widget> children,
  List<Widget> bottom = const [],
  double gap = 20,
  EdgeInsets padding = const EdgeInsets.fromLTRB(24, 20, 24, 24),
}) {
  return TogetherScaffold(
    title: title,
    background: _S.page,
    bottomSurface: true,
    padding: padding,
    gap: gap,
    bottom: bottom,
    children: children,
  );
}

Text _lead(String t) => Text(t, style: _in(14, color: TogetherInk.body));

/// Uppercase 11.5 Semi Bold ls 1.2 #8A8A96.
Text _eyebrow(String t) =>
    Text(t, style: _in(11.5, w: FontWeight.w600, color: TogetherInk.counter, ls: 1.2));

/// Centred state artboards: Body pad-top 200–260, tile, title, copy, actions.
class _StoryState extends StatelessWidget {
  const _StoryState({
    required this.icon,
    required this.title,
    required this.body,
    this.tile = TogetherInk.lilacTile,
    this.ink = TogetherInk.brand,
    this.tileSize = 64,
    this.titleSize = 20,
    this.bodySize = 14,
    this.top = 220,
    this.gap = 20,
    this.actions = const [],
    this.bottom = const [],
    this.white = false,
  });

  final String icon;
  final String title;
  final String body;
  final Color tile;
  final Color ink;
  final double tileSize;
  final double titleSize;
  final double bodySize;
  final double top;
  final double gap;
  final List<Widget> actions;
  final List<Widget> bottom;
  final bool white;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      RoundTile(
        size: tileSize,
        icon: icon,
        iconSize: tileSize >= 64 ? 26 : 24,
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
    return TogetherScaffold(
      showHeader: false,
      background: white ? TogetherInk.surface : _S.page,
      bottomSurface: true,
      padding: EdgeInsets.fromLTRB(24, top, 24, 24),
      gap: gap,
      crossAxisAlignment: CrossAxisAlignment.center,
      bottom: bottom,
      children: items,
    );
  }
}

/// White r18 card with an icon tile, title, subtitle and a chevron.
class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: TogetherInk.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: _S.groupShadow,
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
            const SmasherIcon(SmasherIcons.chevronSmall, size: 14, color: _S.chevron),
          ],
        ),
      ),
    );
  }
}

/// Group row: 36 r12 tile, 14.5 title, optional chevron. Danger rows tint red.
class _ActionRow extends StatelessWidget {
  const _ActionRow(this.icon, this.title, this.onTap,
      {this.danger = false, this.chevron = true,});

  final String icon;
  final String title;
  final VoidCallback? onTap;
  final bool danger;
  final bool chevron;

  @override
  Widget build(BuildContext context) {
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
              ink: danger ? TogetherInk.errorGlyph : TogetherInk.brand,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: _in(14.5,
                    w: FontWeight.w600,
                    color: danger ? TogetherInk.danger : TogetherInk.ink,),
              ),
            ),
            if (chevron)
              SmasherIcon(
                SmasherIcons.chevronSmall,
                size: 14,
                color: danger ? TogetherInk.errorGlyph : _S.chevron,
              ),
          ],
        ),
      ),
    );
  }
}

/// Circle initial on the deep gradient.
class _Avatar extends StatelessWidget {
  const _Avatar(this.letter, {this.size = 34, this.fontSize = 13, this.fill});

  final String letter;
  final double size;
  final double fontSize;
  final Color? fill;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fill,
        gradient: fill == null ? TogetherGradient.deep : null,
      ),
      child: Text(letter, style: _dm(fontSize, Colors.white)),
    );
  }
}

/// Person row inside a group: avatar, name, trailing meta or subtitle.
class _PersonRow extends StatelessWidget {
  const _PersonRow(this.name, this.meta, {this.stacked = false});

  final String name;
  final String meta;

  /// Story viewers stack the meta under the name (38 avatar, h66).
  final bool stacked;

  @override
  Widget build(BuildContext context) {
    final metaStyle = _in(stacked ? 12 : 12.5, color: TogetherInk.meta);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          _Avatar(name[0],
              size: stacked ? 38 : 34, fontSize: stacked ? 14 : 13,),
          const SizedBox(width: 12),
          Expanded(
            child: stacked
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: _in(14, w: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(meta, style: metaStyle),
                    ],
                  )
                : Text(name, style: _in(14, w: FontWeight.w600)),
          ),
          if (!stacked) ...[
            const SizedBox(width: 12),
            Text(meta, style: metaStyle),
          ],
        ],
      ),
    );
  }
}

/// Category chips — selected #18181F, idle white with a #F0ECFC outline.
class _Chips extends StatelessWidget {
  const _Chips(this.labels, this.selected, this.onSelect,
      {this.small = false, this.idleFill = TogetherInk.surface, this.outlined = true,});

  final List<String> labels;
  final int selected;
  final ValueChanged<int> onSelect;

  /// Draw / Text tools: 12.5 labels, pad 10/14 (8/14 on the tools sheet).
  final bool small;
  final Color idleFill;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: small ? 10 : 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < labels.length; i++)
          GestureDetector(
            onTap: () => onSelect(i),
            child: Container(
              padding: small
                  ? const EdgeInsets.symmetric(horizontal: 14, vertical: 9)
                  : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: i == selected ? TogetherInk.ink : idleFill,
                borderRadius: BorderRadius.circular(14),
                border: i == selected || !outlined
                    ? null
                    : Border.all(color: TogetherInk.cardBorder),
              ),
              child: Text(
                labels[i],
                style: _in(small ? 12.5 : 13,
                    w: FontWeight.w600,
                    color: i == selected ? Colors.white : TogetherInk.body,),
              ),
            ),
          ),
      ],
    );
  }
}

/// 20px radio disc used on Share with / Date & time rows.
class _Radio extends StatelessWidget {
  const _Radio(this.on);
  final bool on;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: on ? TogetherInk.brand : null,
        border: Border.all(
          color: on ? TogetherInk.brand : TogetherInk.radioRing,
          width: 1.5,
        ),
      ),
    );
  }
}

/// Selectable r16/r18 row — #F6EFFE with a 1.5 violet stroke when selected.
class _SelectRow extends StatelessWidget {
  const _SelectRow({
    required this.selected,
    required this.child,
    this.onTap,
    this.radius = 16,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    this.shadow = false,
  });

  final bool selected;
  final Widget child;
  final VoidCallback? onTap;
  final double radius;
  final EdgeInsets padding;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: selected ? TogetherInk.selectTint : TogetherInk.surface,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: selected ? TogetherInk.brand : TogetherInk.cardBorder,
            width: selected ? 1.5 : 1,
          ),
          boxShadow: shadow ? _S.rowShadow : null,
        ),
        child: child,
      ),
    );
  }
}

/// White r16 field with a #F0ECFC outline.
class _Field extends StatelessWidget {
  const _Field({required this.child, this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14)});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: TogetherInk.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TogetherInk.cardBorder),
      ),
      child: child,
    );
  }
}

/// Label 13 SB over a field.
Widget _labelled(String label, Widget field) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _in(13, w: FontWeight.w600)),
        const SizedBox(height: 8),
        field,
      ],
    );

/// Search box — 41 high, r16, 16 glyph #B0AFB8, placeholder 14 #9999A8.
Widget _search(String hint) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: TogetherInk.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TogetherInk.cardBorder),
      ),
      child: Row(
        children: [
          const SmasherIcon(SmasherIcons.search, size: 16, color: _S.chevron),
          const SizedBox(width: 10),
          Text(hint, style: _in(14, color: TogetherInk.placeholder)),
        ],
      ),
    );

/// 22px violet check disc.
Widget _checkDisc([double size = 22]) => Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: TogetherInk.brand,
        shape: BoxShape.circle,
      ),
      child: SmasherIcon(SmasherIcons.tick, size: size * 0.55, color: Colors.white),
    );

/// Media placeholder — the file's warm gradient standing in for the photo.
Widget _media({double height = 240, double radius = 20, Widget? child}) =>
    Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: _S.media,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );

/// Privacy footnote — 13 violet glyph + 12.5 copy.
Widget _note(String text, {Color color = TogetherInk.meta, bool strong = false}) =>
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SmasherIcon(SmasherIcons.lockSmall, size: 13, color: TogetherInk.brand),
        const SizedBox(width: 6),
        Text(text,
            style: _in(12.5,
                w: strong ? FontWeight.w600 : FontWeight.w400, color: color,),),
      ],
    );

// ─── Demo data ───────────────────────────────────────────────────────────────

abstract final class DemoStories {
  static const circle = [
    (name: 'Ayesha', unseen: true),
    (name: 'Zara', unseen: true),
    (name: 'Bilal', unseen: false),
    (name: 'Sana', unseen: false),
  ];

  static const recent = [
    (
      name: 'Ayesha',
      time: '2h ago',
      text: 'A quiet evening at home, finally.',
      accent: Color(0xFF8B5CF6),
      photo: true,
    ),
    (
      name: 'Zara',
      time: '5h ago',
      text: 'Coffee, sunshine, and nowhere to be.',
      accent: Color(0xFFECB380),
      photo: false,
    ),
    (
      name: 'Bilal',
      time: '1d ago',
      text: 'Weekend hike — legs are done for.',
      accent: Color(0xFF7AB19E),
      photo: true,
    ),
  ];
}

// ─── 01 / 02 / 42 — Stories home ────────────────────────────────────────────

/// Stories tab. [empty] is P06 02; [offline] is P06 42.
class StoriesActiveHome extends StatelessWidget {
  const StoriesActiveHome({super.key, this.empty = false, this.offline = false});

  final bool empty;
  final bool offline;

  @override
  Widget build(BuildContext context) {
    const head = ModuleHead(
      title: 'Stories',
      description: 'Private moments shared with your circle.',
    );
    if (empty) {
      return ModuleScaffold(
        showWash: false,
        emptyState: true,
        header: const ModuleHeader(circleName: 'Our Circle'),
        children: [
          head,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const RoundTile(size: 64, icon: SmasherIcons.stories, iconSize: 26),
              const SizedBox(height: 16),
              Text('Nothing shared yet', style: _dm(19)),
              const SizedBox(height: 8),
              Text(
                'Stories shared with your circle will appear here.',
                textAlign: TextAlign.center,
                style: _in(13.5, color: TogetherInk.body),
              ),
              const SizedBox(height: 24),
              TogetherButton(
                label: 'Share a story',
                onPressed: () => _go(context, Routes.createStory),
              ),
              const SizedBox(height: 10),
              _GhostButton('Not now', () => _go(context, Routes.storiesCaughtUp)),
            ],
          ),
        ],
      );
    }
    return ModuleScaffold(
      showWash: false,
      header: const ModuleHeader(circleName: 'Our Circle'),
      gap: 20,
      children: [
        if (offline)
          const OfflineBanner(message: 'Reconnect to share your story.'),
        head,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _eyebrow('FROM YOUR CIRCLE'),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TrayItem.add(
                    onTap: () => _go(context, Routes.createStory),
                    onLongPress: () => _go(context, Routes.myStory),
                  ),
                  for (final p in DemoStories.circle) ...[
                    const SizedBox(width: 16),
                    _TrayItem(
                      name: p.name,
                      unseen: p.unseen,
                      onTap: () => _go(context, Routes.storyViewer),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _eyebrow('RECENT')),
                GestureDetector(
                  onTap: () => _go(context, Routes.storiesArchive),
                  child: Text(
                    'Past stories',
                    style: _in(
                      12.5,
                      w: FontWeight.w600,
                      color: TogetherInk.brand,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final s in DemoStories.recent) ...[
              _JournalCard(
                name: s.name,
                time: s.time,
                text: s.text,
                accent: s.accent,
                photo: s.photo,
                onTap: () => _go(context, Routes.storyViewer),
              ),
              const SizedBox(height: 14),
            ],
          ],
        ),
      ],
    );
  }
}

/// Tertiary button — no fill, #52525E label.
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
          style: TogetherText.button.copyWith(color: const Color(0xFF52525E)),
        ),
      ),
    );
  }
}

/// 60px tray item — ring 60 (1.5 #BFBACC add/idle, 2 #7C3AED unseen,
/// 1.5 #DEDBE5 seen) around a 50px disc.
class _TrayItem extends StatelessWidget {
  const _TrayItem({
    required this.name,
    required this.unseen,
    this.onTap,
  })  : add = false,
        onLongPress = null;

  const _TrayItem.add({this.onTap, this.onLongPress})
      : name = 'Your Story',
        unseen = false,
        add = true;

  final String name;
  final bool unseen;
  final bool add;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final ring = add
        ? Border.all(color: _S.ringIdle, width: 1.5)
        : unseen
            ? Border.all(color: TogetherInk.brand, width: 2)
            : Border.all(
                color: name == 'Bilal' ? _S.ringSeen : _S.ringIdle, width: 1.5,);
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: 60,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, border: ring),
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: add ? TogetherInk.page : null,
                  gradient: add ? null : TogetherGradient.deep,
                ),
                child: Text(
                  add ? '+' : name[0],
                  style: _dm(add ? 20 : 18, add ? TogetherInk.brand : Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
              style: _in(add ? 9.5 : 11, color: TogetherInk.meta),
            ),
            if (add)
              Text('Add a story',
                  softWrap: false,
                  style: _in(8, color: const Color(0xFF9999A6)),),
          ],
        ),
      ),
    );
  }
}

/// Journal card — white r20, 4px accent rule, 30px avatar, DM 15.5 text,
/// optional 64 r12 thumbnail, circle footer.
class _JournalCard extends StatelessWidget {
  const _JournalCard({
    required this.name,
    required this.time,
    required this.text,
    required this.accent,
    required this.photo,
    this.onTap,
  });

  final String name;
  final String time;
  final String text;
  final Color accent;
  final bool photo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: TogetherInk.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: _S.cardShadow,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4, color: accent),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _Avatar(name[0], size: 30, fontSize: 12),
                          const SizedBox(width: 10),
                          Text(name, style: _in(13, w: FontWeight.w600)),
                          const SizedBox(width: 8),
                          Text(time,
                              style: _in(11.5, color: TogetherInk.placeholder),),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Text(text, style: _dm(15.5))),
                          if (photo) ...[
                            const SizedBox(width: 16),
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                gradient: _S.media,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const SmasherIcon(SmasherIcons.peopleLine,
                              size: 11, color: _S.chevron,),
                          const SizedBox(width: 5),
                          Text('Our Circle',
                              style: _in(11, color: TogetherInk.placeholder),),
                        ],
                      ),
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

// ─── 03 — Create a story ────────────────────────────────────────────────────

class CreateStoryScreen extends StatelessWidget {
  const CreateStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Create a story',
      children: [
        _lead('Share something with your private circle.'),
        _ChoiceCard(
          icon: SmasherIcons.textType,
          title: 'Text',
          subtitle: 'Share a thought',
          onTap: () => _go(context, Routes.textStory),
        ),
        _ChoiceCard(
          icon: SmasherIcons.image,
          title: 'Photo',
          subtitle: 'Share a moment',
          onTap: () => _go(context, Routes.storyMediaPicker),
        ),
        _ChoiceCard(
          icon: SmasherIcons.video,
          title: 'Video',
          subtitle: 'Share a short moment',
          onTap: () => _go(context, Routes.videoStory),
        ),
      ],
    );
  }
}

// ─── Dark editors (04 / 05 / 15 / 37) ───────────────────────────────────────

/// Full-bleed editor: close + menu glyphs top, content, 60px toolbar, 46px
/// Preview button.
class _DarkEditor extends StatelessWidget {
  const _DarkEditor({
    required this.background,
    required this.body,
    this.toolbar,
    this.onMenu,
    this.onPreview,
    this.menuIcon = SmasherIcons.moreHorizontal,
  });

  final Color background;
  final Widget body;
  final Widget? toolbar;
  final VoidCallback? onMenu;
  final VoidCallback? onPreview;
  final String menuIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
          child: Column(
            children: [
              Row(
                children: [
                  _GlyphButton(SmasherIcons.cross, 20, () => _pop(context)),
                  const Spacer(),
                  _GlyphButton(menuIcon, 18, onMenu),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(child: body),
              if (toolbar != null) ...[
                const SizedBox(height: 16),
                toolbar!,
              ],
              if (onPreview != null) ...[
                const SizedBox(height: 16),
                _PreviewButton(onPreview!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _GlyphButton extends StatelessWidget {
  const _GlyphButton(this.icon, this.size, this.onTap, {this.color = Colors.white});
  final String icon;
  final double size;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 32,
        height: 32,
        child: Center(child: SmasherIcon(icon, size: size, color: color)),
      ),
    );
  }
}

/// 342x46 #7C3AED pill (on the violet text story it reads as a white rim).
class _PreviewButton extends StatelessWidget {
  const _PreviewButton(this.onTap);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: Material(
        color: TogetherInk.brand,
        shape: const StadiumBorder(
          side: BorderSide(color: Color(0x33FFFFFF)),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: Center(
            child: Text('Preview',
                style: TogetherText.button.copyWith(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}

/// 342x60 white@10% r20 toolbar with evenly spaced tools.
class _Toolbar extends StatelessWidget {
  const _Toolbar(this.tools, {this.selected, this.labelSize = 10});

  final List<(String?, String, VoidCallback?)> tools;
  final int? selected;
  final double labelSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          for (var i = 0; i < tools.length; i++)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: tools[i].$3,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  decoration: BoxDecoration(
                    color: i == selected ? const Color(0x26FFFFFF) : null,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (tools[i].$1 != null) ...[
                        SmasherIcon(tools[i].$1!, size: 18, color: Colors.white),
                        const SizedBox(height: 4),
                      ],
                      Text(tools[i].$2,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.visible,
                          style: _in(labelSize, color: Colors.white),),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// P06 04 — Text story on #7C3AED.
class TextStoryScreen extends StatefulWidget {
  const TextStoryScreen({super.key});

  @override
  State<TextStoryScreen> createState() => _TextStoryScreenState();
}

class _TextStoryScreenState extends State<TextStoryScreen> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DarkEditor(
      background: _S.textStory,
      onMenu: () => _go(context, Routes.storyTextTools),
      onPreview: () => _go(context, Routes.storyPreview),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: TextField(
                controller: _text,
                maxLength: 280,
                maxLines: null,
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                onChanged: (_) => setState(() {}),
                style: _in(22, color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  hintText: "Write something you'd\nlike to share…",
                  hintMaxLines: 2,
                  hintStyle: _in(22, color: const Color(0xD9FFFFFF)),
                ),
              ),
            ),
          ),
          Text(
            '${_text.text.length} / 280',
            style: _in(11, color: const Color(0x99FFFFFF)),
          ),
        ],
      ),
      toolbar: _Toolbar(
        [
          (null, 'Style', () => _go(context, Routes.storyTextTools)),
          (null, 'Size', () => _go(context, Routes.storyTextTools)),
          (null, 'Align', () => _go(context, Routes.storyTextTools)),
          (null, 'Color', () => _go(context, Routes.storyTextTools)),
          (null, 'Background', () => _go(context, Routes.storyBackgrounds)),
        ],
        selected: 0,
        labelSize: 12,
      ),
    );
  }
}

/// P06 05 — Photo story on #17141C.
class PhotoStoryScreen extends StatelessWidget {
  const PhotoStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _DarkEditor(
      background: _S.photoStory,
      onMenu: () => _go(context, Routes.storyMore),
      onPreview: () => _go(context, Routes.storyEditor),
      body: GestureDetector(
        onTap: () => _go(context, Routes.storyFilters),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 500),
            child: _media(height: double.infinity),
          ),
        ),
      ),
      toolbar: _Toolbar([
        (SmasherIcons.pen, 'Draw', () => _go(context, Routes.storyDraw)),
        (SmasherIcons.music, 'Music', () => _go(context, Routes.storyMusic)),
        (SmasherIcons.textType, 'Text', () => _go(context, Routes.storyTextTools)),
        (SmasherIcons.sticker, 'Sticker', () => _go(context, Routes.storyStickers)),
        (SmasherIcons.layoutGrid, 'Layout', () => _go(context, Routes.storyLayout)),
        (SmasherIcons.moreHorizontal, 'More', () => _go(context, Routes.storyMore)),
      ]),
    );
  }
}

/// P06 15 — Video story: 64px play disc, scrubber, toolbar.
class VideoStoryScreen extends StatefulWidget {
  const VideoStoryScreen({super.key});

  @override
  State<VideoStoryScreen> createState() => _VideoStoryScreenState();
}

class _VideoStoryScreenState extends State<VideoStoryScreen> {
  bool _playing = false;

  @override
  Widget build(BuildContext context) {
    return _DarkEditor(
      background: _S.photoStory,
      onMenu: () => _go(context, Routes.storyMore),
      onPreview: () => _go(context, Routes.storyEditor),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => setState(() => _playing = !_playing),
                child: Container(
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0x26FFFFFF),
                    shape: BoxShape.circle,
                  ),
                  child: SmasherIcon(
                    _playing ? SmasherIcons.pause : SmasherIcons.play,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: const SizedBox(
              width: double.infinity,
              height: 4,
              child: Stack(
                children: [
                  Positioned.fill(child: ColoredBox(color: Color(0x40FFFFFF))),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 140 / 342,
                    child: ColoredBox(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      toolbar: _Toolbar([
        (SmasherIcons.scissors, 'Trim', () => _go(context, Routes.storyAdjust)),
        (SmasherIcons.music, 'Audio', () => _go(context, Routes.storyVoice)),
        (SmasherIcons.textType, 'Text', () => _go(context, Routes.storyTextTools)),
        (SmasherIcons.sticker, 'Sticker', () => _go(context, Routes.storyStickers)),
        (SmasherIcons.moreHorizontal, 'More', () => _go(context, Routes.storyMore)),
      ]),
    );
  }
}

/// P06 37 — Text tools sheet over the text story.
class TextToolsScreen extends StatefulWidget {
  const TextToolsScreen({super.key});

  @override
  State<TextToolsScreen> createState() => _TextToolsScreenState();
}

class _TextToolsScreenState extends State<TextToolsScreen> {
  int _style = 0;
  int _align = 1;
  int _color = 0;

  static const _swatches = [
    Colors.white,
    Color(0xFF18181F),
    Color(0xFF7C3AED),
    Color(0xFFECB380),
    Color(0xFF7AB19E),
  ];

  @override
  Widget build(BuildContext context) {
    return _DarkEditor(
      background: _S.textStory,
      menuIcon: SmasherIcons.tick,
      onMenu: () => _pop(context),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Write something\nyou'd like to share…",
                textAlign: [TextAlign.left, TextAlign.center, TextAlign.right][_align],
                style: _dm(30, _swatches[_color] == const Color(0xFF7C3AED)
                    ? Colors.white
                    : _swatches[_color],),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: TogetherInk.surface,
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x2E000000),
                  offset: Offset(0, 8),
                  blurRadius: 24,
                  spreadRadius: -4,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Chips(
                  const ['Smasher', 'Minimal', 'Quote', 'Bold'],
                  _style,
                  (i) => setState(() => _style = i),
                  small: true,
                  idleFill: TogetherInk.page,
                  outlined: false,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    for (final (i, icon) in const [
                      SmasherIcons.alignCenter,
                      SmasherIcons.fontSize,
                      SmasherIcons.palette,
                    ].indexed) ...[
                      GestureDetector(
                        onTap: () => setState(() => _align = i),
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: i == _align
                                ? TogetherInk.lilacTile
                                : TogetherInk.page,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SmasherIcon(icon,
                              size: 18, color: TogetherInk.ink,),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    for (var i = 0; i < _swatches.length; i++) ...[
                      GestureDetector(
                        onTap: () => setState(() => _color = i),
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: _swatches[i],
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: i == _color
                                  ? TogetherInk.brand
                                  : const Color(0xFFE5E5E8),
                              width: i == _color ? 2 : 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 06 / 07 / 27 / 08 / 28 — Edit, preview, publish ───────────────────────

class StoryEditorScreen extends StatelessWidget {
  const StoryEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Edit story',
      gap: 18,
      bottom: [
        TogetherButton(
          label: 'Preview story',
          onPressed: () => _go(context, Routes.storyPreview),
        ),
      ],
      children: [
        GestureDetector(
          onTap: () => _go(context, Routes.storyFilters),
          child: _media(),
        ),
        _labelled(
          'Caption',
          _Field(
            child: Text('A quiet evening at home, finally.', style: _in(14)),
          ),
        ),
        _labelled(
          'Share with',
          GestureDetector(
            onTap: () => _go(context, Routes.storyPrivacy),
            child: _Field(
              child: Row(
                children: [
                  const SmasherIcon(SmasherIcons.peopleLine,
                      size: 16, color: TogetherInk.brand,),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('Our Circle · 3 members',
                        style: _in(14, w: FontWeight.w600),),
                  ),
                  const SmasherIcon(SmasherIcons.chevronSmall,
                      size: 14, color: _S.chevron,),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: TogetherInk.page,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const SmasherIcon(SmasherIcons.time,
                  size: 16, color: TogetherInk.brand,),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Available for 24 hours',
                        style: _in(13.5, w: FontWeight.w600),),
                    const SizedBox(height: 1),
                    Text('Disappears automatically after 24 hours.',
                        style: _in(11.5, color: TogetherInk.meta),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// P06 07 (and 27 while sharing) — the story card before it goes out.
class StoryPreviewScreen extends StatelessWidget {
  const StoryPreviewScreen({super.key, this.publishing = false});

  final bool publishing;

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Preview',
      gap: 16,
      bottom: [
        TogetherButton(
          label: publishing ? 'Sharing…' : 'Share story',
          onPressed: publishing
              ? () {}
              : () => _swap(context, Routes.storyPublishing),
        ),
        TogetherButton(
          label: 'Edit story',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        _media(
          height: 320,
          child: publishing
              ? null
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        const _Avatar('A',
                            size: 32, fontSize: 13, fill: TogetherInk.ink,),
                        const SizedBox(width: 10),
                        Text('Ayesha', style: _in(13.5, w: FontWeight.w600)),
                        const SizedBox(width: 8),
                        Text('2m ago',
                            style: _in(11.5, color: TogetherInk.body),),
                      ],
                    ),
                  ),
                ),
        ),
        if (!publishing) ...[
          Text('A quiet evening at home, finally.', style: _in(13.5)),
          _note('Our Circle · Private', color: TogetherInk.brand, strong: true),
        ],
      ],
    );
  }
}

/// P06 27 — Sharing… then on to Published (or 28 on failure).
class StoryPublishingScreen extends StatefulWidget {
  const StoryPublishingScreen({super.key});

  @override
  State<StoryPublishingScreen> createState() => _StoryPublishingScreenState();
}

class _StoryPublishingScreenState extends State<StoryPublishingScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1400), () {
      if (mounted) _swap(context, Routes.storyPublished);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      const StoryPreviewScreen(publishing: true);
}

class StoryPublishedScreen extends StatelessWidget {
  const StoryPublishedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StoryState(
      icon: SmasherIcons.successCheck,
      tile: TogetherInk.successTint,
      ink: const Color(0xFF1F9254),
      title: 'Story shared',
      titleSize: 24,
      body: 'Your story is now visible to your circle.',
      top: 200,
      actions: [
        TogetherButton(
          label: 'View story',
          onPressed: () => _swap(context, Routes.myStory),
        ),
        TogetherButton(
          label: 'Back to Stories',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _toStories(context),
        ),
      ],
    );
  }
}

class StoryUploadErrorScreen extends StatelessWidget {
  const StoryUploadErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StoryState(
      icon: SmasherIcons.alertCircle,
      tile: TogetherInk.errorTint,
      ink: TogetherInk.errorGlyph,
      tileSize: 56,
      title: "Couldn't share your story",
      body: "Your story wasn't shared. Check your connection and try again.",
      bodySize: 13.5,
      gap: 16,
      actions: [
        TogetherButton(
          label: 'Try again',
          onPressed: () => _swap(context, Routes.storyPublishing),
        ),
        TogetherButton(
          label: 'Edit story',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _swap(context, Routes.storyEditor),
        ),
      ],
    );
  }
}

// ─── 09 / 25 / 39 / 40 — Viewer ─────────────────────────────────────────────

/// Full-screen story: progress bars, author row, DM 26 text.
class _ViewerFrame extends StatelessWidget {
  const _ViewerFrame({
    required this.author,
    required this.time,
    required this.text,
    required this.footer,
    this.textSize = 26,
    this.progress = 1,
    this.onMenu,
  });

  final String author;
  final String time;
  final String text;
  final Widget footer;
  final double textSize;
  final int progress;
  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4C1D95),
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: TogetherGradient.deep),
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 10, 24, 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        for (var i = 0; i < 4; i++) ...[
                          Expanded(
                            child: Container(
                              height: 3,
                              decoration: BoxDecoration(
                                color: i == progress
                                    ? Colors.white
                                    : const Color(0x4DFFFFFF),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          if (i != 3) const SizedBox(width: 4),
                        ],
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _Avatar(author[0],
                            size: 32,
                            fontSize: 13,
                            fill: const Color(0x40FFFFFF),),
                        const SizedBox(width: 10),
                        Text(author == 'You' ? 'Your story' : author,
                            style: _in(14,
                                w: FontWeight.w600, color: Colors.white,),),
                        const SizedBox(width: 8),
                        Text(time,
                            style: _in(11.5, color: const Color(0xBFFFFFFF)),),
                        const Spacer(),
                        if (onMenu != null)
                          _GlyphButton(SmasherIcons.moreHorizontal, 18, onMenu),
                        _GlyphButton(
                            SmasherIcons.cross, 20, () => _pop(context),),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 310,
                          child: Text(text,
                              textAlign: TextAlign.center,
                              style: _dm(textSize, Colors.white),),
                        ),
                      ),
                    ),
                    footer,
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

class StoryViewerScreen extends StatelessWidget {
  const StoryViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (d) {
        if ((d.primaryVelocity ?? 0) < -200) _go(context, Routes.storyReply);
      },
      child: _ViewerFrame(
        author: 'Ayesha',
        time: '2h ago',
        text: 'A quiet evening at home, finally.',
        onMenu: () => _go(context, Routes.storyReply),
        footer: Row(
          children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _go(context, Routes.storyReply),
                child: const SizedBox(height: 52),
              ),
            ),
            GestureDetector(
              onTap: () => _go(context, Routes.storyReaction),
              child: Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0x2EFFFFFF),
                  shape: BoxShape.circle,
                ),
                child: const SmasherIcon(SmasherIcons.heartOutline,
                    size: 22, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// P06 25 — your own story, with the viewer count bar.
class MyStoryScreen extends StatelessWidget {
  const MyStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ViewerFrame(
      author: 'You',
      time: '2h ago',
      text: 'A quiet evening at home, finally.',
      progress: 0,
      footer: GestureDetector(
        onTap: () => _go(context, Routes.storyActivity),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: const Color(0x26FFFFFF),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              const SmasherIcon(SmasherIcons.eyeLine, size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text('3 people viewed this',
                    style: _in(13.5, w: FontWeight.w600, color: Colors.white),),
              ),
              _GlyphButton(SmasherIcons.moreHorizontal, 18,
                  () => _go(context, Routes.storyOptions),),
            ],
          ),
        ),
      ),
    );
  }
}

/// P06 39 — reaction bar over the viewer.
class StoryReactionScreen extends StatelessWidget {
  const StoryReactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void react() {
      final messenger = ScaffoldMessenger.of(context);
      _pop(context);
      messenger.showSnackBar(const SnackBar(content: Text('Reaction sent')));
    }

    return _ViewerFrame(
      author: 'Ayesha',
      time: '2h ago',
      text: 'A quiet evening at home, finally.',
      footer: Center(
        child: Container(
          width: 280,
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: TogetherInk.surface,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                offset: Offset(0, 8),
                blurRadius: 24,
                spreadRadius: -4,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final icon in const [
                SmasherIcons.heartOutline,
                SmasherIcons.smile,
                SmasherIcons.fire,
                SmasherIcons.thumbsUp,
                SmasherIcons.sparkleOutline,
              ])
                _GlyphButton(icon, 22, react, color: TogetherInk.brand),
            ],
          ),
        ),
      ),
    );
  }
}

/// P06 40 — reply field over the viewer.
class StoryReplyScreen extends StatelessWidget {
  const StoryReplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ViewerFrame(
      author: 'Ayesha',
      time: '2h ago',
      text: 'A quiet evening at home, finally.',
      textSize: 24,
      footer: Container(
        height: 48,
        padding: const EdgeInsets.fromLTRB(18, 8, 8, 8),
        decoration: BoxDecoration(
          color: const Color(0x26FFFFFF),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0x4DFFFFFF)),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: false,
                cursorColor: Colors.white,
                style: _in(14, color: Colors.white),
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: "Reply to Ayesha's story…",
                  hintStyle: _in(14, color: const Color(0xCCFFFFFF)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _swap(context, Routes.storyReplyRef),
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const SmasherIcon(SmasherIcons.sendSmall,
                    size: 15, color: TogetherInk.brand,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── 10 / 24 / 11 / 12 / 13 / 14 / 38 — Viewers, options, states ──────────

class StoryViewersScreen extends StatelessWidget {
  const StoryViewersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Story viewers',
      children: [
        _lead('People in your circle who viewed this story.'),
        const SettingsGroup(children: [
          _PersonRow('Ayesha', 'Viewed 12 min ago', stacked: true),
          _PersonRow('Zara', 'Viewed 28 min ago', stacked: true),
          _PersonRow('Bilal', 'Viewed 41 min ago', stacked: true),
        ],),
      ],
    );
  }
}

class StoryActivityScreen extends StatelessWidget {
  const StoryActivityScreen({super.key});

  Widget _section(String label, List<Widget> rows) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _eyebrow(label),
          const SizedBox(height: 10),
          SettingsGroup(children: rows),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Story activity',
      gap: 22,
      children: [
        _section('VIEWS', const [
          _PersonRow('Ayesha', '12 min ago'),
          _PersonRow('Zara', '24 min ago'),
        ]),
        _section('REACTIONS', const [_PersonRow('Bilal', '❤')]),
        _section('REPLIES', const [_PersonRow('Ayesha', 'Loved this')]),
      ],
    );
  }
}

class StoryOptionsScreen extends StatelessWidget {
  const StoryOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Story options',
      children: [
        SettingsGroup(children: [
          _ActionRow(SmasherIcons.eyeLine, 'View story',
              () => _swap(context, Routes.myStory),),
          _ActionRow(SmasherIcons.peopleLine, 'Viewers',
              () => _go(context, Routes.storyViewers),),
          _ActionRow(SmasherIcons.trash, 'Delete story',
              () => _go(context, Routes.deleteStory),
              danger: true,),
        ],),
      ],
    );
  }
}

/// Header/Back confirm page: 56 red tile, DM 24 title, danger + keep.
class _ConfirmPage extends StatelessWidget {
  const _ConfirmPage({
    required this.navTitle,
    required this.title,
    required this.body,
    required this.confirm,
    required this.keep,
    required this.onConfirm,
  });

  final String navTitle;
  final String title;
  final String body;
  final String confirm;
  final String keep;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return _page(
      title: navTitle,
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
        const RoundTile(
          size: 56,
          icon: SmasherIcons.trash,
          iconSize: 24,
          color: TogetherInk.errorTint,
          ink: TogetherInk.errorGlyph,
        ),
        const SizedBox(height: 4),
        Text(title, style: _dm(24)),
        Text(body, style: _in(14, color: TogetherInk.body)),
      ],
    );
  }
}

class DeleteStoryScreen extends StatelessWidget {
  const DeleteStoryScreen({super.key});

  @override
  Widget build(BuildContext context) => _ConfirmPage(
        navTitle: 'Delete story',
        title: 'Delete this story?',
        body: 'This story will be removed from your circle.',
        confirm: 'Delete story',
        keep: 'Keep story',
        onConfirm: () => Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.storyDeleted,
          (r) => r.isFirst,
        ),
      );
}

class StoryDeletedScreen extends StatelessWidget {
  const StoryDeletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StoryState(
      icon: SmasherIcons.trash,
      tile: TogetherInk.skeletonHome,
      ink: TogetherInk.body,
      title: 'Story deleted',
      titleSize: 24,
      body: 'Your story has been removed.',
      white: true,
      actions: [
        TogetherButton(
          label: 'Back to Stories',
          onPressed: () => _toStories(context),
        ),
      ],
    );
  }
}

class StoryExpiredScreen extends StatelessWidget {
  const StoryExpiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StoryState(
      icon: SmasherIcons.time,
      title: 'This story is no longer available',
      body: 'Stories are only available for a limited time.',
      white: true,
      actions: [
        TogetherButton(
          label: 'Back to Stories',
          onPressed: () => _toStories(context),
        ),
      ],
    );
  }
}

class StoriesCaughtUpScreen extends StatelessWidget {
  const StoriesCaughtUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StoryState(
      icon: SmasherIcons.successCheck,
      title: "You're all caught up",
      body: 'No new stories from your circle.',
      top: 260,
      gap: 16,
      actions: [
        TogetherButton(
          label: 'Back to Stories',
          onPressed: () => _toStories(context),
        ),
      ],
    );
  }
}

// ─── 16 / 17 — Media ────────────────────────────────────────────────────────

class StoryMediaPickerScreen extends StatefulWidget {
  const StoryMediaPickerScreen({super.key});

  @override
  State<StoryMediaPickerScreen> createState() => _StoryMediaPickerScreenState();
}

class _StoryMediaPickerScreenState extends State<StoryMediaPickerScreen> {
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
      bottom: [
        TogetherButton(
          label: 'Add',
          onPressed: () => _swap(
            context,
            _tab == 1 ? Routes.videoStory : Routes.photoStory,
          ),
        ),
      ],
      children: [
        _Chips(const ['Photos', 'Videos', 'Camera'], _tab, (i) {
          if (i == 2) {
            _go(context, Routes.storyMediaPermission);
            return;
          }
          setState(() => _tab = i);
        }),
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
                  decoration: BoxDecoration(
                    color: _tiles[i],
                    borderRadius: BorderRadius.circular(14),
                    border: i == _picked
                        ? Border.all(color: TogetherInk.brand, width: 2.5)
                        : null,
                  ),
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(8),
                  child: i == _picked ? _checkDisc() : null,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class StoryMediaPermissionScreen extends StatelessWidget {
  const StoryMediaPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StoryState(
      icon: SmasherIcons.image,
      tileSize: 56,
      title: 'Photo access is turned off',
      titleSize: 19,
      body:
          'Allow photo access in your device settings to choose media for your story.',
      bodySize: 13.5,
      top: 260,
      gap: 16,
      actions: [
        TogetherButton(
          label: 'Open Settings',
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Device settings not wired yet')),
          ),
        ),
        TogetherButton(
          label: 'Not now',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
    );
  }
}

// ─── 18–22, 30, 31 — Creative tools ─────────────────────────────────────────

class StoryBackgroundsScreen extends StatefulWidget {
  const StoryBackgroundsScreen({super.key});

  @override
  State<StoryBackgroundsScreen> createState() => _StoryBackgroundsScreenState();
}

class _StoryBackgroundsScreenState extends State<StoryBackgroundsScreen> {
  int _cat = 0;
  int _swatch = 0;

  static const _solid = [
    Color(0xFF7C3AED),
    Color(0xFFEDE6FD),
    Color(0xFFF6F0DE),
    Color(0xFFFFFFFF),
    Color(0xFFE5E5E8),
    Color(0xFF26242B),
    Color(0xFF0D0D0F),
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Background',
      bottom: [TogetherButton(label: 'Apply', onPressed: () => _pop(context))],
      children: [
        _Chips(const ['Solid', 'Gradient', 'Texture'], _cat,
            (i) => setState(() => _cat = i),),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (var i = 0; i < _solid.length; i++)
              GestureDetector(
                onTap: () => setState(() => _swatch = i),
                child: Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                    color: _cat == 0 ? _solid[i] : null,
                    gradient: _cat == 0
                        ? null
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [_solid[i], _solid[(i + 2) % _solid.length]],
                          ),
                    borderRadius: BorderRadius.circular(16),
                    border: i == _swatch
                        ? Border.all(color: TogetherInk.ink, width: 2.5)
                        : i == 3
                            ? Border.all(color: const Color(0xFFE5E5E8))
                            : null,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class StoryMusicScreen extends StatefulWidget {
  const StoryMusicScreen({super.key});

  @override
  State<StoryMusicScreen> createState() => _StoryMusicScreenState();
}

class _StoryMusicScreenState extends State<StoryMusicScreen> {
  int _picked = 0;

  static const _tracks = [
    ('Soft Hours', 'Wilder Skies'),
    ('Late Light', 'Moon Parlor'),
    ('Quiet Company', 'Amber Fields'),
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Add sound',
      gap: 18,
      bottom: [
        TogetherButton(label: 'Add sound', onPressed: () => _pop(context)),
        TogetherButton(
          label: 'Cancel',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        _search('Search music or sounds'),
        _eyebrow('CALM'),
        SettingsGroup(children: [
          for (var i = 0; i < _tracks.length; i++)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _picked = i),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    const RoundTile(
                        size: 40, radius: 12, icon: SmasherIcons.music, iconSize: 16,),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_tracks[i].$1, style: _in(14, w: FontWeight.w600)),
                          const SizedBox(height: 2),
                          Text(_tracks[i].$2,
                              style: _in(12, color: TogetherInk.meta),),
                        ],
                      ),
                    ),
                    if (i == _picked)
                      _checkDisc()
                    else
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: TogetherInk.page,
                          shape: BoxShape.circle,
                        ),
                        child: const SmasherIcon(SmasherIcons.play,
                            size: 10, color: TogetherInk.brand,),
                      ),
                  ],
                ),
              ),
            ),
        ],),
      ],
    );
  }
}

class StoryStickersScreen extends StatefulWidget {
  const StoryStickersScreen({super.key});

  @override
  State<StoryStickersScreen> createState() => _StoryStickersScreenState();
}

class _StoryStickersScreenState extends State<StoryStickersScreen> {
  int _cat = 0;

  static const _stickers = [
    'Private',
    'Together',
    'Tonight',
    'Our Circle',
    'Mood',
    'Date',
    'Time',
    'Question',
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Stickers',
      gap: 18,
      children: [
        _Chips(const ['Smasher', 'Mood', 'Moments'], _cat,
            (i) => setState(() => _cat = i),),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 107 / 76,
          children: [
            for (final s in _stickers)
              GestureDetector(
                onTap: () => _pop(context),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: TogetherInk.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D5C21B5),
                        offset: Offset(0, 3),
                        blurRadius: 12,
                        spreadRadius: -1,
                      ),
                    ],
                  ),
                  child: Text(s,
                      textAlign: TextAlign.center,
                      style: _in(12.5,
                          w: FontWeight.w600, color: TogetherInk.brand,),),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class StoryLayoutScreen extends StatefulWidget {
  const StoryLayoutScreen({super.key});

  @override
  State<StoryLayoutScreen> createState() => _StoryLayoutScreenState();
}

class _StoryLayoutScreenState extends State<StoryLayoutScreen> {
  int _picked = 0;

  Widget _cell(Color c) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  Widget _preview(int i) {
    const a = TogetherInk.lilacTile;
    const b = Color(0xFFF1EEF6);
    const g = SizedBox(width: 4, height: 4);
    return switch (i) {
      0 => Row(children: [_cell(a)]),
      1 => Row(children: [_cell(a), g, _cell(b)]),
      2 => Column(children: [_cell(a), g, _cell(b)]),
      _ => Column(children: [
          _cell(a),
          g,
          Expanded(child: Row(children: [_cell(b), g, _cell(a)])),
        ],),
    };
  }

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Layout',
      bottom: [TogetherButton(label: 'Use layout', onPressed: () => _pop(context))],
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 165 / 130,
          children: [
            for (var i = 0; i < 4; i++)
              GestureDetector(
                onTap: () => setState(() => _picked = i),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: TogetherInk.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: i == _picked
                          ? TogetherInk.brand
                          : TogetherInk.cardBorder,
                      width: i == _picked ? 2 : 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(child: _preview(i)),
                      if (i == _picked)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: _checkDisc(20),
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

class StoryFiltersScreen extends StatefulWidget {
  const StoryFiltersScreen({super.key});

  @override
  State<StoryFiltersScreen> createState() => _StoryFiltersScreenState();
}

class _StoryFiltersScreenState extends State<StoryFiltersScreen> {
  int _picked = 0;

  static const _filters = [
    ('Natural', Color(0xFFE5DBCC)),
    ('Warm', Color(0xFFDED6CC)),
    ('Soft', Color(0xFFD6D1CC)),
    ('Night', Color(0xFFCFCCCC)),
    ('Mono', Color(0xFFC7C7CC)),
    ('Violet', Color(0xFFBFC2CC)),
    ('Fade', Color(0xFFB8BDCC)),
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Filters',
      bottom: [
        TogetherButton(label: 'Done', onPressed: () => _pop(context)),
        TogetherButton(
          label: 'Adjust',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _go(context, Routes.storyAdjust),
        ),
      ],
      children: [
        Container(
          height: 260,
          decoration: BoxDecoration(
            color: _filters[_picked].$2,
            gradient: _picked == 0 ? _S.media : null,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: [
              for (var i = 0; i < _filters.length; i++) ...[
                GestureDetector(
                  onTap: () => setState(() => _picked = i),
                  child: SizedBox(
                    width: 64,
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: _filters[i].$2,
                            borderRadius: BorderRadius.circular(16),
                            border: i == _picked
                                ? Border.all(
                                    color: TogetherInk.brand, width: 2.5,)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _filters[i].$1,
                          style: _in(11,
                              w: i == _picked
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: i == _picked
                                  ? TogetherInk.brand
                                  : TogetherInk.meta,),
                        ),
                      ],
                    ),
                  ),
                ),
                if (i != _filters.length - 1) const SizedBox(width: 10),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class StoryDrawScreen extends StatefulWidget {
  const StoryDrawScreen({super.key});

  @override
  State<StoryDrawScreen> createState() => _StoryDrawScreenState();
}

class _StoryDrawScreenState extends State<StoryDrawScreen> {
  int _tool = 0;
  int _color = 1;
  double _thickness = 120 / 342;
  final _strokes = <List<Offset>>[];

  static const _colors = [
    Color(0xFF18181F),
    Color(0xFF7C3AED),
    Color(0xFFC4433D),
    Color(0xFF1F9154),
    Color(0xFFD98C26),
    Color(0xFFFFFFFF),
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Draw',
      bottom: [
        TogetherButton(label: 'Done', onPressed: () => _pop(context)),
      ],
      children: [
        GestureDetector(
          onPanStart: (d) => setState(() => _strokes.add([d.localPosition])),
          onPanUpdate: (d) =>
              setState(() => _strokes.last.add(d.localPosition)),
          child: Container(
            height: 340,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: TogetherInk.page,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: TogetherInk.cardBorder),
            ),
            child: CustomPaint(
              size: Size.infinite,
              painter: _InkPainter(
                _strokes,
                _tool == 3 ? TogetherInk.page : _colors[_color],
                2 + _thickness * 14,
              ),
            ),
          ),
        ),
        _Chips(const ['Pen', 'Marker', 'Highlight', 'Eraser'], _tool,
            (i) => setState(() => _tool = i),
            small: true,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var i = 0; i < _colors.length; i++)
              GestureDetector(
                onTap: () => setState(() => _color = i),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _colors[i],
                    shape: BoxShape.circle,
                    border: i == _color
                        ? Border.all(color: TogetherInk.ink, width: 2)
                        : i == 5
                            ? Border.all(color: const Color(0xFFE5E5E8))
                            : null,
                  ),
                ),
              ),
          ],
        ),
        Text('Thickness',
            style: _in(12.5, w: FontWeight.w600, color: TogetherInk.body),),
        _Slider(_thickness, (v) => setState(() => _thickness = v)),
      ],
    );
  }
}

class _InkPainter extends CustomPainter {
  _InkPainter(this.strokes, this.color, this.width);

  final List<List<Offset>> strokes;
  final Color color;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (final s in strokes) {
      final path = Path()..addPolygon(s, false);
      canvas.drawPath(path, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// 4px #E5E3ED track, #7C3AED fill, 16px white knob with a violet ring.
class _Slider extends StatelessWidget {
  const _Slider(this.value, this.onChanged, {this.knob = true});

  final double value;
  final ValueChanged<double> onChanged;
  final bool knob;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      void set(Offset p) =>
          onChanged((p.dx / box.maxWidth).clamp(0.0, 1.0));
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (d) => set(d.localPosition),
        onHorizontalDragUpdate: (d) => set(d.localPosition),
        child: SizedBox(
          height: knob ? 16 : 12,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: TogetherInk.skeleton,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Container(
                width: box.maxWidth * value,
                height: 4,
                decoration: BoxDecoration(
                  color: TogetherInk.brand,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              if (knob)
                Positioned(
                  left: (box.maxWidth * value - 8).clamp(0.0, box.maxWidth - 16),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: TogetherInk.brand, width: 2),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    },);
  }
}

class StoryAdjustScreen extends StatefulWidget {
  const StoryAdjustScreen({super.key});

  @override
  State<StoryAdjustScreen> createState() => _StoryAdjustScreenState();
}

class _StoryAdjustScreenState extends State<StoryAdjustScreen> {
  static const _defaults = {
    'Brightness': .55,
    'Contrast': .50,
    'Saturation': .60,
    'Warmth': .45,
  };
  late final _values = Map<String, double>.of(_defaults);

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Adjust',
      gap: 22,
      bottom: [
        TogetherButton(label: 'Done', onPressed: () => _pop(context)),
        TogetherButton(
          label: 'Reset',
          tone: TogetherButtonTone.secondary,
          onPressed: () => setState(() => _values.addAll(_defaults)),
        ),
      ],
      children: [
        _media(height: 200),
        for (final e in _values.entries)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(e.key, style: _in(13, w: FontWeight.w600)),
                  ),
                  Text('${(e.value * 100).round()}%',
                      style: _in(12, color: TogetherInk.placeholder),),
                ],
              ),
              const SizedBox(height: 8),
              _Slider(e.value, (v) => setState(() => _values[e.key] = v),
                  knob: false,),
            ],
          ),
      ],
    );
  }
}

// ─── 23 — Share with ────────────────────────────────────────────────────────

class StoryPrivacyScreen extends StatefulWidget {
  const StoryPrivacyScreen({super.key});

  @override
  State<StoryPrivacyScreen> createState() => _StoryPrivacyScreenState();
}

class _StoryPrivacyScreenState extends State<StoryPrivacyScreen> {
  int _picked = 0;

  static const _circles = [
    ('Our Circle', '3 members'),
    ('Weekend Circle', '4 members'),
    ('Partner', '1 person'),
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Share with',
      bottom: [
        TogetherButton(label: 'Continue', onPressed: () => _pop(context)),
      ],
      children: [
        _lead('Only selected members can view this story.'),
        for (var i = 0; i < _circles.length; i++)
          _SelectRow(
            selected: i == _picked,
            radius: 18,
            shadow: true,
            onTap: () => setState(() => _picked = i),
            child: Row(
              children: [
                const RoundTile(
                    size: 38, icon: SmasherIcons.peopleLine, iconSize: 16,),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_circles[i].$1, style: _in(15, w: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(_circles[i].$2,
                          style: _in(12.5, color: TogetherInk.meta),),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                _Radio(i == _picked),
              ],
            ),
          ),
      ],
    );
  }
}

// ─── 26 / 41 / 43 — Drafts ──────────────────────────────────────────────────

class StoryDraftsScreen extends StatelessWidget {
  const StoryDraftsScreen({super.key});

  Widget _draft(BuildContext context, Color thumb, String title, String meta) =>
      GestureDetector(
        onTap: () => _go(context, Routes.draftRecovery),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: TogetherInk.surface,
            borderRadius: BorderRadius.circular(18),
            boxShadow: _S.groupShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: thumb,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: _in(14.5, w: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(meta, style: _in(12, color: TogetherInk.meta)),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              const SmasherIcon(SmasherIcons.chevronSmall,
                  size: 16, color: _S.chevron,),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Drafts',
      gap: 16,
      children: [
        _lead('Continue creating a story.'),
        _draft(context, const Color(0xFFF0E5D9), 'Photo story',
            'Edited 12 min ago',),
        _draft(context, TogetherInk.lilacTile, 'Text story', 'Edited yesterday'),
      ],
    );
  }
}

class DeleteDraftScreen extends StatelessWidget {
  const DeleteDraftScreen({super.key});

  @override
  Widget build(BuildContext context) => _ConfirmPage(
        navTitle: 'Delete draft',
        title: 'Delete this draft?',
        body: 'Your unfinished story will be permanently removed.',
        confirm: 'Delete draft',
        keep: 'Keep draft',
        onConfirm: () {
          final messenger = ScaffoldMessenger.of(context);
          Navigator.of(context).popUntil((r) =>
              r.settings.name == Routes.storyDrafts || r.isFirst,);
          messenger.showSnackBar(
              const SnackBar(content: Text('Draft deleted')),);
        },
      );
}

class DraftRecoveryScreen extends StatelessWidget {
  const DraftRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StoryState(
      icon: SmasherIcons.edit,
      title: 'Continue your story?',
      titleSize: 22,
      body: 'You have an unfinished story.',
      gap: 12,
      bottom: [
        TogetherButton(
          label: 'Continue editing',
          onPressed: () => _swap(context, Routes.photoStory),
        ),
        TogetherButton(
          label: 'Discard draft',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _swap(context, Routes.deleteDraft),
        ),
      ],
    );
  }
}

// ─── 29 — Voice ─────────────────────────────────────────────────────────────

class StoryVoiceScreen extends StatefulWidget {
  const StoryVoiceScreen({super.key});

  @override
  State<StoryVoiceScreen> createState() => _StoryVoiceScreenState();
}

class _StoryVoiceScreenState extends State<StoryVoiceScreen> {
  Timer? _timer;
  int _seconds = 0;

  void _start() {
    _timer?.cancel();
    _timer = Timer.periodic(
        const Duration(seconds: 1), (_) => setState(() => _seconds++),);
    setState(() {});
  }

  void _stop() {
    _timer?.cancel();
    setState(() => _timer = null);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recording = _timer != null;
    final t = '${(_seconds ~/ 60).toString().padLeft(2, '0')}:'
        '${(_seconds % 60).toString().padLeft(2, '0')}';
    return _page(
      title: 'Add voice',
      gap: 24,
      padding: const EdgeInsets.fromLTRB(24, 140, 24, 24),
      bottom: [
        TogetherButton(
          label: 'Use recording',
          onPressed: _seconds == 0 ? null : () => _pop(context),
        ),
        TogetherButton(
          label: 'Cancel',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        Center(
          child: GestureDetector(
            onLongPressStart: (_) => _start(),
            onLongPressEnd: (_) => _stop(),
            onTap: recording ? _stop : _start,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 96,
              height: 96,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: recording ? TogetherInk.brand : TogetherInk.lilacTile,
                shape: BoxShape.circle,
              ),
              child: SmasherIcon(SmasherIcons.mic,
                  size: 34,
                  color: recording ? Colors.white : TogetherInk.brand,),
            ),
          ),
        ),
        Center(
          child: Text(
            recording ? 'Recording…' : 'Press and hold to record',
            style: _in(15, w: FontWeight.w600, color: TogetherInk.body),
          ),
        ),
        Center(child: Text(t, style: _dm(28))),
      ],
    );
  }
}

// ─── 32–36 — More options ───────────────────────────────────────────────────

class StoryMoreScreen extends StatelessWidget {
  const StoryMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'More',
      children: [
        SettingsGroup(children: [
          _ActionRow(SmasherIcons.pin, 'Add location',
              () => _go(context, Routes.storyLocation),
              chevron: false,),
          _ActionRow(SmasherIcons.calendarPlain, 'Add date',
              () => _go(context, Routes.storyDateTime),
              chevron: false,),
          _ActionRow(SmasherIcons.time, 'Add time',
              () => _go(context, Routes.storyDateTime),
              chevron: false,),
          _ActionRow(SmasherIcons.helpCircle, 'Add question',
              () => _go(context, Routes.storyQuestion),
              chevron: false,),
          _ActionRow(SmasherIcons.poll, 'Add poll',
              () => _go(context, Routes.storyPoll),
              chevron: false,),
          _ActionRow(SmasherIcons.note, 'Save draft',
              () => _go(context, Routes.storyDrafts),
              chevron: false,),
          _ActionRow(SmasherIcons.trash, 'Delete media',
              () => Navigator.of(context).popUntil((r) =>
                  r.settings.name == Routes.createStory || r.isFirst,),
              danger: true,
              chevron: false,),
        ],),
      ],
    );
  }
}

class StoryLocationScreen extends StatelessWidget {
  const StoryLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Add location',
      gap: 18,
      bottom: [
        TogetherButton(label: 'Add location', onPressed: () => _pop(context)),
        TogetherButton(
          label: 'Cancel',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        _search('Search location'),
        _SelectRow(
          selected: true,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const SmasherIcon(SmasherIcons.pin,
                  size: 18, color: TogetherInk.brand,),
              const SizedBox(width: 12),
              Text('Home', style: _in(14.5, w: FontWeight.w600)),
            ],
          ),
        ),
        _note('Private to your selected circle.'),
      ],
    );
  }
}

class StoryDateTimeScreen extends StatefulWidget {
  const StoryDateTimeScreen({super.key});

  @override
  State<StoryDateTimeScreen> createState() => _StoryDateTimeScreenState();
}

class _StoryDateTimeScreenState extends State<StoryDateTimeScreen> {
  int _picked = 0;

  @override
  Widget build(BuildContext context) {
    const options = ['Today', 'Custom date', 'Current time'];
    return _page(
      title: 'Date & time',
      gap: 12,
      bottom: [TogetherButton(label: 'Add', onPressed: () => _pop(context))],
      children: [
        for (var i = 0; i < options.length; i++)
          _SelectRow(
            selected: i == _picked,
            onTap: () => setState(() => _picked = i),
            child: Row(
              children: [
                Expanded(
                  child: Text(options[i], style: _in(14.5, w: FontWeight.w600)),
                ),
                const SizedBox(width: 12),
                _Radio(i == _picked),
              ],
            ),
          ),
      ],
    );
  }
}

class StoryQuestionScreen extends StatefulWidget {
  const StoryQuestionScreen({super.key});

  @override
  State<StoryQuestionScreen> createState() => _StoryQuestionScreenState();
}

class _StoryQuestionScreenState extends State<StoryQuestionScreen> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Add question',
      bottom: [
        TogetherButton(label: 'Add question', onPressed: () => _pop(context)),
        TogetherButton(
          label: 'Cancel',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          decoration: BoxDecoration(
            gradient: TogetherGradient.deep,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('QUESTION',
                  style: _in(11,
                      w: FontWeight.w600,
                      color: const Color(0xCCFFFFFF),
                      ls: 1.2,),),
              const SizedBox(height: 10),
              Text(
                _ctrl.text.isEmpty
                    ? "What's your ideal evening together?"
                    : _ctrl.text,
                style: _dm(18, Colors.white),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Field(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                controller: _ctrl,
                maxLength: 100,
                onChanged: (_) => setState(() {}),
                style: _in(14.5),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  hintText: 'Ask your circle something…',
                  hintStyle: _in(14.5, color: TogetherInk.placeholder),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('${_ctrl.text.length} / 100',
                style: _in(11.5, color: TogetherInk.placeholder),),
          ],
        ),
      ],
    );
  }
}

class StoryPollScreen extends StatefulWidget {
  const StoryPollScreen({super.key});

  @override
  State<StoryPollScreen> createState() => _StoryPollScreenState();
}

class _StoryPollScreenState extends State<StoryPollScreen> {
  final _options = ['Stay in', 'Go out'];

  Widget _value(String label, String value) => _labelled(
        label,
        _Field(child: Text(value, style: _in(14.5, w: FontWeight.w600))),
      );

  @override
  Widget build(BuildContext context) {
    return _page(
      title: 'Add poll',
      gap: 18,
      bottom: [
        TogetherButton(label: 'Add poll', onPressed: () => _pop(context)),
        TogetherButton(
          label: 'Cancel',
          tone: TogetherButtonTone.secondary,
          onPressed: () => _pop(context),
        ),
      ],
      children: [
        _value('Question', 'What should we do tonight?'),
        for (var i = 0; i < _options.length; i++)
          _value('Option ${i + 1}', _options[i]),
        if (_options.length < 3)
          GestureDetector(
            onTap: () => setState(() => _options.add('Order in')),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: TogetherInk.surface,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SmasherIcon(SmasherIcons.plus,
                      size: 14, color: TogetherInk.brand,),
                  const SizedBox(width: 8),
                  Text('Add a third option',
                      style: _in(13.5,
                          w: FontWeight.w600, color: TogetherInk.brand,),),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
