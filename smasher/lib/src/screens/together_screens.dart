import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/together_tokens.dart';
import '../widgets/primitives.dart';
import '../widgets/together.dart';

/// P03 — Together module: Daily Question, Idea Deck, Match, Propose.
///
/// Every screen takes its callbacks from the route table, so the flow is
/// wired in one place (see `routes.dart`).

// ─── Data ────────────────────────────────────────────────────────────────────

class Idea {
  const Idea({
    required this.category,
    required this.title,
    required this.description,
    required this.duration,
    this.mutual = false,
  });

  final String category;
  final String title;
  final String description;
  final String duration;

  /// The other member already said yes — a Yes here makes a match.
  final bool mutual;

  String get meta => '$duration  ·  $category';
}

abstract final class DemoTogether {
  static const question = 'What would make tonight feel special?';
  static const options = [
    'Something cozy',
    'Something spontaneous',
    'Something new',
    'Just time together',
  ];

  static const dessert = Idea(
    category: 'Cozy',
    title: 'Make a late-night dessert together',
    description:
        'Pick something neither of you has tried before and make it together.',
    duration: '30–45 min',
    mutual: true,
  );

  /// Twelve cards; the file opens on card 4 (the dessert), so the deck starts
  /// there and wraps nothing — reaching the end shows the empty state.
  static const ideas = <Idea>[
    Idea(
      category: 'Outdoors',
      title: 'Take a sunset walk somewhere new',
      description: 'Pick a street or park neither of you has explored.',
      duration: '45–60 min',
    ),
    Idea(
      category: 'Playful',
      title: 'Cook a dish from a country you want to visit',
      description: 'Choose the country together, then split the shopping list.',
      duration: '1–2 hrs',
    ),
    Idea(
      category: 'Calm',
      title: 'Phones away for an evening',
      description: 'Put them in a drawer and see where the night goes.',
      duration: 'All evening',
    ),
    dessert,
    Idea(
      category: 'Creative',
      title: 'Build a playlist for each other',
      description: 'Ten songs each that say something you haven’t yet.',
      duration: '30 min',
    ),
    Idea(
      category: 'Cozy',
      title: 'Movie night with a blanket fort',
      description: 'Take turns picking the film and the snacks.',
      duration: '2–3 hrs',
    ),
    Idea(
      category: 'New',
      title: 'Try a class you’d never book alone',
      description: 'Pottery, salsa, climbing — whichever makes you both nervous.',
      duration: '1–2 hrs',
    ),
    Idea(
      category: 'Calm',
      title: 'Breakfast somewhere with a view',
      description: 'Get up early, bring coffee, and watch the day start.',
      duration: '1 hr',
    ),
    Idea(
      category: 'Playful',
      title: 'Board game tournament for two',
      description: 'Best of five, loser plans the next date.',
      duration: '1–2 hrs',
    ),
    Idea(
      category: 'Outdoors',
      title: 'Stargaze away from the city lights',
      description: 'Pack a blanket and find the darkest spot nearby.',
      duration: '2 hrs',
    ),
    Idea(
      category: 'Creative',
      title: 'Write each other a letter',
      description: 'Swap them now or seal them for a year from today.',
      duration: '30 min',
    ),
    Idea(
      category: 'New',
      title: 'Plan a surprise mini trip',
      description: 'One of you plans, the other only knows what to pack.',
      duration: 'A day',
    ),
  ];

  static const startIndex = 3;
  static const whenOptions = [
    'Tonight',
    'Tomorrow',
    'This weekend',
    'Choose a date',
  ];
}

// ─── P03 01 / 11 — Daily Question ────────────────────────────────────────────

/// P03 01 Daily Question — Default, then P03 11 — Answered once the answer
/// is sent: the other options fade to 50%, the Answer bar goes, and a saved
/// line plus an "n of 3 answered" card appear.
class DailyQuestionScreen extends StatefulWidget {
  const DailyQuestionScreen({
    super.key,
    this.answered = false,
    this.onSeeResults,
  });

  /// Open straight in the Answered state (gallery).
  final bool answered;

