import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/together_tokens.dart';
import '../widgets/controls.dart';
import '../widgets/module.dart';
import '../widgets/structures.dart';
import '../widgets/primitives.dart';
import '../widgets/together.dart';

/// P04 — Moments module. Shares the P03 dialect (flat buttons, DM Sans nav
/// title, AUTO line heights) on the violet page wash.

// ─── Data ────────────────────────────────────────────────────────────────────

enum MomentStatus { confirmed, pending, cancelled, completed }

class Moment {
  const Moment({
    required this.title,
    required this.day,
    required this.weekday,
    required this.dateLabel,
    required this.time,
    required this.people,
    required this.location,
    this.note,
    this.status = MomentStatus.confirmed,
  });

  final String title;

  /// Day of August 2026.
  final int day;
  final String weekday;
  final String dateLabel;
  final String time;
  final String people;
  final String location;
  final String? note;
  final MomentStatus status;
}

abstract final class DemoMoments {
  static const dessert = Moment(
    title: 'Make a late-night dessert together',
    day: 29,
    weekday: 'Saturday',
    dateLabel: 'Saturday, August 29',
    time: '8:00 PM',
    people: 'Our Circle',
    location: 'At home',
    note: 'Bring the dessert ingredients.',
  );

  static const movieNight = Moment(
    title: 'Movie night',
    day: 29,
    weekday: 'Saturday',
    dateLabel: 'Saturday, August 29',
    time: '8:00 PM',
    people: 'Our Circle',
    location: 'At home',
    note: 'Bring the dessert ingredients.',
  );

  static const marathon = Moment(
    title: 'Movie marathon',
    day: 7,
    weekday: 'Friday',
    dateLabel: 'August 7, 2026',
    time: '8:00 PM',
    people: '2 people',
    location: 'At home',
    note: "Popcorn's on us.",
    status: MomentStatus.completed,
  );

  static const past = [
    (title: 'Coffee and a walk', meta: 'August 21  ·  Our Circle'),
    (title: 'Sunday brunch', meta: 'August 14  ·  Our Circle'),
    (title: 'Movie marathon', meta: 'August 7  ·  2 people'),
  ];

  /// Days in August 2026 that carry a dot in the calendar.
  static const dotted = {3, 8};

  /// The file's "today" (ringed) and the default selection (filled).
  static const today = 30;
  static const selected = 29;

  /// An already-booked slot the create form checks against.
  static const bookedDay = 30;
  static const bookedTime = '4:00 PM';
}

// ─── Shared pieces ───────────────────────────────────────────────────────────

const _cardShadow = [
  BoxShadow(
    color: Color(0x0F5C21B5), // 6%
    offset: Offset(0, 6),
    blurRadius: 18,
    spreadRadius: -2,
  ),
];

const _timelineShadow = [
  BoxShadow(
    color: Color(0x0D5C21B5), // 5%
    offset: Offset(0, 4),
    blurRadius: 14,
    spreadRadius: -2,
  ),
];

/// Uppercase 11.5 Semi Bold ls 1.2 #8A8A96 label.
class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text.toUpperCase(),
        style: TogetherText.eyebrow.copyWith(
          fontSize: 11.5,
          color: TogetherInk.counter,
        ),
      );
}

/// White card with the 6% violet shadow and no outline.
class _SoftCard extends StatelessWidget {
  const _SoftCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.radius = 20,
    this.shadow = _cardShadow,
  });

  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final List<BoxShadow> shadow;

  @override
  Widget build(BuildContext context) => OutlineCard(
        outlined: false,
        padding: padding,
        radius: radius,
        shadow: shadow,
        child: child,
      );
}

/// Title / meta / status — Moment Created, Cancel, Cancelled.
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.meta,
    this.status,
    this.compactStatus = false,
    this.padding = 20,
    this.radius = 20,
  });

  final String title;
  final String meta;
  final StatusPillTone? status;
  final bool compactStatus;
  final double padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return _SoftCard(
      padding: EdgeInsets.all(padding),
      radius: radius,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TogetherText.rowTitle),
          SizedBox(height: status == null ? 6 : 10),
          Text(meta, style: TogetherText.meta.copyWith(color: TogetherInk.body)),
          if (status != null) ...[
            SizedBox(height: compactStatus ? 10 : 8),
            StatusPill(status!, compact: compactStatus),
          ],
        ],
      ),
    );
  }
}

