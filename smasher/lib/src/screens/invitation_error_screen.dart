import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/controls.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// P02 15–18 — the four ways an invitation can fail.
///
/// All four artboards are the same screen with different copy and a different
/// bottom bar, so they are one widget with a named constructor each: centred
/// body, a #FCECEC status tile, a centred title block, and one or two buttons.
class InvitationErrorScreen extends StatelessWidget {
  const InvitationErrorScreen({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
  });

  /// P02 15 — the code does not resolve to anything.
  const InvitationErrorScreen.notFound({
    Key? key,
    VoidCallback? onRetry,
    VoidCallback? onBack,
  }) : this(
          key: key,
          icon: SmasherIcons.search,
          title: 'Invitation not found',
          description: "This invitation isn't valid. Check the code or ask "
              'the sender for a new one.',
          primaryLabel: 'Try another code',
          onPrimary: onRetry,
          secondaryLabel: 'Back to join',
          onSecondary: onBack,
        );

  /// P02 16 — the invitation timed out.
  const InvitationErrorScreen.expired({Key? key, VoidCallback? onAsk})
      : this(
          key: key,
          icon: SmasherIcons.statusClock,
          title: 'Invitation expired',
          description: 'This invitation is no longer active. Ask the sender '
              'for a new invitation.',
          primaryLabel: 'Ask for a new invitation',
          onPrimary: onAsk,
        );

  /// P02 17 — the owner withdrew it.
  const InvitationErrorScreen.revoked({Key? key, VoidCallback? onBack})
      : this(
          key: key,
          icon: SmasherIcons.xCircle,
          title: 'Invitation no longer available',
          description: 'This invitation was revoked by the circle owner.',
          primaryLabel: 'Back to join',
          onPrimary: onBack,
        );

  /// P02 18 — the circle itself is gone or closed.
  const InvitationErrorScreen.circleUnavailable({
    Key? key,
    VoidCallback? onBack,
  }) : this(
          key: key,
          icon: SmasherIcons.statusAlert,
          title: 'This circle is unavailable',
          description: 'The circle may have been deleted or is no longer '
              'accepting requests.',
          primaryLabel: 'Back to join',
          onPrimary: onBack,
        );

  /// A constant from [SmasherIcons].
  final String icon;
  final String title;
  final String description;
  final String primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      center: true,
      header: const BackHeader(),
      bottomBar: BottomActionBar(
        children: [
          SmasherButton(label: primaryLabel, onPressed: onPrimary),
          if (secondaryLabel != null)
            SmasherButton(
              label: secondaryLabel!,
              variant: ButtonVariant.ghost,
              onPressed: onSecondary,
            ),
        ],
      ),
      children: [
        StatusHead(
          tone: StatusTone.error,
          icon: icon,
          title: title,
          description: description,
        ),
      ],
    );
  }
}