  /// Tapping the progress card once everyone has answered.
  final VoidCallback? onSeeResults;

  @override
  State<DailyQuestionScreen> createState() => _DailyQuestionScreenState();
}

class _DailyQuestionScreenState extends State<DailyQuestionScreen> {
  int _selected = 0;
  late bool _answered = widget.answered;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      title: 'Daily Question',
      bottomSurface: true,
      bottom: _answered
          ? const []
          : [
              TogetherButton(
                label: 'Answer',
                onPressed: () => setState(() => _answered = true),
              ),
            ],
      children: [
        TogetherHead(
          eyebrow: 'Daily question',
          title: DemoTogether.question,
          titleStyle: _answered
              ? TogetherText.questionAnswered
              : TogetherText.question,
        ),
        Column(
          children: [
            for (var i = 0; i < DemoTogether.options.length; i++) ...[
              AnimatedOpacity(
                duration: SmasherMotion.fast,
                opacity: _answered && i != _selected ? 0.5 : 1,
                child: OptionRow(
                  label: DemoTogether.options[i],
                  selected: i == _selected,
                  onTap: _answered ? null : () => setState(() => _selected = i),
                ),
              ),
              if (i != DemoTogether.options.length - 1)
                const SizedBox(height: 12),
            ],
          ],
        ),
        if (_answered) ...[
          Row(
            children: [
              const SmasherIcon(
                SmasherIcons.successCheck,
                size: 16,
                color: TogetherInk.success,
              ),
              const SizedBox(width: 8),
              Text(
                'Your answer is saved.',
                style: TogetherText.pill.copyWith(color: TogetherInk.success),
              ),
            ],
          ),
          GestureDetector(
            onTap: widget.onSeeResults,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: TogetherInk.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: TogetherInk.cardBorder),
              ),
              child: Text(
                '2 of 3 answered',
                style: TogetherText.pill.copyWith(color: TogetherInk.body),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ─── P03 12 — Results ────────────────────────────────────────────────────────

class DailyResultsScreen extends StatelessWidget {
  const DailyResultsScreen({super.key, this.onExplore});

  final VoidCallback? onExplore;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      title: "Today's Answers",
      children: [
        const TogetherHead(
          title: "Today's answers",
          description: "Here's what your circle agreed on.",
        ),
        // Figma: Matched Answer — r26, #8B5CF6 → #4C1D95, pad 26/24, gap 14.
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
          decoration: BoxDecoration(
            gradient: TogetherGradient.deep,
            borderRadius: BorderRadius.circular(26),
            boxShadow: TogetherShadow.matched,
          ),
          child: Column(
            children: [
              RoundTile(
                size: 52,
                icon: SmasherIcons.sparkleSolid,
                color: Colors.white.withValues(alpha: 0.18),
                ink: Colors.white,
              ),
              const SizedBox(height: 14),
              Text(
                DemoTogether.options.first,
                textAlign: TextAlign.center,
                style: TogetherText.matchedTitle.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 14),
              Text(
                "Looks like you're on the same page.",
                textAlign: TextAlign.center,
                style: TogetherText.body.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
        TogetherButton(label: 'Explore ideas', onPressed: onExplore),
      ],
    );
  }
}

// ─── P03 02 / 13 / 14 / 15 — Idea Deck ───────────────────────────────────────

enum DeckState { loading, ready, empty, error }

/// P03 02 Idea Deck, with its Loading (13), Empty (14) and Error (15) states.
class IdeaDeckScreen extends StatefulWidget {
  const IdeaDeckScreen({
    super.key,
    this.initialState = DeckState.loading,
    this.onMatch,
    this.onBackToTogether,
  });

  final DeckState initialState;

  /// A Yes on an idea the other member already liked.
  final void Function(BuildContext context, Idea idea)? onMatch;
  final VoidCallback? onBackToTogether;

  @override
  State<IdeaDeckScreen> createState() => _IdeaDeckScreenState();
}

class _IdeaDeckScreenState extends State<IdeaDeckScreen> {
  late DeckState _state = widget.initialState;
  int _index = DemoTogether.startIndex;
  String? _active;

  @override
  void initState() {
    super.initState();
    if (_state == DeckState.loading) _load();
  }

  Future<void> _load() async {
    setState(() => _state = DeckState.loading);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (mounted) setState(() => _state = DeckState.ready);
  }

  Future<void> _react(String reaction) async {
    setState(() => _active = reaction);
    await Future<void>.delayed(const Duration(milliseconds: 220));
    if (!mounted) return;
    final idea = DemoTogether.ideas[_index];
    if (reaction == 'Yes' && idea.mutual) {
      widget.onMatch?.call(context, idea);
    }
    setState(() {
      _active = null;
      if (_index + 1 >= DemoTogether.ideas.length) {
        _state = DeckState.empty;
      } else {
        _index++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return switch (_state) {
      DeckState.loading => _loading(),
      DeckState.ready => _deck(),
      DeckState.empty => _message(
          const TogetherState(
            icon: SmasherIcons.deck,
            title: 'No more ideas for now',
            description: "You've seen everything available in this deck. "
                'New ideas will appear later.',
          ),
          [
            TogetherButton(
              label: 'Back to Together',
              onPressed: widget.onBackToTogether,
            ),
          ],
        ),
      DeckState.error => _message(
          const TogetherState(
            error: true,
            icon: SmasherIcons.errorCircle,
            title: "Couldn't load ideas",
            description: "We couldn't load your ideas right now. Check your "
                'connection and try again.',
          ),
          [
            TogetherButton(label: 'Try again', onPressed: _load),
            TogetherButton(
              label: 'Back',
              tone: TogetherButtonTone.secondary,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
    };
  }

  Widget _deck() {
    final idea = DemoTogether.ideas[_index];
    return TogetherScaffold(
      title: 'Idea Deck',
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      gap: 20,
      children: [
        const TogetherHead(
          title: 'Explore ideas',
          description:
              'React privately. A match appears only when the feeling is '
              'mutual.',
        ),
        Text(
          '${_index + 1} of ${DemoTogether.ideas.length}',
          style: TogetherText.small.copyWith(color: TogetherInk.counter),
        ),
        AnimatedSwitcher(
          duration: SmasherMotion.fast,
          child: IdeaCard(
            key: ValueKey(_index),
            eyebrow: idea.category,
            title: idea.title,
            description: idea.description,
            meta: idea.meta,
          ),
        ),
        Row(
          children: [
            for (final r in const ['No', 'Maybe', 'Yes']) ...[
              ReactionButton(
                label: r,
                active: _active == r,
                onTap: _active == null ? () => _react(r) : null,
              ),
              if (r != 'Yes') const SizedBox(width: 12),
            ],
          ],
        ),
      ],
    );
  }

  Widget _loading() {
    return TogetherScaffold(
      title: 'Idea Deck',
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      gap: 20,
      children: [
        const SkeletonBox(width: 100, height: 16, radius: 8),
        const SkeletonBox(width: 260, height: 24, radius: 10),
        Container(
          width: double.infinity,
          height: 220,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
          decoration: BoxDecoration(
            color: TogetherInk.skeletonCard,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonBox(
                width: 70,
                height: 12,
                radius: 6,
                color: Colors.white.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 14),
              SkeletonBox(
                width: 220,
                height: 22,
                radius: 8,
                color: Colors.white.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 14),
              SkeletonBox(
                width: 260,
                height: 16,
                radius: 6,
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
        Row(
          children: [
            for (var i = 0; i < 3; i++) ...[
              const Expanded(
                child: SkeletonBox(
                  height: 52,
                  radius: 18,
                  color: TogetherInk.skeletonCard,
                ),
              ),
              if (i != 2) const SizedBox(width: 12),
            ],
          ],
        ),
      ],
    );
  }

  /// Empty / error: body padded 260 from the top, content hugging.
  Widget _message(TogetherState state, List<Widget> actions) {
    return TogetherScaffold(
      title: 'Idea Deck',
      padding: const EdgeInsets.fromLTRB(24, 260, 24, 0),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TogetherState(
          icon: state.icon,
          title: state.title,
          description: state.description,
          error: state.error,
          actions: actions,
        ),
      ],
    );
  }
}

// ─── P03 04 — Match Celebration Sheet ────────────────────────────────────────

/// Shows the P03 04 sheet over the current screen (#171221 at 45% scrim).
Future<void> showMatchSheet(
  BuildContext context, {
  required Idea idea,
  VoidCallback? onPropose,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: TogetherInk.scrim,
    isScrollControlled: true,
    builder: (sheetContext) => _MatchSheet(
      idea: idea,
      onPropose: () {
        Navigator.of(sheetContext).pop();
        onPropose?.call();
      },
    ),
  );
}

class _MatchSheet extends StatelessWidget {
  const _MatchSheet({required this.idea, this.onPropose});

  final Idea idea;
  final VoidCallback? onPropose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      decoration: const BoxDecoration(
        color: TogetherInk.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: TogetherShadow.sheet,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: TogetherInk.sheetHandle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const RoundTile(
              size: 56,
              glyph: '✦',
              iconSize: 22,
              color: TogetherInk.selectTint,
            ),
            const SizedBox(height: 16),
            Text(
              "You're both into this.",
              textAlign: TextAlign.center,
              style: TogetherText.matchedTitle,
            ),
            const SizedBox(height: 6),
            Text(
              idea.title,
              textAlign: TextAlign.center,
              style: TogetherText.label.copyWith(color: TogetherInk.brand),
            ),
            const SizedBox(height: 6),
            Text(
              "Turn your match into a plan when you're ready.",
              textAlign: TextAlign.center,
              style: TogetherText.meta.copyWith(color: TogetherInk.body),
            ),
            const SizedBox(height: 16),
            TogetherButton(label: 'Propose this idea', onPressed: onPropose),
            const SizedBox(height: 16),
            TogetherButton(
              label: 'Maybe later',
              tone: TogetherButtonTone.secondary,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── P03 03 — Match Detail ───────────────────────────────────────────────────

class MatchDetailScreen extends StatelessWidget {
  const MatchDetailScreen({
    super.key,
    this.idea = DemoTogether.dessert,
    this.onPropose,
    this.onKeepExploring,
  });

  final Idea idea;
  final VoidCallback? onPropose;
  final VoidCallback? onKeepExploring;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      title: 'Match',
      children: [
        const TogetherHead(
          title: "It's a match.",
          description: 'You both chose this idea.',
        ),
        const RoundTile(
          size: 64,
          glyph: '✦',
          iconSize: 26,
          color: TogetherInk.selectTint,
        ),
        IdeaCard(
          compact: true,
          eyebrow: '${idea.category}  ·  Mutual',
          title: idea.title,
          description: idea.description,
        ),
        TogetherButton(label: 'Propose this idea', onPressed: onPropose),
        TogetherButton(
          label: 'Keep exploring',
          tone: TogetherButtonTone.secondary,
          onPressed: onKeepExploring,
        ),
      ],
    );
  }
}

// ─── P03 05 — Propose Idea ───────────────────────────────────────────────────

class ProposeIdeaScreen extends StatefulWidget {
  const ProposeIdeaScreen({
    super.key,
    this.idea = DemoTogether.dessert,
    this.onSend,
  });

  final Idea idea;
  final VoidCallback? onSend;

  @override
  State<ProposeIdeaScreen> createState() => _ProposeIdeaScreenState();
}

class _ProposeIdeaScreenState extends State<ProposeIdeaScreen> {
  int _when = 0;

  @override
  Widget build(BuildContext context) {
    Widget pill(int i) => Expanded(
          child: SelectPill(
            label: DemoTogether.whenOptions[i],
            selected: _when == i,
            onTap: () => setState(() => _when = i),
          ),
        );

    return TogetherScaffold(
      title: 'Propose Idea',
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      gap: 20,
      bottom: [
        TogetherButton(label: 'Send proposal', onPressed: widget.onSend),
      ],
      children: [
        Text(
          "Suggest a time and see if they'd like to make it happen.",
          style: TogetherText.body.copyWith(color: TogetherInk.body),
        ),
        OutlineCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.idea.category.toUpperCase(),
                style: TogetherText.eyebrowTight.copyWith(
                  color: TogetherInk.brand,
                ),
              ),
              const SizedBox(height: 6),
              Text(widget.idea.title, style: TogetherText.summaryTitle),
            ],
          ),
        ),
        Text('When would you like to do this?', style: TogetherText.label),
        Column(
          children: [
            Row(children: [pill(0), const SizedBox(width: 10), pill(1)]),
            const SizedBox(height: 10),
            Row(children: [pill(2), const SizedBox(width: 10), pill(3)]),
          ],
        ),
        Text('Add a note', style: TogetherText.label),
        const NoteField(hint: "Anything you'd like them to know?"),
      ],
    );
  }
}

// ─── P03 06 / 18 — Sent confirmations ────────────────────────────────────────

class ProposalSentScreen extends StatelessWidget {
  const ProposalSentScreen({
    super.key,
    this.idea = DemoTogether.dessert,
    this.onBackToTogether,
    this.onViewProposal,
  });

  final Idea idea;
  final VoidCallback? onBackToTogether;
  final VoidCallback? onViewProposal;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      showHeader: false,
      padding: const EdgeInsets.fromLTRB(24, 140, 24, 24),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const RoundTile(
          size: 72,
          icon: SmasherIcons.send,
          iconSize: 30,
          gradient: TogetherGradient.deep,
          ink: Colors.white,
        ),
        Text(
          'Proposal sent',
          textAlign: TextAlign.center,
          style: TogetherText.pageTitle,
        ),
        Text(
          "They'll see your suggestion and can accept, change it, or decline.",
          textAlign: TextAlign.center,
          style: TogetherText.body.copyWith(color: TogetherInk.body),
        ),
        PlanCard(
          title: idea.title,
          meta: 'Saturday · 8:00 PM',
          status: StatusPillTone.waiting,
        ),
        Column(
          children: [
            TogetherButton(
              label: 'Back to Together',
              onPressed: onBackToTogether,
            ),
            const SizedBox(height: 14),
            TogetherButton(
              label: 'View proposal',
              tone: TogetherButtonTone.secondary,
              onPressed: onViewProposal,
            ),
          ],
        ),
      ],
    );
  }
}

class NewTimeSentScreen extends StatelessWidget {
  const NewTimeSentScreen({super.key, this.onBackToTogether});

  final VoidCallback? onBackToTogether;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      showHeader: false,
      background: TogetherInk.pageAlt,
      padding: const EdgeInsets.fromLTRB(24, 150, 24, 24),
      gap: 20,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const RoundTile(size: 64, icon: SmasherIcons.time, iconSize: 26),
        Text(
          'New time suggested',
          textAlign: TextAlign.center,
          style: TogetherText.sectionTitle,
        ),
        Text(
          "We'll let them know your new time works for you.",
          textAlign: TextAlign.center,
          style: TogetherText.body.copyWith(color: TogetherInk.body),
        ),
        OutlineCard(
          outlined: false,
          radius: 18,
          padding: const EdgeInsets.all(18),
          shadow: TogetherShadow.soft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sunday, Aug 30 · 7:30 PM', style: TogetherText.label),
              const SizedBox(height: 8),
              const StatusPill(StatusPillTone.waiting),
            ],
          ),
        ),
        TogetherButton(label: 'Back to Together', onPressed: onBackToTogether),
      ],
    );
  }
}

// ─── P03 07 — Received Proposal ──────────────────────────────────────────────

class ReceivedProposalScreen extends StatelessWidget {
  const ReceivedProposalScreen({
    super.key,
    this.idea = DemoTogether.dessert,
    this.onAccept,
    this.onSuggest,
    this.onDecline,
  });