/// Centred confirmation layout (Moment Created / Cancelled).
class _Confirmation extends StatelessWidget {
  const _Confirmation({
    required this.top,
    required this.tile,
    required this.title,
    required this.titleStyle,
    required this.description,
    required this.card,
    required this.actions,
    this.gap = 24,
    this.plain = false,
  });

  final double top;
  final Widget tile;
  final String title;
  final TextStyle titleStyle;
  final String description;
  final Widget card;
  final List<Widget> actions;
  final double gap;

  /// P04 17 draws on a flat white body instead of the wash.
  final bool plain;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      showHeader: false,
      washed: !plain,
      background: plain ? TogetherInk.surface : TogetherInk.page,
      padding: EdgeInsets.fromLTRB(24, top, 24, 24),
      gap: gap,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        tile,
        Text(title, textAlign: TextAlign.center, style: titleStyle),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TogetherText.body.copyWith(color: TogetherInk.body),
        ),
        card,
        for (final a in actions) a,
      ],
    );
  }
}

// ─── P04 02 — Moments Home (active) ──────────────────────────────────────────

/// The Moments tab when there is something planned: ticket for the next
/// moment, then a TODAY / UPCOMING timeline.
///
/// The file has no entry points to Calendar, Create or Past Moments on this
/// screen, so two header buttons and a "Past moments" link are added in the
/// module's own vocabulary (the 44px white round button used for the bell).
class MomentsActiveHome extends StatelessWidget {
  const MomentsActiveHome({
    super.key,
    this.onOpen,
    this.onCalendar,
    this.onCreate,
    this.onPast,
  });

