import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../theme/app_theme.dart';
import '../widgets/controls.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// P02 04 — QR Invitation.
///
/// A single Card/Code holding the 184px invitation QR, over a gradient
/// primary and a white secondary.
class QrInvitationScreen extends StatelessWidget {
  const QrInvitationScreen({
    super.key,
    required this.inviteUrl,
    this.onShare,
    this.onDone,
  });

  /// What the code encodes — the deep link that opens the join flow.
  final String inviteUrl;

  final VoidCallback? onShare;
  final VoidCallback? onDone;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return ScreenScaffold(
      header: const BackHeader(),
      bottomBar: BottomActionBar(
        children: [
          SmasherButton(label: 'Share invitation', onPressed: onShare),
          SmasherButton(
            label: 'Done',
            variant: ButtonVariant.secondary,
            onPressed: onDone,
          ),
        ],
      ),
      children: [
        const HeadBlock(
          icon: SmasherIcons.qrCode,
          eyebrow: 'Invite · QR code',
          title: 'Your private invitation',
          description:
              'Let someone scan this code to request access to your circle.',
        ),
        CodeCard(
          label: 'Private invitation',
          note: 'Only share this code with someone you trust.',
          child: QrImageView(
            data: inviteUrl,
            size: 184,
            padding: EdgeInsets.zero,
            backgroundColor: c.surfaceDefault,
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: c.textPrimary,
            ),
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: c.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