  final Idea idea;
  final VoidCallback? onAccept;
  final VoidCallback? onSuggest;
  final VoidCallback? onDecline;

  @override
  Widget build(BuildContext context) {
    Widget iconRow(String icon, String label) => Row(
          children: [
            RoundTile(
              size: 32,
              icon: icon,
              iconSize: 16,
              radius: 10,
              color: TogetherInk.selectTint,
            ),
            const SizedBox(width: 10),
            Text(label, style: TogetherText.label),
          ],
        );

    return TogetherScaffold(
      title: 'Proposal',
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      gap: 20,
      children: [
        TogetherHead(
          title: 'Someone proposed this',
          titleStyle: TogetherText.sectionTitle,
          description: 'Review the idea and decide what works for you.',
        ),
        OutlineCard(
          radius: 22,
          shadow: TogetherShadow.card,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                idea.category.toUpperCase(),
                style: TogetherText.eyebrowTight.copyWith(
                  color: TogetherInk.brand,
                ),
              ),
              const SizedBox(height: 14),
              Text(idea.title, style: TogetherText.stateTitle),
              const SizedBox(height: 14),
              iconRow(SmasherIcons.calendar, 'Saturday'),
              const SizedBox(height: 14),
              iconRow(SmasherIcons.time, '8:00 PM'),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: TogetherInk.page,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SmasherIcon(
                      SmasherIcons.note,
                      size: 16,
                      color: TogetherInk.brand,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "I'll pick the recipe.",
                        style: TogetherText.bodySmall.copyWith(
                          color: TogetherInk.body,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        TogetherButton(label: 'Accept', onPressed: onAccept),
        TogetherButton(
          label: 'Suggest another time',
          tone: TogetherButtonTone.secondary,
          onPressed: onSuggest,
        ),
        GestureDetector(
          onTap: onDecline,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              'Decline',
              textAlign: TextAlign.center,
              style: TogetherText.label.copyWith(color: TogetherInk.dangerText),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── P03 08 — Proposal Accepted ──────────────────────────────────────────────

class ProposalAcceptedScreen extends StatelessWidget {
  const ProposalAcceptedScreen({
    super.key,
    this.idea = DemoTogether.dessert,
    this.onViewMoment,
    this.onBackToTogether,
  });

  final Idea idea;
  final VoidCallback? onViewMoment;
  final VoidCallback? onBackToTogether;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      showHeader: false,
      padding: const EdgeInsets.fromLTRB(24, 120, 24, 24),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const RoundTile(
          size: 72,
          icon: SmasherIcons.successCheck,
          iconSize: 34,
          color: TogetherInk.successTint,
          ink: TogetherInk.success,
        ),
        Text(
          "It's planned.",
          textAlign: TextAlign.center,
          style: TogetherText.pageTitle,
        ),
        Text(
          'Your moment has been added to your shared calendar.',
          textAlign: TextAlign.center,
          style: TogetherText.body.copyWith(color: TogetherInk.body),
        ),
        PlanCard(
          title: idea.title,
          meta: 'Saturday · 8:00 PM  ·  2 people',
          status: StatusPillTone.confirmed,
        ),
        TogetherButton(label: 'View moment', onPressed: onViewMoment),
        TogetherButton(
          label: 'Back to Together',
          tone: TogetherButtonTone.secondary,
          onPressed: onBackToTogether,
        ),
      ],
    );
  }
}

// ─── P03 09 — Suggest Another Time ───────────────────────────────────────────

class SuggestTimeScreen extends StatelessWidget {
  const SuggestTimeScreen({super.key, this.onSend});

  final VoidCallback? onSend;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      title: 'Suggest Time',
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      gap: 20,
      bottom: [TogetherButton(label: 'Send new time', onPressed: onSend)],
      children: [
        Text(
          'Choose a time that works better for you.',
          style: TogetherText.body.copyWith(color: TogetherInk.body),
        ),
        const PickerField(
          label: 'Date',
          icon: SmasherIcons.calendar,
          value: 'Sunday, Aug 30',
        ),
        const PickerField(
          label: 'Time',
          icon: SmasherIcons.time,
          value: '7:30 PM',
        ),
        Text('Add a note', style: TogetherText.fieldLabel),
        const NoteField(
          hint: 'How about this time instead?',
          minHeight: 64,
        ),
      ],
    );
  }
}

// ─── P03 10 — Decline Proposal ───────────────────────────────────────────────

class DeclineProposalScreen extends StatelessWidget {
  const DeclineProposalScreen({super.key, this.onDecline, this.onKeep});

  final VoidCallback? onDecline;
  final VoidCallback? onKeep;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      title: 'Decline Proposal',
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
      gap: 16,
      bottom: [
        TogetherButton(
          label: 'Decline proposal',
          tone: TogetherButtonTone.danger,
          onPressed: onDecline,
        ),
        TogetherButton(
          label: 'Keep proposal',
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
        Text('Decline this proposal?', style: TogetherText.sectionTitle),
        Text(
          "The match will stay available if you'd like to revisit it later.",
          style: TogetherText.body.copyWith(color: TogetherInk.body),
        ),
      ],
    );
  }
}

// ─── P03 16 — Empty rows ─────────────────────────────────────────────────────

/// P03 16 — the three empty rows the Together home swaps in when a section
/// has nothing yet. Shown together here as the file lays them out.
class TogetherEmptyStatesScreen extends StatelessWidget {
  const TogetherEmptyStatesScreen({
    super.key,
    this.onExploreIdeas,
    this.onExploreMatches,
  });