  final ValueChanged<Moment>? onOpen;
  final VoidCallback? onCalendar;
  final VoidCallback? onCreate;
  final VoidCallback? onPast;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: TogetherGradient.wash),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ModuleHeader(circleName: 'Our Circle'),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Moments',
                              style: TogetherText.pageTitle.copyWith(
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Plans you choose to share.',
                              style: TogetherText.body.copyWith(
                                color: TogetherInk.body,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RoundIconButton(
                        icon: SmasherIcons.calendar,
                        onPressed: onCalendar,
                      ),
                      const SizedBox(width: 8),
                      RoundIconButton(
                        icon: SmasherIcons.plus,
                        onPressed: onCreate,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const _Label('Up next'),
                  const SizedBox(height: 18),
                  _TicketCard(
                    moment: DemoMoments.dessert,
                    onTap: () => onOpen?.call(DemoMoments.dessert),
                  ),
                  const SizedBox(height: 22),
                  const _Label('Today'),
                  const SizedBox(height: 8),
                  _TimelineRow(
                    title: 'Movie night',
                    meta: 'Tonight · 8:00 PM · 2 people',
                    onTap: () => onOpen?.call(DemoMoments.movieNight),
                  ),
                  const SizedBox(height: 24),
                  const _Label('Upcoming'),
                  const SizedBox(height: 8),
                  _TimelineRow(
                    title: 'Picnic in the park',
                    meta: 'Sunday · 4:00 PM · Our Circle',
                    connectsDown: true,
                    onTap: () => onOpen?.call(DemoMoments.movieNight),
                  ),
                  const SizedBox(height: 12),
                  _TimelineRow(
                    title: 'Try that new ramen spot',
                    meta: 'Sept 3 · 7:30 PM · Our Circle',
                    pending: true,
                    onTap: () => onOpen?.call(DemoMoments.movieNight),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: onPast,
                    child: Row(
                      children: [
                        Text(
                          'Past moments',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Figma: Ticket Card — 342x150 r24, white, #5C21B5 9% y10 b24 s-4. A 92px
/// #18181F date stub, a dashed perforation with two notches, then time, title,
/// meta and status; a 16px chevron on the right edge.
class _TicketCard extends StatelessWidget {
  const _TicketCard({required this.moment, this.onTap});

  final Moment moment;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: TogetherInk.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x175C21B5),
              offset: Offset(0, 10),
              blurRadius: 24,
              spreadRadius: -4,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 92,
                child: Container(
                  color: TogetherInk.ink,
                  padding: const EdgeInsets.fromLTRB(20, 46, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moment.weekday.substring(0, 3).toUpperCase(),
                        style: TogetherText.small.copyWith(
                          color: TogetherInk.brand,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${moment.day}',
                        style: TogetherText.pageTitle.copyWith(
                          fontSize: 40,
                          height: 1.3,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Perforation: 2x5 dashes every 10px.
              for (var y = 8.0; y < 150; y += 10)
                Positioned(
                  left: 92,
                  top: y,
                  child: Container(
                    width: 2,
                    height: 5,
                    color: TogetherInk.skeleton,
                  ),
                ),
              for (final top in const [-7.0, 143.0])
                Positioned(
                  left: 85,
                  top: top,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: TogetherInk.pageAlt,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              Positioned(
                left: 116,
                top: 18,
                right: 36,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      moment.time,
                      style: TogetherText.fieldLabel.copyWith(
                        color: TogetherInk.brand,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      moment.title,
                      maxLines: 2,
                      style: TogetherText.rowTitle.copyWith(fontSize: 15.5),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${moment.people} · ${moment.location}',
                      style: TogetherText.small.copyWith(
                        fontWeight: FontWeight.w400,
                        color: TogetherInk.meta,
                      ),
                    ),
                    const SizedBox(height: 11),
                    const _MiniStatus(),
                  ],
                ),
              ),
              const Positioned(
                right: 8,
                top: 67,
                child: SmasherIcon(
                  SmasherIcons.chevronRightSmall,
                  size: 16,
                  color: Color(0xFFB0AFB8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Figma: Status Pill inside the ticket — r9, 5px dot, 10.5 label.
class _MiniStatus extends StatelessWidget {
  const _MiniStatus();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: TogetherInk.successTint,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: TogetherInk.success,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            'Confirmed',
            style: TogetherText.small.copyWith(
              fontSize: 10.5,
              color: TogetherInk.success,
            ),
          ),
        ],
      ),
    );
  }
}

/// Timeline row — 12px dot (white 2px ring) and a 292x60 r18 card with a
/// small status tag. [connectsDown] draws the 2px #E0DAF6 line to the next.
class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.title,
    required this.meta,
    this.pending = false,
    this.connectsDown = false,
    this.onTap,
  });

  final String title;
  final String meta;
  final bool pending;
  final bool connectsDown;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dot = pending ? TogetherInk.waitDot : TogetherInk.brand;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (connectsDown)
              const Positioned(
                left: 5,
                top: 12,
                child: SizedBox(
                  width: 2,
                  height: 72,
                  child: ColoredBox(color: Color(0xFFE0DAF6)),
                ),
              ),
            Positioned(
              left: 0,
              top: 6,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: dot,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
            Positioned(
              left: 26,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: TogetherInk.surface,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: _timelineShadow,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TogetherText.rowTitle.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            meta,
                            style: TogetherText.tiny.copyWith(
                              color: TogetherInk.meta,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 18,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: pending
                            ? TogetherInk.waitTint
                            : TogetherInk.lilacTile,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        pending ? 'Pending' : 'Confirmed',
                        style: TogetherText.small.copyWith(
                          fontSize: 10,
                          color: pending ? dot : TogetherInk.brand,
                        ),
                      ),
                    ),
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

// ─── P04 14 / 15 / 16 — Moments home states ──────────────────────────────────

enum MomentsHomeState { loading, error, offline }

class MomentsHomeStateScreen extends StatelessWidget {
  const MomentsHomeStateScreen({super.key, required this.state, this.onRetry});

  final MomentsHomeState state;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final body = switch (state) {
      MomentsHomeState.loading => const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(
              width: 140,
              height: 32,
              radius: 8,
              color: TogetherInk.skeletonHome,
            ),
            SizedBox(height: 18),
            Opacity(
              opacity: 0.7,
              child: SkeletonBox(
                height: 30,
                radius: 6,
                color: TogetherInk.skeletonHome,
              ),
            ),
            SizedBox(height: 18),
            SkeletonBox(height: 200, radius: 24, color: TogetherInk.skeletonHome),
            SizedBox(height: 18),
            SkeletonBox(height: 76, radius: 20, color: TogetherInk.skeletonHome),
            SizedBox(height: 18),
            SkeletonBox(height: 76, radius: 20, color: TogetherInk.skeletonHome),
          ],
        ),
      MomentsHomeState.error => Padding(
          padding: const EdgeInsets.only(top: 220),
          child: TogetherState(
            error: true,
            icon: SmasherIcons.errorCircle,
            title: "Couldn't load your moments",
            description: 'Check your connection and try again.',
            actions: [TogetherButton(label: 'Try again', onPressed: onRetry)],
          ),
        ),
      MomentsHomeState.offline => Column(
          children: [
            const OfflineBanner(
              message: "Some changes may not be available until you're "
                  'connected.',
            ),
            const SizedBox(height: 16),
            Opacity(
              opacity: 0.45,
              child: _SoftCard(
                radius: 22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saturday · 8:00 PM',
                      style: TogetherText.summaryTitle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DemoMoments.dessert.title,
                      style: TogetherText.meta.copyWith(
                        color: TogetherInk.body,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    };

    return Scaffold(
      backgroundColor: TogetherInk.page,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: TogetherGradient.wash),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ModuleHeader(circleName: 'Our Circle'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  child: body,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SmasherBottomNav(
        currentIndex: 1,
        badges: const {3: true},
        onTap: (_) => Navigator.of(context).maybePop(),
      ),
    );
  }
}

// ─── P04 03 / 04 / 13 — Calendar ─────────────────────────────────────────────

/// August 2026 month view. 03: no day chosen yet; tapping a day shows its
/// moments (04) or the "Nothing planned for this day" block (13).
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
    this.showDay = false,
    this.initialDay = DemoMoments.selected,
    this.onOpen,
    this.onPlan,
  });

  final bool showDay;
  final int initialDay;
  final ValueChanged<Moment>? onOpen;
  final VoidCallback? onPlan;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late int _day = widget.initialDay;
  late bool _showDay = widget.showDay;

  static const _weekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  Widget build(BuildContext context) {
    // August 1, 2026 is a Saturday → six leading blanks.
    const lead = 6;
    final weekday = _weekdays[(lead + _day - 1) % 7];
    final hasMoment = _day == DemoMoments.dessert.day;

    return TogetherScaffold(
      title: 'Calendar',
      washed: true,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      gap: 20,
      children: [
        Row(
          children: [
            const _MonthArrow(SmasherIcons.chevronLeftSmall),
            Expanded(
              child: Text(
                'August 2026',
                textAlign: TextAlign.center,
                style: TogetherText.stateTitle,
              ),
            ),
            const _MonthArrow(SmasherIcons.chevronRightSmall),
          ],
        ),
        _SoftCard(
          radius: 24,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shadow: const [
            BoxShadow(
              color: Color(0x0F5C21B5),
              offset: Offset(0, 6),
              blurRadius: 20,
              spreadRadius: -2,
            ),
          ],
          child: Column(
            children: [
              Row(
                children: [
                  for (final d in const ['S', 'M', 'T', 'W', 'T', 'F', 'S'])
                    Expanded(
                      child: SizedBox(
                        height: 24,
                        child: Center(
                          child: Text(
                            d,
                            style: TogetherText.small.copyWith(
                              color: TogetherInk.counter,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              for (var week = 0; week < 6; week++) ...[
                const SizedBox(height: 14),
                Row(
                  children: [
                    for (var col = 0; col < 7; col++)
                      Expanded(child: _cell(week * 7 + col - lead + 1)),
                  ],
                ),
              ],
            ],
          ),
        ),
        if (_showDay) ...[
          Text(
            '$weekday, August $_day',
            style: TogetherText.navTitle,
          ),
          if (hasMoment)
            GestureDetector(
              onTap: () => widget.onOpen?.call(DemoMoments.dessert),
              child: _SoftCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DemoMoments.dessert.time,
                      style: TogetherText.cta.copyWith(
                        color: TogetherInk.brand,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      DemoMoments.dessert.title,
                      style: TogetherText.summaryTitle,
                    ),
                    const SizedBox(height: 10),
                    const StatusPill(StatusPillTone.confirmed, compact: true),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  const RoundTile(
                    size: 52,
                    icon: SmasherIcons.calendarPlain,
                    iconSize: 22,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Nothing planned for this day',
                    textAlign: TextAlign.center,
                    style: TogetherText.summaryTitle,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Choose another day or create something new.',
                    textAlign: TextAlign.center,
                    style: TogetherText.meta.copyWith(color: TogetherInk.body),
                  ),
                  const SizedBox(height: 14),
                  TogetherButton(
                    label: 'Plan a moment',
                    onPressed: widget.onPlan,
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }

  /// Figma: Date Cell — 44 tall, r16. Past days #B8B5BF; selected fills
  /// #7C3AED with a white Semi Bold number; today gets a 32px 1.5 violet ring.
  Widget _cell(int day) {
    if (day < 1 || day > 31) return const SizedBox(height: 44);
    final selected = day == _day;
    final today = day == DemoMoments.today;
    final past = day < DemoMoments.today;
    final color = selected
        ? Colors.white
        : past
            ? const Color(0xFFB8B5BF)
            : TogetherInk.ink;
    return GestureDetector(
      onTap: () => setState(() {
        _day = day;
        _showDay = true;
      }),
      child: Container(
        height: 44,
        margin: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: selected ? TogetherInk.brand : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (today && !selected)
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: TogetherInk.brand, width: 1.5),
                ),
              ),
            Text(
              '$day',
              style: (selected || today
                      ? TogetherText.label
                      : TogetherText.body)
                  .copyWith(color: color),
            ),
            if (DemoMoments.dotted.contains(day))
              Positioned(
                bottom: 10,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: selected ? Colors.white : TogetherInk.brand,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MonthArrow extends StatelessWidget {
  const _MonthArrow(this.icon);

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: TogetherInk.surface,
        shape: BoxShape.circle,
        border: Border.all(color: TogetherInk.cardBorder),
      ),
      child: SmasherIcon(icon, size: 16, color: TogetherInk.ink),
    );
  }
}

// ─── P04 05 / 10 / 11 — Create / Edit Moment ─────────────────────────────────

/// Create (05) and Edit (10) share one form. Picking a date and time that
/// collides with a booked slot turns the time row red, shows the P04 11
/// warning and disables the button.
class MomentFormScreen extends StatefulWidget {
  const MomentFormScreen({
    super.key,
    this.editing = false,
    this.forceConflict = false,
    this.onSubmit,
  });

  final bool editing;

  /// Open in the P04 11 conflict state (gallery).
  final bool forceConflict;
  final VoidCallback? onSubmit;

  @override
  State<MomentFormScreen> createState() => _MomentFormScreenState();
}

class _MomentFormScreenState extends State<MomentFormScreen> {
  late DateTime _date = widget.forceConflict
      ? DateTime(2026, 8, DemoMoments.bookedDay)
      : DateTime(2026, 8, 29);
  late TimeOfDay _time = widget.forceConflict
      ? const TimeOfDay(hour: 16, minute: 0)
      : const TimeOfDay(hour: 20, minute: 0);

  static const _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String get _dateLabel =>
      '${_weekdays[_date.weekday - 1]}, ${_months[_date.month - 1]} '
      '${_date.day}';

  String get _timeLabel {
    final h = _time.hourOfPeriod == 0 ? 12 : _time.hourOfPeriod;
    final m = _time.minute.toString().padLeft(2, '0');
    return '$h:$m ${_time.period == DayPeriod.am ? 'AM' : 'PM'}';
  }

  bool get _conflict =>
      _date.month == 8 &&
      _date.day == DemoMoments.bookedDay &&
      _timeLabel == DemoMoments.bookedTime;

  ThemeData _pickerTheme(BuildContext context) => Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: TogetherInk.brand,
              onPrimary: Colors.white,
            ),
      );

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2026),
      lastDate: DateTime(2027, 12, 31),
      builder: (c, child) => Theme(data: _pickerTheme(c), child: child!),
    );
    if (d != null) setState(() => _date = d);
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (c, child) => Theme(data: _pickerTheme(c), child: child!),
    );
    if (t != null) setState(() => _time = t);
  }

  @override
  Widget build(BuildContext context) {
    final conflict = _conflict;
    return TogetherScaffold(
      title: widget.editing ? 'Edit Moment' : 'Create Moment',
      washed: true,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      gap: 18,
      bottom: [
        TogetherButton(
          label: widget.editing ? 'Save changes' : 'Create moment',
          onPressed: conflict ? null : widget.onSubmit,
        ),
      ],
      children: [
        Text(
          widget.editing
              ? 'Update the details of your shared plan.'
              : "Choose what you're planning and when you'd like to share it.",
          style: TogetherText.bodySmall.copyWith(color: TogetherInk.body),
        ),
        const PickerField(label: 'Moment', value: 'Movie night'),
        PickerField(
          label: 'Date',
          icon: SmasherIcons.calendar,
          value: _dateLabel,
          onTap: _pickDate,
        ),
        PickerField(
          label: 'Time',
          icon: SmasherIcons.time,
          value: _timeLabel,
          onTap: _pickTime,
          error: conflict,
          below: conflict
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 1),
                        child: SmasherIcon(
                          SmasherIcons.alertSmall,
                          size: 14,
                          color: TogetherInk.errorGlyph,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'You already have a moment planned at this '
                              'time.',
                              style: TogetherText.cta.copyWith(
                                color: TogetherInk.danger,
                              ),
                            ),
                            const SizedBox(height: 2),
                            GestureDetector(
                              onTap: _pickTime,
                              child: Text(
                                'Choose another time.',
                                style: TogetherText.cta.copyWith(
                                  color: TogetherInk.brand,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : null,
        ),
        const PickerField(
          label: 'Share with',
          icon: SmasherIcons.people,
          value: 'Our Circle · 3 members',
        ),
        PickerField(
          label: 'Location',
          icon: SmasherIcons.pin,
          value: widget.editing ? 'At home' : 'Add a location',
          placeholder: !widget.editing,
        ),
        NoteField(
          labelAbove: 'Note',
          minHeight: 60,
          hint: "Add anything you'd like to remember",
          controller: widget.editing
              ? TextEditingController(text: 'Bring the dessert ingredients.')
              : null,
        ),
      ],
    );
  }
}

// ─── P04 06 — Moment Created ─────────────────────────────────────────────────

class MomentCreatedScreen extends StatelessWidget {
  const MomentCreatedScreen({super.key, this.onView, this.onBack});

  final VoidCallback? onView;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return _Confirmation(
      top: 140,
      tile: const RoundTile(
        size: 72,
        icon: SmasherIcons.successCheck,
        iconSize: 32,
        color: TogetherInk.successTint,
        ink: TogetherInk.success,
      ),
      title: 'Moment created',
      titleStyle: TogetherText.pageTitle,
      description: 'Your plan has been added to your shared calendar.',
      card: const _SummaryCard(
        title: 'Movie night',
        meta: 'Saturday · 8:00 PM  ·  Our Circle',
        status: StatusPillTone.confirmed,
        compactStatus: true,
      ),
      actions: [
        TogetherButton(label: 'View moment', onPressed: onView),
        TogetherButton(
          label: 'Back to Moments',
          tone: TogetherButtonTone.secondary,
          onPressed: onBack,
        ),
      ],
    );
  }
}

// ─── P04 07 / 18 — Moment Detail ─────────────────────────────────────────────

class MomentDetailScreen extends StatelessWidget {
  const MomentDetailScreen({
    super.key,
    this.moment = DemoMoments.movieNight,
    this.onEdit,
    this.onCancel,
    this.onPlanSimilar,
  });

  final Moment moment;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;
  final VoidCallback? onPlanSimilar;

  @override
  Widget build(BuildContext context) {
    final completed = moment.status == MomentStatus.completed;
    Widget row(String icon, String label, String value) => Row(
          children: [
            RoundTile(
              size: 36,
              radius: 12,
              icon: icon,
              iconSize: 17,
              color: TogetherInk.selectTint,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TogetherText.tiny.copyWith(
                      color: TogetherInk.counter,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(value, style: TogetherText.fieldValue),
                ],
              ),
            ),
          ],
        );

    return TogetherScaffold(
      title: 'Moment',
      washed: !completed,
      background: completed ? TogetherInk.pageAlt : TogetherInk.page,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      gap: 20,
      children: [
        Text(moment.title, style: TogetherText.question),
        _SoftCard(
          radius: 22,
          shadow: const [
            BoxShadow(
              color: Color(0x0F5C21B5),
              offset: Offset(0, 8),
              blurRadius: 20,
              spreadRadius: -2,
            ),
          ],
          child: Column(
            children: [
              row(SmasherIcons.calendarPlain, 'DATE', moment.dateLabel),
              const SizedBox(height: 16),
              row(SmasherIcons.time, 'TIME', moment.time),
              const SizedBox(height: 16),
              row(SmasherIcons.people, 'PARTICIPANTS', moment.people),
              const SizedBox(height: 16),
              row(SmasherIcons.pin, 'LOCATION', moment.location),
              if (moment.note != null) ...[
                const SizedBox(height: 16),
                row(SmasherIcons.note, 'NOTE', moment.note!),
              ],
            ],
          ),
        ),
        StatusPill(
          completed ? StatusPillTone.completed : StatusPillTone.confirmed,
        ),
        if (completed)
          TogetherButton(
            label: 'Plan something similar',
            onPressed: onPlanSimilar,
          )
        else ...[
          TogetherButton(label: 'Edit moment', onPressed: onEdit),
          GestureDetector(
            onTap: onCancel,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Cancel moment',
                textAlign: TextAlign.center,
                style: TogetherText.label.copyWith(
                  color: TogetherInk.dangerText,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ─── P04 08 / 17 — Cancel ────────────────────────────────────────────────────

class CancelMomentScreen extends StatelessWidget {
  const CancelMomentScreen({super.key, this.onCancel, this.onKeep});

  final VoidCallback? onCancel;
  final VoidCallback? onKeep;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      title: 'Cancel Moment',
      washed: true,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
      gap: 16,
      bottom: [
        TogetherButton(
          label: 'Cancel moment',
          tone: TogetherButtonTone.danger,
          onPressed: onCancel,
        ),
        TogetherButton(
          label: 'Keep moment',
          tone: TogetherButtonTone.secondary,
          onPressed: onKeep,
        ),
      ],
      children: [
        const RoundTile(
          size: 56,
          icon: SmasherIcons.cross,
          color: TogetherInk.errorTint,
          ink: TogetherInk.errorGlyph,
        ),
        Text('Cancel this moment?', style: TogetherText.sectionTitle),
        Text(
          'This will remove the plan from your shared calendar.',
          style: TogetherText.body.copyWith(color: TogetherInk.body),
        ),
        const _SummaryCard(
          title: 'Movie night',
          meta: 'Saturday · 8:00 PM · Our Circle',
          padding: 18,
          radius: 18,
        ),
      ],
    );
  }
}

class MomentCancelledScreen extends StatelessWidget {
  const MomentCancelledScreen({super.key, this.onBack, this.onPlanNew});

  final VoidCallback? onBack;
  final VoidCallback? onPlanNew;

  @override
  Widget build(BuildContext context) {
    return _Confirmation(
      plain: true,
      top: 130,
      gap: 20,
      tile: const RoundTile(
        size: 64,
        icon: SmasherIcons.calendar,
        iconSize: 26,
        color: TogetherInk.skeletonHome,
        ink: TogetherInk.body,
      ),
      title: 'Moment cancelled',
      titleStyle: TogetherText.sectionTitle,
      description: 'The plan has been removed from your shared calendar.',
      card: const _SummaryCard(
        title: 'Movie night',
        meta: 'Saturday · 8:00 PM',
        status: StatusPillTone.cancelled,
        padding: 18,
        radius: 18,
      ),
      actions: [
        TogetherButton(label: 'Back to Moments', onPressed: onBack),
        TogetherButton(
          label: 'Plan something new',
          tone: TogetherButtonTone.secondary,
          onPressed: onPlanNew,
        ),
      ],
    );
  }
}

// ─── P04 09 / 12 — Past Moments ──────────────────────────────────────────────

class PastMomentsScreen extends StatelessWidget {
  const PastMomentsScreen({super.key, this.empty = false, this.onOpen});

  final bool empty;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    if (empty) {
      return const TogetherScaffold(
        title: 'Past Moments',
        washed: true,
        padding: EdgeInsets.fromLTRB(24, 260, 24, 0),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TogetherState(
            icon: SmasherIcons.time,
            title: 'No past moments',
            description: 'Your completed plans will appear here.',
          ),
        ],
      );
    }
    return TogetherScaffold(
      title: 'Past Moments',
      washed: true,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      gap: 12,
      children: [
        for (final m in DemoMoments.past)
          GestureDetector(
            onTap: onOpen,
            child: Opacity(
              opacity: 0.85,
              child: _SoftCard(
                padding: const EdgeInsets.all(16),
                shadow: _timelineShadow,
                child: Row(
                  children: [
                    const RoundTile(
                      size: 44,
                      radius: 14,
                      icon: SmasherIcons.successCheck,
                      iconSize: 18,
                      color: Color(0xFFF0F0F2),
                      ink: Color(0xFF8A8A94),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.title, style: TogetherText.rowTitle),
                          const SizedBox(height: 2),
                          Text(
                            m.meta,
                            style: TogetherText.caption.copyWith(
                              color: TogetherInk.meta,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDF0),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        'Completed',
                        style: TogetherText.small.copyWith(
                          fontSize: 11,
                          color: const Color(0xFF73737D),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
