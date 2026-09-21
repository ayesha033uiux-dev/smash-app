import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/controls.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// P02 09 — Enter Invite Code.
///
/// Content block at gap 12: the uppercase field label, the segmented
/// [CodeField], and a compact helper strip. The CTA stays disabled until all
/// four characters are in.
class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({
    super.key,
    this.prefix = 'SMASH',
    this.onSubmit,
  });

  final String prefix;
  final ValueChanged<String>? onSubmit;

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  var _code = '';

  @override
  Widget build(BuildContext context) {
    final complete = _code.length == 4;
    return ScreenScaffold(
      header: const BackHeader(),
      bottomBar: BottomActionBar.single(
        SmasherButton(
          label: 'Request to join',
          onPressed: complete
              ? () => widget.onSubmit?.call('${widget.prefix}-$_code')
              : null,
        ),
      ),
      children: [
        const HeadBlock(
          icon: SmasherIcons.key,
          eyebrow: 'Join · Code',
          title: 'Enter your invitation code',
          description: 'Use the code shared with you by someone in the circle.',
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SmasherLabel('Invite code', tone: LabelTone.muted),
            const SizedBox(height: 12),
            CodeField(
              prefix: widget.prefix,
              onChanged: (v) => setState(() => _code = v),
            ),
            const SizedBox(height: 12),
            const InfoStrip(
              compact: true,
              text: 'Codes are single-use and only work for the person they '
                  'were shared with.',
            ),
          ],
        ),
      ],
    );
  }
}
