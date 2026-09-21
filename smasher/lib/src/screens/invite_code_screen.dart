import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import '../widgets/controls.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// P02 05 — Invite Code.
///
/// The Card/Code holds the code itself at H1 size (DM Sans SemiBold 32),
/// centred, with the same lock note as the QR screen.
class InviteCodeScreen extends StatelessWidget {
  const InviteCodeScreen({
    super.key,
    required this.code,
    this.onShare,
  });

  final String code;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return ScreenScaffold(
      header: const BackHeader(),
      bottomBar: BottomActionBar(
        children: [
          SmasherButton(
            label: 'Copy code',
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: code));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invite code copied')),
                );
              }
            },
          ),
          SmasherButton(
            label: 'Share invitation',
            variant: ButtonVariant.secondary,
            onPressed: onShare,
          ),
        ],
      ),
      children: [
        const HeadBlock(
          icon: SmasherIcons.key,
          eyebrow: 'Invite · Code',
          title: 'Share your invite code',
          description: 'Send this code only to someone you trust.',
        ),
        CodeCard(
          label: 'Private invite code',
          note: 'Keep this code private.',
          child: Text(
            code,
            style: SmasherText.h1.copyWith(color: c.textPrimary),
          ),
        ),
      ],
    );
  }
}
