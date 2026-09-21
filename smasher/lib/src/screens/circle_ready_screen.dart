import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/controls.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// P02 06 — Circle Ready.
///
/// The first of the status-screen layouts: Body centred on both axes, a 64px
/// round status tile, centred title block, and one Card/Circle. Bottom bar is
/// gradient primary over a ghost.
class CircleReadyScreen extends StatelessWidget {
  const CircleReadyScreen({
    super.key,
    required this.circleName,
    required this.initials,
    required this.memberCount,
    this.onInvite,
    this.onEnter,
  });

  final String circleName;
  final String initials;
  final int memberCount;
  final VoidCallback? onInvite;
  final VoidCallback? onEnter;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      center: true,
      header: const BackHeader(),
      bottomBar: BottomActionBar(
        children: [
          SmasherButton(label: 'Invite people', onPressed: onInvite),
          SmasherButton(
            label: 'Enter Smasher',
            variant: ButtonVariant.ghost,
            onPressed: onEnter,
          ),
        ],
      ),
      children: [
        const StatusHead(
          icon: SmasherIcons.statusCheck,
          title: 'Your circle is ready.',
          description: 'Invite people now or enter your private circle.',
        ),
        CircleCard(
          initials: initials,
          name: circleName,
          meta: memberCount == 1 ? '1 member' : '$memberCount members',
          badge: 'Private',
        ),
      ],
    );
  }
}
