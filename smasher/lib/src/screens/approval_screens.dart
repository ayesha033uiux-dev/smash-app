import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/controls.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// P02 10 — Circle Preview.
///
/// What someone sees after a valid invitation resolves: the circle itself,
/// then two [InfoRowCard]s explaining what joining means. Content gap 12.
class CirclePreviewScreen extends StatelessWidget {
  const CirclePreviewScreen({
    super.key,
    required this.circleName,
    required this.initials,
    required this.memberCount,
    this.onRequest,
    this.onNotNow,
  });

  final String circleName;
  final String initials;
  final int memberCount;
  final VoidCallback? onRequest;
  final VoidCallback? onNotNow;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BackHeader(),
      bottomBar: BottomActionBar(
        children: [
          SmasherButton(label: 'Request to join', onPressed: onRequest),
          SmasherButton(
            label: 'Not now',
            variant: ButtonVariant.ghost,
            onPressed: onNotNow ?? () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
      children: [
        const HeadBlock(
          icon: SmasherIcons.shield,
          eyebrow: 'Invitation',
          title: "You've been invited.",
          description: 'Review this circle before requesting access.',
        ),
        Column(
          children: [
            CircleCard(
              initials: initials,
              name: circleName,
              meta: memberCount == 1 ? '1 member' : '$memberCount members',
              badge: 'Private',
            ),
            const SizedBox(height: 12),
            const InfoRowCard(
              icon: SmasherIcons.lock,
              title: 'Private circle',
              subtitle: 'Only approved members can access this circle.',
            ),
            const SizedBox(height: 12),
            const InfoRowCard(
              icon: SmasherIcons.users,
              title: 'Trusted members',
              subtitle: 'This circle is limited to people invited or approved '
                  'by its members.',
            ),
          ],
        ),
      ],
    );
  }
}

/// P02 11 — Waiting For Approval.
///
/// A neutral status screen: grey tile, centred body, one [InfoRowCard] in its
/// centred form showing how long ago the request went out.
class WaitingApprovalScreen extends StatelessWidget {
  const WaitingApprovalScreen({
    super.key,
    this.sentLabel = 'Sent just now',
    this.onRefresh,
    this.onCancel,
  });

  final String sentLabel;
  final VoidCallback? onRefresh;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      center: true,
      header: const BackHeader(),
      bottomBar: BottomActionBar(
        children: [
          SmasherButton(label: 'Refresh status', onPressed: onRefresh),
          SmasherButton(
            label: 'Cancel request',
            variant: ButtonVariant.ghost,
            onPressed: onCancel ?? () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
      children: [
        const StatusHead(
          tone: StatusTone.neutral,
          icon: SmasherIcons.hourglass,
          title: 'Waiting for approval',
          description: 'Your request has been sent. The circle owner needs to '
              'approve it before you can join.',
        ),
        InfoRowCard(
          centred: true,
          icon: SmasherIcons.clock,
          title: 'Request pending',
          subtitle: sentLabel,
        ),
      ],
    );
  }
}

/// P02 12 — You're In.
class YoureInScreen extends StatelessWidget {
  const YoureInScreen({
    super.key,
    required this.circleName,
    required this.initials,
    required this.memberCount,
    this.onEnter,
  });

  final String circleName;
  final String initials;
  final int memberCount;
  final VoidCallback? onEnter;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      center: true,
      header: const BackHeader(),
      bottomBar: BottomActionBar.single(
        SmasherButton(label: 'Enter Smasher', onPressed: onEnter),
      ),
      children: [
        const StatusHead(
          icon: SmasherIcons.statusCheck,
          title: "You're in.",
          description: "You've joined the private circle.",
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
