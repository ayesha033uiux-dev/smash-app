import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../theme/app_theme.dart';
import '../widgets/module.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

const _circleName = 'Our Circle';

/// P02 20 — Together Home.
/// The only module home with real content in the file: gradient hero, a pair
/// of stat tiles under a section label, and a wide feature card.
class TogetherHome extends StatelessWidget {
  const TogetherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleScaffold(
      header: const ModuleHeader(circleName: _circleName),
      children: [
        const ModuleHead(
          large: true,
          title: 'Together',
          description: 'Your private space, shared your way.',
        ),
        HeroCard(
          eyebrow: 'Daily question',
          title:
              'A little question to spark a meaningful moment together.',
          ctaLabel: 'View question',
          onCta: () => Navigator.of(context).pushNamed(Routes.dailyQuestion),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SmasherLabel('Explore together', tone: LabelTone.muted),
            const SizedBox(height: 11),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TileCard(
                  icon: SmasherIcons.sparkles,
                  title: 'Matches',
                  description: 'Discover what you both have in common.',
                  linkLabel: 'View matches',
                  onTap: () => Navigator.of(context).pushNamed(Routes.matchDetail),
                ),
                const SizedBox(width: 12),
                TileCard(
                  icon: SmasherIcons.calendarCheck,
                  title: 'Proposals',
                  description: 'Ideas waiting for you to explore together.',
                  linkLabel: 'View proposals',
                  onTap: () => Navigator.of(context).pushNamed(Routes.receivedProposal),
                ),
              ],
            ),
          ],
        ),
        FeatureCard(
          icon: SmasherIcons.layers,
          title: 'Idea Deck',
          subtitle: 'Pick an idea and make your next moment count.',
          onTap: () => Navigator.of(context).pushNamed(Routes.ideaDeck),
        ),
      ],
    );
  }
}

/// P02 20 — Moments Home (empty state).
class MomentsHome extends StatelessWidget {
  const MomentsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleScaffold(
      showWash: false,
      emptyState: true,
      header: const ModuleHeader(circleName: _circleName),
      children: [
        const ModuleHead(
          title: 'Moments',
          description: 'Plan and remember the moments you share.',
        ),
        EmptyState(
          icon: SmasherIcons.moments,
          title: 'Nothing planned yet',
          description: 'Your shared moments will appear here.',
          actionLabel: 'Plan a Moment',
          onAction: () {},
        ),
      ],
    );
  }
}

/// P02 21 — Stories Home (empty state).
class StoriesHome extends StatelessWidget {
  const StoriesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModuleScaffold(
      showWash: false,
      emptyState: true,
      header: ModuleHeader(circleName: _circleName),
      children: [
        ModuleHead(
          title: 'Stories',
          description: 'Private moments shared with your circle.',
        ),
        EmptyState(
          icon: SmasherIcons.stories,
          title: 'No stories yet',
          description: 'Stories shared with your circle will appear here.',
        ),
      ],
    );
  }
}

/// P02 22 — Messages Home (empty state).
class MessagesHome extends StatelessWidget {
  const MessagesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModuleScaffold(
      showWash: false,
      emptyState: true,
      header: ModuleHeader(circleName: _circleName),
      children: [
        ModuleHead(
          title: 'Messages',
          description: 'Private conversations within your circle.',
        ),
        EmptyState(
          icon: SmasherIcons.messages,
          title: 'No messages yet',
          description: 'Your conversations will appear here.',
        ),
      ],
    );
  }
}

/// P02 21 — Profile (Premium).
///
/// The odd one out: no circle pill, a small 18px page title, a gradient
/// profile hero, then the settings group.
class ProfileHome extends StatelessWidget {
  const ProfileHome({super.key});

