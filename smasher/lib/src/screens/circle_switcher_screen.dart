import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/controls.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// One circle the member belongs to.
class CircleSummary {
  const CircleSummary({
    required this.name,
    required this.initials,
    required this.members,
  });

  final String name;
  final String initials;
  final int members;
}

/// P02 24 — Your Circles.
///
/// Opened from the circle pill on every module home. Head block, one elevated
/// group of circle rows, and a solid white bottom bar with a secondary
/// "Create a new circle" button.
class CircleSwitcherScreen extends StatelessWidget {
  const CircleSwitcherScreen({
    super.key,
    required this.circles,
    this.onSelect,
    this.onCreate,
  });

  final List<CircleSummary> circles;
  final ValueChanged<CircleSummary>? onSelect;
  final VoidCallback? onCreate;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BackHeader(),
      bottomBar: BottomActionBar.single(
        SmasherButton(
          label: 'Create a new circle',
          variant: ButtonVariant.secondary,
          onPressed: onCreate,
        ),
        solid: true,
      ),
      children: [
        const HeadBlock(
          eyebrow: 'Your circles',
          title: 'Your circles',
          description: 'Choose the private circle you want to enter.',
        ),
        GroupList(
          elevated: true,
          children: [
            for (final circle in circles)
              _CircleRow(
                circle: circle,
                onTap: onSelect == null ? null : () => onSelect!(circle),
              ),
          ],
        ),
      ],
    );
  }
}

/// Figma: Card/Circle as placed in the list — h88, pad 16/18, gap 12, the
/// instance's own fill and stroke cleared so it reads as a row. 48px initials
/// avatar, title 15 Semi Bold over meta 13 #6B6B78 (gap 2), Brand badge.
class _CircleRow extends StatelessWidget {
  const _CircleRow({required this.circle, this.onTap});

  final CircleSummary circle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            InitialsAvatar(circle.initials),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    circle.name,
                    style: SmasherText.bodyStrong.copyWith(
                      color: c.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    circle.members == 1
                        ? '1 member'
                        : '${circle.members} members',
                    style: SmasherText.bodySmall.copyWith(
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const SmasherBadge('Private'),
          ],
        ),
      ),
    );
  }
}
