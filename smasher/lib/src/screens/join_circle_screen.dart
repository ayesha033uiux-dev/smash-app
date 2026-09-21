import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// P02 07 — Join Circle.
///
/// Content block at gap 16: the recommended method as a [MethodCard], an
/// [OrDivider], the fallback as a standalone [ActionCard], then the info
/// strip. A footnote closes the screen — no bottom bar.
class JoinCircleScreen extends StatelessWidget {
  const JoinCircleScreen({super.key, this.onScan, this.onEnterCode});

  final VoidCallback? onScan;
  final VoidCallback? onEnterCode;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BackHeader(),
      footnote: const Footnote('Private by invitation'),
      children: [
        const HeadBlock(
          icon: SmasherIcons.userPlus,
          eyebrow: 'Join a circle',
          title: 'Join a circle',
          description: 'Use a private invitation from someone you trust.',
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MethodCard(
              icon: SmasherIcons.scanFace,
              title: 'Scan the QR code',
              description: 'The fastest way in. Point your camera at the '
                  'invitation someone shared with you.',
              actionLabel: 'Open scanner',
              onAction: onScan,
            ),
            const SizedBox(height: 16),
            const OrDivider(),
            const SizedBox(height: 16),
            ActionCard(
              standalone: true,
              icon: SmasherIcons.key,
              title: 'Enter invite code',
              subtitle: 'Use the private code shared with you.',
              onTap: onEnterCode,
            ),
            const SizedBox(height: 16),
            const InfoStrip(
              text: 'Only people you invite can ever see your circle.',
            ),
          ],
        ),
      ],
    );
  }
}
