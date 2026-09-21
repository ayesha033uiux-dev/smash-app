import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/controls.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// P02 08 — QR Scanner.
///
/// The dark viewport plus a centred reassurance line. The camera itself is not
/// wired yet; [ScannerFrame] draws the chrome exactly as the artboard does, so
/// a real preview can be dropped in behind the reticle later.
class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key, this.onEnterCode, this.onCancel});

  final VoidCallback? onEnterCode;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return ScreenScaffold(
      header: const BackHeader(),
      bottomBar: BottomActionBar(
        children: [
          SmasherButton(label: 'Enter code instead', onPressed: onEnterCode),
          SmasherButton(
            label: 'Cancel',
            variant: ButtonVariant.ghost,
            onPressed: onCancel ?? () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
      children: [
        const HeadBlock(
          icon: SmasherIcons.camera,
          eyebrow: 'Join · Scan',
          title: 'Scan your invitation',
          description: 'Point your camera at the private QR code.',
        ),
        Column(
          children: [
            const ScannerFrame(hint: 'Hold steady over the QR code'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmasherIcon(SmasherIcons.lock, size: 14, color: c.screen.mutedText),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Nothing is scanned or stored until you confirm.',
                    style: SmasherText.bodySmall
                        .copyWith(color: c.screen.mutedText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
