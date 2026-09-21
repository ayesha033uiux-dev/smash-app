import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/controls.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// P02 03 — Invite People.
///
/// Head Block, a three-row Group/List, and a two-button bottom bar: gradient
/// primary over a ghost "Skip for now".
class InvitePeopleScreen extends StatelessWidget {
  const InvitePeopleScreen({
    super.key,
    this.onQr,
    this.onCode,
    this.onShare,
    this.onSkip,
  });

  final VoidCallback? onQr;
  final VoidCallback? onCode;
  final VoidCallback? onShare;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BackHeader(),
      bottomBar: BottomActionBar(
        children: [
          SmasherButton(label: 'Share invitation', onPressed: onShare),
          SmasherButton(
            label: 'Skip for now',
            variant: ButtonVariant.ghost,
            onPressed: onSkip,
          ),
        ],
      ),
      children: [
        const HeadBlock(
          icon: SmasherIcons.usersPlus,
          eyebrow: 'Invite',
          title: 'Invite people you trust',
          description: 'Your circle stays private. Share an invitation only '
              'with people you trust.',
        ),
        GroupList(
          children: [
            ActionCard(
              icon: SmasherIcons.qrCode,
              title: 'Invite with QR code',
              subtitle: 'Let someone scan your private invitation.',
              onTap: onQr,
            ),
            ActionCard(
              icon: SmasherIcons.key,
              title: 'Share invite code',
              subtitle: 'Send a private code to someone you trust.',
              onTap: onCode,
            ),
            ActionCard(
              icon: SmasherIcons.share,
              title: 'Share invitation',
              subtitle: 'Send your invitation through another app.',
              onTap: onShare,
            ),
          ],
        ),
      ],
    );
  }
}