  final VoidCallback? onExploreIdeas;
  final VoidCallback? onExploreMatches;

  @override
  Widget build(BuildContext context) {
    return TogetherScaffold(
      showHeader: false,
      gap: 16,
      children: [
        Text('Empty States', style: TogetherText.cardTitleLarge),
        EmptyRowCard(
          icon: SmasherIcons.heartOutline,
          title: 'No matches yet',
          description: 'Keep exploring. Mutual ideas will appear here.',
          ctaLabel: 'Explore ideas',
          onCta: onExploreIdeas,
        ),
        const EmptyRowCard(
          icon: SmasherIcons.sendSmall,
          title: 'No proposals yet',
          description: 'Proposals you send or receive will appear here.',
        ),
        EmptyRowCard(
          icon: SmasherIcons.calendar,
          title: 'Nothing planned yet',
          description: 'Turn a mutual idea into a shared moment.',
          ctaLabel: 'Explore matches',
          onCta: onExploreMatches,
        ),
      ],
    );
  }
}

// ─── P03 19 / 20 / 21 — Together home states ─────────────────────────────────

enum TogetherHomeState { loading, error, offline }

/// The Together home while loading (19), after a failure (20) and offline
/// (21). The file draws them on a white body without the header or nav.
class TogetherHomeStateScreen extends StatelessWidget {
  const TogetherHomeStateScreen({super.key, required this.state, this.onRetry});

