import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/controls.dart';
import '../widgets/module.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// One row on the Invitation Management list.
class PendingInvitation {
  const PendingInvitation({
    required this.name,
    required this.sentLabel,
    this.revoked = false,
  });

  final String name;

  /// "Invited today", "Invited yesterday"…
  final String sentLabel;
  final bool revoked;

  PendingInvitation revoke() =>
      PendingInvitation(name: name, sentLabel: sentLabel, revoked: true);
}

/// P02 13 Invitation Management / P02 14 No Pending Invitations.
///
/// One screen: while the list holds anything it shows the Head block, the
/// PENDING INVITATIONS group and a pinned "Invite someone" bar (P02 13); once
/// it is empty the body collapses to the centred empty state and the CTA
/// moves inside it (P02 14).
class InvitationManagementScreen extends StatefulWidget {
  const InvitationManagementScreen({
    super.key,
    required this.invitations,
    this.onInvite,
  });

  final List<PendingInvitation> invitations;
  final VoidCallback? onInvite;

  @override
  State<InvitationManagementScreen> createState() =>
      _InvitationManagementScreenState();
}

class _InvitationManagementScreenState
    extends State<InvitationManagementScreen> {
  late final List<PendingInvitation> _items = [...widget.invitations];

  void _revoke(int i) => setState(() => _items[i] = _items[i].revoke());

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return ScreenScaffold(
        center: true,
        header: const BackHeader(),
        children: [
          EmptyState(
            icon: SmasherIcons.mail,
            title: 'No pending invitations',
            description: 'Invitations you send will appear here.',
            actionLabel: 'Invite someone',
            onAction: widget.onInvite,
          ),
        ],
      );
    }

    final c = context.palette;
    return ScreenScaffold(
      header: const BackHeader(),
      bottomBar: BottomActionBar.single(
        SmasherButton(label: 'Invite someone', onPressed: widget.onInvite),
      ),
      children: [
        const HeadBlock(
          eyebrow: 'Circle admin',
          title: 'Invite people',
          description: 'Manage invitations to your private circle.',
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 11/16 here (11/14 on the eyebrow) — same style, taller box.
            Text(
              'PENDING INVITATIONS',
              style: SmasherText.eyebrow.copyWith(
                color: c.screen.sectionLabel,
                height: 16 / 11,
              ),
            ),
            const SizedBox(height: 10),
            GroupList(
              elevated: true,
              children: [
                for (var i = 0; i < _items.length; i++)
                  _InvitationRow(
                    invitation: _items[i],
                    onRevoke: () => _revoke(i),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Figma: Row/Invitation — h74, pad 16/18, gap 12, 40px initials avatar,
/// name 15 Semi Bold over meta 13 #6B6B78 (gap 2), trailing "Revoke" 13 Semi
/// Bold #52525E. The Revoked variant sits at 60% and swaps the action for a
/// badge.
class _InvitationRow extends StatelessWidget {
  const _InvitationRow({required this.invitation, this.onRevoke});

  final PendingInvitation invitation;
  final VoidCallback? onRevoke;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    final row = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          InitialsAvatar(_initials(invitation.name), size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  invitation.name,
                  style: SmasherText.bodyStrong.copyWith(color: c.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  invitation.revoked ? 'Revoked' : invitation.sentLabel,
                  style: SmasherText.bodySmall.copyWith(color: c.textTertiary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (invitation.revoked)
            // The file's Revoked variant carries the Brand badge as drawn.
            const SmasherBadge('Private')
          else
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onRevoke,
              child: Text(
                'Revoke',
                style: SmasherText.buttonSmall.copyWith(
                  color: c.textSecondary,
                ),
              ),
            ),
        ],
      ),
    );
    return invitation.revoked ? Opacity(opacity: 0.6, child: row) : row;
  }

  static String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length > 1) return '${parts[0][0]}${parts[1][0]}';
    return name.substring(0, name.length < 2 ? name.length : 2);
  }
}