  static const _settings =
      <({String icon, String title, String subtitle, String? route})>[
    (
      icon: SmasherIcons.shield,
      title: 'Boundaries',
      route: Routes.boundaries,
      subtitle: 'What you are and are not open to, in your own words.',
    ),
    (
      icon: SmasherIcons.lock,
      title: 'Privacy',
      route: Routes.privacySafety,
      subtitle: 'Control what your circle can see.',
    ),
    (
      icon: SmasherIcons.key,
      title: 'Security',
      route: Routes.security,
      subtitle: 'PIN, Face ID and sign-in.',
    ),
    (
      icon: SmasherIcons.users,
      title: 'Circle settings',
      route: Routes.circleOverview,
      subtitle: 'Members, invitations and access.',
    ),
    (
      icon: SmasherIcons.settings,
      title: 'Account settings',
      route: Routes.account,
      subtitle: 'Email, notifications and data.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return ModuleScaffold(
      gap: 10,
      washTop: -300,
      header: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Profile',
          style: SmasherText.h4.copyWith(color: c.textPrimary),
        ),
      ),
      children: [
        const _ProfileHero(
          initial: 'A',
          name: 'Ayesha',
          role: 'Private member',
          circle: _circleName,
          about: 'Quiet moments, loud laughter.',
          memberSince: 'August 2026',
        ),
        const SizedBox(height: 14),
        const SmasherLabel('Settings', tone: LabelTone.muted),
        const SizedBox(height: 10),
        GroupList(
          children: [
            for (final s in _settings)
              ActionCard(
                icon: s.icon,
                title: s.title,
                subtitle: s.subtitle,
                onTap: s.route == null
                    ? () {}
                    : () => Navigator.of(context).pushNamed(s.route!),
              ),
          ],
        ),
      ],
    );
  }
}

/// Figma: Profile Hero — 342x196, r28, brand gradient, concentric decorative
/// rings, 60px avatar, name block, circle badge pill, hairline, then the
/// ABOUT / MEMBER SINCE meta and an Edit pill.
class _ProfileHero extends StatelessWidget {
  const _ProfileHero({
    required this.initial,
    required this.name,
    required this.role,
    required this.circle,
    required this.about,
    required this.memberSince,
  });

  final String initial;
  final String name;
  final String role;
  final String circle;
  final String about;
  final String memberSince;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    final onHero = c.brandOnPrimary;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: SmasherGradient.brand,
        borderRadius: BorderRadius.circular(SmasherRadius.hero),
        boxShadow: SmasherShadow.brandGlow,
      ),
      child: Stack(
        children: [
          Positioned(
            right: -70,
            top: -50,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: onHero.withValues(alpha: 0.20)),
              ),
            ),
          ),
          Positioned(
            right: -30,
            bottom: -50,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: onHero.withValues(alpha: 0.07),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: c.surfaceDefault,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        initial,
                        style: SmasherText.h2
                            .copyWith(
                              color: c.brandPrimary,
                              fontSize: 26,
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: SmasherText.h2
                                .copyWith(color: onHero, letterSpacing: 0),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            role,
                            style: SmasherText.bodySmall.copyWith(
                              color: onHero.withValues(alpha: 0.78),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 12, 5),
                      decoration: BoxDecoration(
                        color: onHero.withValues(alpha: 0.16),
                        borderRadius:
                            BorderRadius.circular(SmasherRadius.full),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SmasherIcon(SmasherIcons.heart, size: 11, color: onHero),
                          const SizedBox(width: 6),
                          Text(
                            circle,
                            style:
                                SmasherText.chipLabel
                                    .copyWith(color: onHero, letterSpacing: 0.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Container(height: 1, color: onHero.withValues(alpha: 0.18)),
                const SizedBox(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _HeroMeta(
                        label: 'About',
                        value: about,
                        color: onHero,
                      ),
                    ),
                    const SizedBox(width: 16),
                    _HeroMeta(
                      label: 'Member since',
                      value: memberSince,
                      color: onHero,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(Routes.editProfile),
                    child: Container(
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    decoration: BoxDecoration(
                      color: onHero.withValues(alpha: 0.18),
                      borderRadius:
                          BorderRadius.circular(SmasherRadius.infoStrip),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SmasherIcon(SmasherIcons.edit, size: 14, color: onHero),
                        const SizedBox(width: 6),
                        Text(
                          'Edit',
                          style:
                              SmasherText.buttonSmall.copyWith(color: onHero),
                        ),
                      ],
                    ),
                  ),
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

class _HeroMeta extends StatelessWidget {
  const _HeroMeta({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          // 10 Inter Semi Bold ls 1 at 60%.
          style: SmasherText.eyebrow.copyWith(
            fontSize: 10,
            letterSpacing: 1,
            color: color.withValues(alpha: 0.60),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: SmasherText.bodySmallMedium.copyWith(color: color),
        ),
      ],
    );
  }
}