  final TogetherHomeState state;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TogetherInk.surface,
      body: SafeArea(
        child: switch (state) {
          TogetherHomeState.loading => const Padding(
              padding: EdgeInsets.fromLTRB(24, 70, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(
                    width: 140,
                    height: 30,
                    radius: 8,
                    color: TogetherInk.skeletonHome,
                  ),
                  SizedBox(height: 18),
                  SkeletonBox(
                    height: 150,
                    radius: 22,
                    color: TogetherInk.skeletonHome,
                  ),
                  SizedBox(height: 18),
                  SkeletonBox(
                    height: 90,
                    radius: 22,
                    color: TogetherInk.skeletonHome,
                  ),
                  SizedBox(height: 18),
                  SkeletonBox(
                    height: 90,
                    radius: 22,
                    color: TogetherInk.skeletonHome,
                  ),
                ],
              ),
            ),
          TogetherHomeState.error => Padding(
              padding: const EdgeInsets.fromLTRB(24, 260, 24, 0),
              child: TogetherState(
                error: true,
                icon: SmasherIcons.errorCircle,
                title: "Couldn't load Together",
                description:
                    'Something went wrong loading your circle. Try again.',
                actions: [TogetherButton(label: 'Try again', onPressed: onRetry)],
              ),
            ),
          TogetherHomeState.offline => const Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: OfflineBanner(),
            ),
        },
      ),
    );
  }
}
