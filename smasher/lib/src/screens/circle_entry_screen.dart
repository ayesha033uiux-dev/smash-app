import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// P02 01 — Circle Entry.
///
/// Rebuilt entirely from the shared widgets: no colour, size or gap is
/// written inline here. If this screen is right, the other 246 are mostly
/// composition.
class CircleEntryScreen extends StatelessWidget {
  const CircleEntryScreen({super.key, this.onCreate, this.onJoin});

  final VoidCallback? onCreate;
  final VoidCallback? onJoin;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BackHeader(),
      footnote: const Footnote('Private by invitation'),
      children: [
        const HeadBlock(
          icon: SmasherIcons.users,
          eyebrow: 'Get started',
          title: 'Who are you connecting with?',
          description:
              "Create a private circle or join one you've been invited to.",
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GroupList(
              children: [
                ActionCard(
                  icon: SmasherIcons.usersPlus,
                  title: 'Create a new circle',
                  subtitle: 'Start a private space for the people you trust.',
                  onTap: onCreate,
                ),
                ActionCard(
                  icon: SmasherIcons.userPlus,
                  title: 'Join a circle',
                  subtitle: 'Use a private invitation from someone you trust.',
                  onTap: onJoin,
                ),
              ],
            ),
            const SizedBox(height: SmasherScreen.contentGap),
            const InfoStrip(
              text:
                  'Only people you invite can ever see your circle.',
            ),
          ],
        ),
      ],
    );
  }
}
