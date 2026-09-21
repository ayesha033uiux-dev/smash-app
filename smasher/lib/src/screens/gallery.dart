import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../theme/app_theme.dart';
import '../widgets/controls.dart';
import '../widgets/module.dart';
import '../widgets/primitives.dart';
import '../widgets/structures.dart';

/// Every shared widget on one page, at the measurements taken off the
/// 390x844 artboards. Debug-only — reached from the dev overlay.
class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final _nameController = TextEditingController();
  bool _canSubmit = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.palette;

    return ScreenScaffold(
      header: const BackHeader(title: 'Components'),
      children: [
        const HeadBlock(
          icon: SmasherIcons.shieldCheck,
          eyebrow: 'Design system',
          title: 'Smasher components',
          description: 'Every widget below is measured off the 390x844 '
              'artboards in the Figma file.',
        ),

        const _Section('Module header'),
        const ModuleHeader(circleName: 'Our Circle'),

        const _Section('Hero card'),
        HeroCard(
          eyebrow: 'Daily question',
          title: 'A little question to spark a meaningful moment together.',
          ctaLabel: 'View question',
          onCta: () {},
        ),

        const _Section('Tile cards'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TileCard(
              icon: SmasherIcons.shieldCheck,
              title: 'Matches',
              description: 'Discover what you both have in common.',
              linkLabel: 'View matches',
              onTap: () {},
            ),
            const SizedBox(width: 12),
            TileCard(
              icon: SmasherIcons.moments,
              title: 'Proposals',
              description: 'Ideas waiting for you to explore together.',
              linkLabel: 'View proposals',
              onTap: () {},
            ),
          ],
        ),

        const _Section('Feature card'),
        FeatureCard(
          icon: SmasherIcons.stories,
          title: 'Idea Deck',
          subtitle: 'Pick an idea and make your next moment count.',
          onTap: () {},
        ),

        const _Section('Group list + action cards'),
        GroupList(
          children: [
            ActionCard(
              icon: SmasherIcons.settings,
              title: 'Boundaries',
              subtitle: 'What you are and are not open to, in your own words.',
              onTap: () {},
            ),
            ActionCard(
              icon: SmasherIcons.lock,
              title: 'Security',
              subtitle: 'PIN, Face ID and sign-in.',
              tone: ActionTone.deep,
              onTap: () {},
            ),
          ],
        ),

        const _Section('Empty state'),
        EmptyState(
          icon: SmasherIcons.moments,
          title: 'Nothing planned yet',
          description: 'Your shared moments will appear here once you plan one.',
          actionLabel: 'Plan a Moment',
          onAction: () {},
        ),

        const _Section('Method card + or divider'),
        Column(
          children: [
            MethodCard(
              icon: SmasherIcons.qrCode,
              title: 'Scan the QR code',
              description: 'The fastest way in. Point your camera at the '
                  'invitation someone shared with you.',
              actionLabel: 'Open scanner',
              onAction: () {},
            ),
            const SizedBox(height: 16),
            const OrDivider(),
            const SizedBox(height: 16),
            ActionCard(
              standalone: true,
              icon: SmasherIcons.key,
              title: 'Enter invite code',
              subtitle: 'Use the private code shared with you.',
              onTap: () {},
            ),
          ],
        ),

        const _Section('Info + status rows'),
        const Column(
          children: [
            InfoRowCard(
              icon: SmasherIcons.lock,
              title: 'Private circle',
              subtitle: 'Only approved members can access this circle.',
            ),
            SizedBox(height: 12),
            InfoRowCard(
              centred: true,
              icon: SmasherIcons.clock,
              title: 'Request pending',
              subtitle: 'Sent just now',
            ),
          ],
        ),

        const _Section('Code field'),
        const CodeField(prefix: 'SMASH'),

        const _Section('Scanner'),
        const ScannerFrame(hint: 'Hold steady over the QR code', height: 240),

        const _Section('Status head + badge'),
        const StatusHead(
          icon: SmasherIcons.check,
          title: 'Your circle is ready.',
          description: 'Invite people now or enter your private circle.',
        ),

        const _Section('Circle card'),
        const CircleCard(
          initials: 'OC',
          name: 'Our Circle',
          meta: '1 member',
          badge: 'Private',
        ),

        const _Section('Code card'),
        const CodeCard(
          label: 'Private invite code',
          note: 'Keep this code private.',
          child: Text('SMASH-4827'),
        ),

        const _Section('Info strip'),
        const InfoStrip(
          text: 'Only people you invite can ever see your circle. '
              'Nothing is public.',
        ),

        const _Section('Input'),
        SmasherInput(
          label: 'Circle name',
          hint: 'e.g. Our Circle',
          helper: 'You can change this later.',
          controller: _nameController,
          onChanged: (v) => setState(() => _canSubmit = v.trim().isNotEmpty),
        ),

        const _Section('Buttons'),
        Column(
          children: [
            SmasherButton(
              label: 'Create circle',
              onPressed: _canSubmit ? () {} : null,
            ),
            const SizedBox(height: 12),
            SmasherButton(
              label: 'Continue',
              icon: SmasherIcons.arrowRight,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            SmasherButton(
              label: 'Maybe later',
              variant: ButtonVariant.secondary,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: GradientButton(label: 'Plan a Moment', onPressed: () {}),
            ),
          ],
        ),

        const _Section('Boundary scale'),
        Row(
          children: [
            _Swatch('Yes', c.boundaryYes),
            const SizedBox(width: 8),
            _Swatch('Maybe', c.boundaryMaybe),
            const SizedBox(width: 8),
            _Swatch('No', c.boundaryNo),
          ],
        ),

        const _Section('Composed screens'),
        Column(
          children: [
            for (final entry in const <(String, String)>[
              ('01 Splash', Routes.splash),
              ('02 Welcome', Routes.welcome),
              ('03 18+ — Default', Routes.ageGate),
              ('03 18+ — Error', Routes.ageGateError),
              ('03 18+ — Confirmed', Routes.ageGateChecked),
              ('04 Privacy & Consent', Routes.privacy),
              ('05 Create Account — Default', Routes.createAccount),
              ('05 Create Account — Error', Routes.createAccountError),
              ('05 Create Account — Valid', Routes.createAccountValid),
              ('06 Email Verification', Routes.verifyEmail),
              ('06 Email — Incorrect code', Routes.verifyEmailError),
              ('06 Email — Code entered', Routes.verifyEmailFilled),
              ('07 Profile Setup', Routes.profileSetup),
              ('07 Profile — Permission denied', Routes.profileDenied),
              ('08 Create PIN', Routes.createPin),
              ('09 Confirm PIN', Routes.confirmPin),
              ("09 Confirm PIN — Don't match", Routes.confirmPinError),
              ('10 Face ID', Routes.faceId),
              ('10 Face ID — Unavailable', Routes.faceIdUnavailable),
              ('10 Face ID — Turned off', Routes.faceIdOff),
              ('11 Account Ready', Routes.accountReady),
              ('13 Login', Routes.login),
              ('13 Login — Invalid', Routes.loginInvalid),
              ('13 Login — Valid', Routes.loginValid),
              ('14 PIN Unlock', Routes.pinUnlock),
              ('14 PIN Unlock — Incorrect', Routes.pinUnlockIncorrect),
              ('14 PIN Unlock — Locked', Routes.pinUnlockLocked),
              ('15 Forgot Password', Routes.forgotPassword),
              ('15 Forgot Password — Sent', Routes.forgotPasswordSent),
              ('16 Reset Password', Routes.resetPassword),
              ("16 Reset — Don't match", Routes.resetPasswordMismatch),
              ('16 Reset — Valid', Routes.resetPasswordValid),
              ('17 Password Updated', Routes.passwordUpdated),
              ('P02 01 Circle Entry', Routes.circleEntry),
              ('P02 02 Create Circle', Routes.createCircle),
              ('P02 03 Invite People', Routes.invitePeople),
              ('P02 04 QR Invitation', Routes.inviteQr),
              ('P02 05 Invite Code', Routes.inviteCode),
              ('P02 06 Circle Ready', Routes.circleReady),
              ('P02 07 Join Circle', Routes.joinCircle),
              ('P02 08 QR Scanner', Routes.qrScanner),
              ('P02 09 Enter Invite Code', Routes.enterCode),
              ('P02 10 Circle Preview', Routes.circlePreview),
              ('P02 11 Waiting For Approval', Routes.waitingApproval),
              ("P02 12 You're In", Routes.youreIn),
              ('P02 15 Invitation Not Found', Routes.errorNotFound),
              ('P02 16 Invitation Expired', Routes.errorExpired),
              ('P02 17 Invitation Revoked', Routes.errorRevoked),
              ('P02 18 Circle Unavailable', Routes.errorUnavailable),
              ('P02 13 Invitation Management', Routes.invitations),
              ('P02 14 No Pending Invitations', Routes.invitationsEmpty),
              ('P02 24 Your Circles', Routes.circleSwitcher),
              ('P05 01 Edit Profile', Routes.editProfile),
              ('P05 02 Boundaries', Routes.boundaries),
              ('P05 03 Boundary Detail', Routes.boundaryDetail),
              ('P05 04 Privacy', Routes.privacySettings),
              ('P05 05 Security', Routes.security),
              ('P05 06 Notifications', Routes.notificationSettings),
              ('P05 07 Account', Routes.account),
              ('P05 08 Logout', Routes.logout),
              ('P05 09 Delete Account', Routes.deleteAccount),
              ('P05 10 Delete Confirmation', Routes.deleteConfirm),
              ('P05 11 Delete Success', Routes.deleteSuccess),
              ('P05 12 Media Picker', Routes.mediaPicker),
              ('P05 13 Remove Photo', Routes.removePhoto),
              ('P05 14 Face ID', Routes.faceIdSettings),
              ('P05 15 PIN Settings', Routes.pinSettings),
              ('P05 16 Safeword', Routes.safeword),
              ('P05 17 Pause', Routes.pause),
              ('P05 18 Media Privacy', Routes.mediaPrivacy),
              ('P05 18 Circle Privacy', Routes.circlePrivacy),
              ('P05 19 Profile Visibility', Routes.profileVisibility),
              ('P05 — Active Sessions (generated)', Routes.activeSessions),
              ('+ Notification permission', Routes.notificationPermission),
              ('+ Notifications', Routes.notifications),
              ('+ New message', Routes.newChat),
              ('+ Message failed to send', Routes.failedMessage),
              ('+ Photo viewer', Routes.photoViewer),
              ('+ Terms of Service', Routes.terms),
              ('+ Privacy Policy', Routes.privacyPolicy),
              ('+ Help Center', Routes.helpCenter),
              ('+ Contact us', Routes.contactUs),
              ('+ Message sent', Routes.contactSent),
              ('+ Microphone permission', Routes.micPermission),
              ('+ Camera permission', Routes.cameraPermission),
              ('+ Smasher Premium', Routes.premium),
              ('+ Welcome to Premium', Routes.premiumWelcome),
              ('+ Manage subscription', Routes.manageSubscription),
              ('+ Cancel subscription', Routes.cancelSubscription),
              ('+ Appearance', Routes.appearance),
              ('+ Language', Routes.language),
              ('+ Force update', Routes.forceUpdate),
              ('+ Maintenance', Routes.maintenance),
              ('+ No connection', Routes.noConnection),
              ('+ Past stories', Routes.storiesArchive),
              ('P08 01 Circle Overview', Routes.circleOverview),
              ('P08 02 Circle Empty', Routes.circleEmpty),
              ('P08 03 Invite to Circle', Routes.inviteToCircle),
              ('P08 04 QR Invite', Routes.qrInviteP08),
              ('P08 05 Invite Sent', Routes.inviteSent),
              ('P08 06 Member Profile', Routes.memberProfile),
              ('P08 07 Manage Connection', Routes.manageConnection),
              ('P08 08 Remove Member', Routes.removeMember),
              ('P08 09 Member Removed', Routes.memberRemoved),
              ('P08 10 Blocked People', Routes.blockedPeople),
              ('P08 11 Privacy & Safety', Routes.privacySafety),
              ('P08 12 Profile Privacy', Routes.profilePrivacyP08),
              ('P08 13 Activity Privacy', Routes.activityPrivacy),
              ('P08 14 Message Privacy', Routes.messagePrivacy),
              ('P08 15 Media Privacy', Routes.mediaPrivacyP08),
              ('P08 16 Active Sessions', Routes.activeSessionsP08),
              ('P08 17 Sign Out Device', Routes.signOutDevice),
              ('P08 18 Block Person', Routes.blockPerson),
              ('P08 19 Unblock Person', Routes.unblockPerson),
              ('P08 20 Report Person', Routes.reportPerson),
              ('P08 21 Report Details', Routes.reportDetails),
              ('P08 22 Report Submitted', Routes.reportSubmitted),
              ('P08 23 Boundaries Detail', Routes.boundariesP08),
              ('P08 24 Change Email', Routes.changeEmail),
              ('P08 25 Verify New Email', Routes.verifyNewEmail),
              ('P08 26 Email Updated', Routes.emailUpdated),
              ('P08 27 Change Password', Routes.changePassword),
              ('P08 28 Password Updated', Routes.passwordUpdatedP08),
              ('P08 29 Notification Preview', Routes.notificationPreview),
              ('P08 30 Safeword Settings', Routes.safewordSettings),
              ('P08 31 Set Safeword', Routes.setSafeword),
              ('P08 32 Safeword Saved', Routes.safewordSaved),
              ('P08 33 Delete Account', Routes.deleteAccountP08),
              ('P08 34 Delete Account Reason', Routes.deleteReason),
              ('P08 35 Delete Confirmation', Routes.deleteConfirmP08),
              ('P08 36 Delete Success', Routes.deleteSuccessP08),
              ('P08 37 Session Expired', Routes.sessionExpired),
              ('P08 38 Profile Load Error', Routes.profileLoadError),
              ('P08 39 Offline Profile', Routes.offlineProfile),
              ('P08 40 Unsaved Changes', Routes.unsavedChanges),
              ('P08 41 Circle Settings', Routes.circleSettingsP08),
              ('P08 42 Leave Circle', Routes.leaveCircle),
              ('P08 43 Data & Storage', Routes.dataStorage),
              ('P08 44 Download Your Data', Routes.downloadData),
              ('P08 45 Download Requested', Routes.downloadRequested),
              ('P08 46 About', Routes.about),
              ('P08 47 Help & Support', Routes.helpSupport),
              ('P08 48 Rate Smasher', Routes.rateSmasher),
              ('P07 02 Search Messages', Routes.messagesSearch),
              ('P07 03 Messages Empty', Routes.messagesEmpty),
              ('P07 04 Messages Loading', Routes.messagesLoading),
              ('P07 05 Messages Error', Routes.messagesError),
              ('P07 06 Conversation', Routes.conversation),
              ('P07 07 Message Actions', Routes.messageActions),
              ('P07 08 Reply to Message', Routes.messageReply),
              ('P07 09 Media Attachment Options', Routes.attachOptions),
              ('P07 10 Media Picker', Routes.messageMediaPicker),
              ('P07 11 Media Preview', Routes.messageMediaPreview),
              ('P07 12 View Once Viewer', Routes.viewOnce),
              ('P07 13 View Once Expired', Routes.viewOnceExpired),
              ('P07 14 Voice Recording', Routes.voiceRecording),
              ('P07 15 Voice Message Player', Routes.voicePlayer),
              ('P07 16 Pause Conversation', Routes.pauseConversation),
              ('P07 17 Paused Conversation', Routes.pausedConversation),
              ('P07 18 Circle Chat', Routes.circleChat),
              ('P07 19 Conversation Settings', Routes.conversationSettings),
              ('P07 20 Safeword Send', Routes.safewordSend),
              ('P07 21 Safeword Sent', Routes.safewordSent),
              ('P07 22 Safeword Received', Routes.safewordReceived),
              ('P07 23 Story Reply Reference', Routes.storyReplyRef),
              ('P07 24 Moment Reference', Routes.momentRef),
              ('P07 25 Delete Message', Routes.deleteMessage),
              ('P07 26 Clear Conversation', Routes.clearConversation),
              ('P07 27 Leave Conversation', Routes.leaveConversation),
              ('P07 28 Offline Banner', Routes.messagesOffline),
              ('P06 02 Empty State', Routes.storiesEmpty),
              ('P06 03 Story Type', Routes.createStory),
              ('P06 04 Text Story', Routes.textStory),
              ('P06 05 Photo Story', Routes.photoStory),
              ('P06 06 Story Editor', Routes.storyEditor),
              ('P06 07 Story Preview', Routes.storyPreview),
              ('P06 08 Story Published', Routes.storyPublished),
              ('P06 09 Story Viewer', Routes.storyViewer),
              ('P06 10 Story Viewers', Routes.storyViewers),
              ('P06 11 Story Options', Routes.storyOptions),
              ('P06 12 Delete Story', Routes.deleteStory),
              ('P06 13 Story Deleted', Routes.storyDeleted),
              ('P06 14 Story Expired', Routes.storyExpired),
              ('P06 15 Video Story', Routes.videoStory),
              ('P06 16 Media Picker', Routes.storyMediaPicker),
              ('P06 17 Media Permission', Routes.storyMediaPermission),
              ('P06 18 Backgrounds', Routes.storyBackgrounds),
              ('P06 19 Music', Routes.storyMusic),
              ('P06 20 Stickers', Routes.storyStickers),
              ('P06 21 Layout', Routes.storyLayout),
              ('P06 22 Filters', Routes.storyFilters),
              ('P06 23 Story Privacy', Routes.storyPrivacy),
              ('P06 24 Story Activity', Routes.storyActivity),
              ('P06 25 My Story', Routes.myStory),
              ('P06 26 Drafts', Routes.storyDrafts),
              ('P06 27 Publishing', Routes.storyPublishing),
              ('P06 28 Upload Error', Routes.storyUploadError),
              ('P06 29 Voice Recording', Routes.storyVoice),
              ('P06 30 Draw', Routes.storyDraw),
              ('P06 31 Adjust', Routes.storyAdjust),
              ('P06 32 More Options', Routes.storyMore),
              ('P06 33 Location', Routes.storyLocation),
              ('P06 34 Date Time', Routes.storyDateTime),
              ('P06 35 Question', Routes.storyQuestion),
              ('P06 36 Poll', Routes.storyPoll),
              ('P06 37 Text Tools', Routes.storyTextTools),
              ('P06 38 All Caught Up', Routes.storiesCaughtUp),
              ('P06 39 Reaction', Routes.storyReaction),
              ('P06 40 Reply', Routes.storyReply),
              ('P06 41 Delete Draft', Routes.deleteDraft),
              ('P06 42 Offline', Routes.storiesOffline),
              ('P06 43 Draft Recovery', Routes.draftRecovery),
              ('P03 01 Daily Question', Routes.dailyQuestion),
              ('P03 02 Idea Deck', Routes.ideaDeck),
              ('P03 03 Match Detail', Routes.matchDetail),
              ('P03 05 Propose Idea', Routes.proposeIdea),
              ('P03 06 Proposal Sent', Routes.proposalSent),
              ('P03 07 Received Proposal', Routes.receivedProposal),
              ('P03 08 Proposal Accepted', Routes.proposalAccepted),
              ('P03 09 Suggest Another Time', Routes.suggestTime),
              ('P03 10 Decline Proposal', Routes.declineProposal),
              ('P03 11 Daily Question — Answered', Routes.dailyAnswered),
              ('P03 12 Daily Question — Results', Routes.dailyResults),
              ('P03 14 Idea Deck — Empty', Routes.ideaDeckEmpty),
              ('P03 15 Idea Deck — Error', Routes.ideaDeckError),
              ('P03 16 Empty States', Routes.togetherEmpty),
              ('P03 18 New Time Sent', Routes.newTimeSent),
              ('P03 19 Together — Loading', Routes.togetherLoading),
              ('P03 20 Together — Error', Routes.togetherError),
              ('P03 21 Together — Offline', Routes.togetherOffline),
              ('P04 01 Moments — Empty', Routes.momentsEmpty),
              ('P04 03 Calendar', Routes.calendar),
              ('P04 04 Calendar — Date Selected', Routes.calendarDay),
              ('P04 05 Create Moment', Routes.createMoment),
              ('P04 06 Moment Created', Routes.momentCreated),
              ('P04 07 Moment Detail', Routes.momentDetail),
              ('P04 08 Cancel Moment', Routes.cancelMoment),
              ('P04 09 Past Moments', Routes.pastMoments),
              ('P04 10 Edit Moment', Routes.editMoment),
              ('P04 11 Conflict State', Routes.momentConflict),
              ('P04 12 No Past Moments', Routes.noPastMoments),
              ('P04 13 No Moments on Date', Routes.calendarEmptyDay),
              ('P04 14 Moments — Loading', Routes.momentsLoading),
              ('P04 15 Moments — Error', Routes.momentsError),
              ('P04 16 Moments — Offline', Routes.momentsOffline),
              ('P04 17 Moment Cancelled', Routes.momentCancelled),
              ('P04 18 Completed Moment', Routes.completedMoment),
            ]) ...[
              SmasherButton(
                label: entry.$1,
                variant: ButtonVariant.secondary,
                onPressed: () => Navigator.of(context).pushNamed(entry.$2),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.label);
  final String label;

  @override
  Widget build(BuildContext context) =>
      SmasherLabel(label, tone: LabelTone.muted);
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.label, this.color);
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(SmasherRadius.md),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: SmasherText.bodySmall.copyWith(color: c.textSecondary),
          ),
        ],
      ),
    );
  }
}
