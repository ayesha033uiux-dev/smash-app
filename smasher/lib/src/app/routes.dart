import 'package:flutter/material.dart';

import '../screens/app_shell.dart';
import '../screens/approval_screens.dart';
import '../screens/circle_entry_screen.dart';
import '../screens/circle_ready_screen.dart';
import '../screens/circle_safety_screens.dart';
import '../screens/circle_switcher_screen.dart';
import '../screens/create_circle_screen.dart';
import '../screens/enter_code_screen.dart';
import '../screens/extras_screens.dart';
import '../screens/gallery.dart';
import '../screens/invitation_error_screen.dart';
import '../screens/invitation_management_screen.dart';
import '../screens/invite_code_screen.dart';
import '../screens/invite_people_screen.dart';
import '../screens/join_circle_screen.dart';
import '../screens/messages_screens.dart';
import '../screens/moments_screens.dart';
import '../screens/onboarding_screens.dart';
import '../widgets/onboarding.dart' show CheckState;
import '../screens/module_homes.dart';
import '../screens/qr_invitation_screen.dart';
import '../screens/profile_screens.dart';
import '../screens/qr_scanner_screen.dart';
import '../screens/stories_screens.dart';
import '../screens/together_screens.dart';

/// Every route name in one place, so a screen never has to spell one out.
abstract final class Routes {
  static const home = '/';
  static const gallery = '/gallery';

  // P02 — circle setup
  static const circleEntry = '/circle-entry';
  static const createCircle = '/create-circle';
  static const circleReady = '/circle-ready';
  static const invitePeople = '/invite-people';
  static const inviteQr = '/invite-qr';
  static const inviteCode = '/invite-code';

  // P02 — circle admin (opened from Profile → Circle settings)
  static const invitations = '/invitations';
  static const invitationsEmpty = '/invitations/empty';

  // P02 — opened from the circle pill on every module home
  static const circleSwitcher = '/circles';

  // Onboarding & entry
  static const splash = '/splash';
  static const welcome = '/welcome';
  static const ageGate = '/onboarding/age';
  static const ageGateError = '/onboarding/age/error';
  static const ageGateChecked = '/onboarding/age/checked';
  static const privacy = '/onboarding/privacy';
  static const createAccount = '/onboarding/account';
  static const createAccountError = '/onboarding/account/error';
  static const createAccountValid = '/onboarding/account/valid';
  static const verifyEmail = '/onboarding/verify';
  static const verifyEmailError = '/onboarding/verify/error';
  static const verifyEmailFilled = '/onboarding/verify/filled';
  static const profileSetup = '/onboarding/photo';
  static const profileDenied = '/onboarding/photo/denied';
  static const createPin = '/onboarding/pin';
  static const confirmPin = '/onboarding/pin/confirm';
  static const confirmPinError = '/onboarding/pin/confirm/error';
  static const faceId = '/onboarding/face-id';
  static const faceIdUnavailable = '/onboarding/face-id/unavailable';
  static const faceIdOff = '/onboarding/face-id/off';
  static const accountReady = '/onboarding/ready';
  static const login = '/login';
  static const loginInvalid = '/login/invalid';
  static const loginValid = '/login/valid';
  static const pinUnlock = '/unlock';
  static const pinUnlockIncorrect = '/unlock/incorrect';
  static const pinUnlockLocked = '/unlock/locked';
  static const forgotPassword = '/password/forgot';
  static const forgotPasswordSent = '/password/forgot/sent';
  static const resetPassword = '/password/reset';
  static const resetPasswordMismatch = '/password/reset/mismatch';
  static const resetPasswordValid = '/password/reset/valid';
  static const passwordUpdated = '/password/updated';

  // P05 — Profile module
  static const editProfile = '/profile/edit';
  static const boundaries = '/profile/boundaries';
  static const boundaryDetail = '/profile/boundaries/detail';
  static const privacySettings = '/profile/privacy';
  static const profileVisibility = '/profile/privacy/profile';
  static const activityVisibility = '/profile/privacy/activity';
  static const circlePrivacy = '/profile/privacy/circle';
  static const mediaPrivacy = '/profile/privacy/media';
  static const security = '/profile/security';
  static const activeSessions = '/profile/security/sessions';
  static const faceIdSettings = '/profile/security/face-id';
  static const pinSettings = '/profile/security/pin';
  static const notificationSettings = '/profile/notifications';
  static const account = '/profile/account';
  static const logout = '/profile/logout';
  static const deleteAccount = '/profile/delete';
  static const deleteConfirm = '/profile/delete/confirm';
  static const deleteSuccess = '/profile/delete/done';
  static const mediaPicker = '/profile/photo';
  static const removePhoto = '/profile/photo/remove';
  static const safeword = '/profile/safeword';
  static const pause = '/profile/pause';

  // Generated — screens the Figma file does not draw
  static const notificationPermission = '/onboarding/notifications';
  static const notifications = '/notifications';
  static const newChat = '/messages/new';
  static const failedMessage = '/messages/chat/failed';
  static const photoViewer = '/messages/photo';
  static const terms = '/legal/terms';
  static const privacyPolicy = '/legal/privacy';
  static const helpCenter = '/help/center';
  static const contactUs = '/help/contact';
  static const contactSent = '/help/contact/sent';
  static const micPermission = '/permissions/microphone';
  static const cameraPermission = '/permissions/camera';
  static const premium = '/premium';
  static const premiumWelcome = '/premium/welcome';
  static const manageSubscription = '/premium/manage';
  static const cancelSubscription = '/premium/cancel';
  static const appearance = '/settings/appearance';
  static const language = '/settings/language';
  static const forceUpdate = '/update';
  static const maintenance = '/maintenance';
  static const noConnection = '/offline';
  static const storiesArchive = '/stories/archive';

  // P08 — Profile / Circle / Safety
  static const circleOverview = '/circle';
  static const circleEmpty = '/circle/empty';
  static const inviteToCircle = '/circle/invite';
  static const qrInviteP08 = '/circle/invite/qr';
  static const inviteSent = '/circle/invite/sent';
  static const memberProfile = '/circle/member';
  static const manageConnection = '/circle/member/manage';
  static const removeMember = '/circle/member/remove';
  static const memberRemoved = '/circle/member/removed';
  static const blockedPeople = '/safety/blocked';
  static const privacySafety = '/safety';
  static const profilePrivacyP08 = '/safety/profile';
  static const activityPrivacy = '/safety/activity';
  static const messagePrivacy = '/safety/messages';
  static const mediaPrivacyP08 = '/safety/media';
  static const activeSessionsP08 = '/safety/sessions';
  static const signOutDevice = '/safety/sessions/sign-out';
  static const blockPerson = '/safety/block';
  static const unblockPerson = '/safety/unblock';
  static const reportPerson = '/safety/report';
  static const reportDetails = '/safety/report/details';
  static const reportSubmitted = '/safety/report/done';
  static const boundariesP08 = '/circle/member/boundaries';
  static const changeEmail = '/account/email';
  static const verifyNewEmail = '/account/email/verify';
  static const emailUpdated = '/account/email/done';
  static const changePassword = '/account/password';
  static const passwordUpdatedP08 = '/account/password/done';
  static const notificationPreview = '/account/notification-previews';
  static const safewordSettings = '/safety/safeword';
  static const setSafeword = '/safety/safeword/set';
  static const safewordSaved = '/safety/safeword/saved';
  static const deleteAccountP08 = '/account/delete';
  static const deleteReason = '/account/delete/reason';
  static const deleteConfirmP08 = '/account/delete/confirm';
  static const deleteSuccessP08 = '/account/delete/done';
  static const sessionExpired = '/session-expired';
  static const profileLoadError = '/profile/error';
  static const offlineProfile = '/profile/offline';
  static const unsavedChanges = '/profile/unsaved';
  static const circleSettingsP08 = '/circle/settings';
  static const leaveCircle = '/circle/leave';
  static const dataStorage = '/account/data';
  static const downloadData = '/account/data/download';
  static const downloadRequested = '/account/data/requested';
  static const about = '/about';
  static const helpSupport = '/help';
  static const rateSmasher = '/help/rate';

  // P07 — Messages module
  static const messagesSearch = '/messages/search';
  static const messagesEmpty = '/messages/empty';
  static const messagesLoading = '/messages/loading';
  static const messagesError = '/messages/error';
  static const conversation = '/messages/chat';
  static const messageActions = '/messages/chat/actions';
  static const messageReply = '/messages/chat/reply';
  static const attachOptions = '/messages/chat/attach';
  static const messageMediaPicker = '/messages/media';
  static const messageMediaPreview = '/messages/media/preview';
  static const viewOnce = '/messages/view-once';
  static const viewOnceExpired = '/messages/view-once/expired';
  static const voiceRecording = '/messages/chat/voice';
  static const voicePlayer = '/messages/chat/voice-message';
  static const pauseConversation = '/messages/pause';
  static const pausedConversation = '/messages/chat/paused';
  static const circleChat = '/messages/circle';
  static const conversationSettings = '/messages/settings';
  static const safewordSend = '/messages/safeword';
  static const safewordSent = '/messages/safeword/sent';
  static const safewordReceived = '/messages/safeword/received';
  static const storyReplyRef = '/messages/chat/story-reply';
  static const momentRef = '/messages/chat/moment';
  static const deleteMessage = '/messages/delete';
  static const clearConversation = '/messages/clear';
  static const leaveConversation = '/messages/leave';
  static const messagesOffline = '/messages/offline';

  // P06 — Stories module
  static const storiesEmpty = '/stories/empty';
  static const createStory = '/stories/create';
  static const textStory = '/stories/text';
  static const photoStory = '/stories/photo';
  static const storyEditor = '/stories/edit';
  static const storyPreview = '/stories/preview';
  static const storyPublished = '/stories/published';
  static const storyViewer = '/stories/view';
  static const storyViewers = '/stories/viewers';
  static const storyOptions = '/stories/options';
  static const deleteStory = '/stories/delete';
  static const storyDeleted = '/stories/deleted';
  static const storyExpired = '/stories/expired';
  static const videoStory = '/stories/video';
  static const storyMediaPicker = '/stories/media';
  static const storyMediaPermission = '/stories/media/permission';
  static const storyBackgrounds = '/stories/background';
  static const storyMusic = '/stories/music';
  static const storyStickers = '/stories/stickers';
  static const storyLayout = '/stories/layout';
  static const storyFilters = '/stories/filters';
  static const storyPrivacy = '/stories/share-with';
  static const storyActivity = '/stories/activity';
  static const myStory = '/stories/mine';
  static const storyDrafts = '/stories/drafts';
  static const storyPublishing = '/stories/publishing';
  static const storyUploadError = '/stories/error';
  static const storyVoice = '/stories/voice';
  static const storyDraw = '/stories/draw';
  static const storyAdjust = '/stories/adjust';
  static const storyMore = '/stories/more';
  static const storyLocation = '/stories/location';
  static const storyDateTime = '/stories/date';
  static const storyQuestion = '/stories/question';
  static const storyPoll = '/stories/poll';
  static const storyTextTools = '/stories/text/tools';
  static const storiesCaughtUp = '/stories/caught-up';
  static const storyReaction = '/stories/react';
  static const storyReply = '/stories/reply';
  static const deleteDraft = '/stories/drafts/delete';
  static const storiesOffline = '/stories/offline';
  static const draftRecovery = '/stories/drafts/recover';

  // P03 — Together module
  static const dailyQuestion = '/together/question';
  static const dailyAnswered = '/together/question/answered';
  static const dailyResults = '/together/question/results';
  static const ideaDeck = '/together/ideas';
  static const ideaDeckEmpty = '/together/ideas/empty';
  static const ideaDeckError = '/together/ideas/error';
  static const matchDetail = '/together/match';
  static const proposeIdea = '/together/propose';
  static const proposalSent = '/together/proposal/sent';
  static const receivedProposal = '/together/proposal';
  static const proposalAccepted = '/together/proposal/accepted';
  static const suggestTime = '/together/proposal/suggest';
  static const newTimeSent = '/together/proposal/suggest/sent';
  static const declineProposal = '/together/proposal/decline';
  static const togetherEmpty = '/together/empty-states';
  static const togetherLoading = '/together/loading';
  static const togetherError = '/together/error';
  static const togetherOffline = '/together/offline';

  // P04 — Moments module
  static const momentsEmpty = '/moments/empty';
  static const calendar = '/moments/calendar';
  static const calendarDay = '/moments/calendar/day';
  static const calendarEmptyDay = '/moments/calendar/empty-day';
  static const createMoment = '/moments/create';
  static const momentConflict = '/moments/create/conflict';
  static const momentCreated = '/moments/created';
  static const momentDetail = '/moments/detail';
  static const editMoment = '/moments/edit';
  static const cancelMoment = '/moments/cancel';
  static const momentCancelled = '/moments/cancelled';
  static const pastMoments = '/moments/past';
  static const noPastMoments = '/moments/past/empty';
  static const completedMoment = '/moments/past/detail';
  static const momentsLoading = '/moments/loading';
  static const momentsError = '/moments/error';
  static const momentsOffline = '/moments/offline';

  // P02 — joining
  static const joinCircle = '/join-circle';
  static const qrScanner = '/join-scan';
  static const enterCode = '/join-code';
  static const circlePreview = '/join-preview';
  static const waitingApproval = '/join-waiting';
  static const youreIn = '/join-done';

  // P02 — invitation failures
  static const errorNotFound = '/join-error/not-found';
  static const errorExpired = '/join-error/expired';
  static const errorRevoked = '/join-error/revoked';
  static const errorUnavailable = '/join-error/unavailable';
}

/// Placeholder data until there is a backend. One source, so every screen in
/// the flow shows the same circle rather than inventing its own.
abstract final class DemoCircle {
  static const name = 'Our Circle';
  static const initials = 'OC';
  static const members = 3;
  static const inviteCode = 'SMASH-4827';
  static const invitePrefix = 'SMASH';
  static const inviteUrl = 'https://smasher.app/join/$inviteCode';

  static const circles = <CircleSummary>[
    CircleSummary(name: name, initials: initials, members: members),
    CircleSummary(name: 'Weekend Circle', initials: 'WC', members: 4),
  ];

  static const invitations = <PendingInvitation>[
    PendingInvitation(name: 'Jamie', sentLabel: 'Invited today'),
    PendingInvitation(name: 'Alex', sentLabel: 'Invited yesterday'),
    PendingInvitation(
      name: 'Sam',
      sentLabel: 'Invited 3 days ago',
      revoked: true,
    ),
  ];
}

/// The whole P02 flow, wired end to end.
///
/// Each destination is reachable from the screen that offers it, and every
/// terminal screen leads back into the app rather than dead-ending:
///
///   Circle Entry ─┬─ Create Circle ─ Circle Ready ─ Invite People ─┬─ QR
///                 │                       └──────── Enter Smasher │  └ Code
///                 └─ Join Circle ─┬─ QR Scanner ─┐
///                                 └─ Enter Code ─┴─ Circle Preview
///                                       └─ Waiting ─ You're In ─ app shell
///                                       └─ the four error states
Map<String, WidgetBuilder> smasherRoutes() => {
      Routes.home: (ctx) => AppShell(
            initialIndex:
                (ModalRoute.of(ctx)?.settings.arguments as int?) ?? 0,
          ),
      Routes.gallery: (_) => const Gallery(),

      // ----------------------------------------------------------- setup
      Routes.circleEntry: (ctx) => CircleEntryScreen(
            onCreate: () => _go(ctx, Routes.createCircle),
            onJoin: () => _go(ctx, Routes.joinCircle),
          ),
      Routes.createCircle: (ctx) => CreateCircleScreen(
            onCreated: (_) => _go(ctx, Routes.circleReady),
          ),
      Routes.circleReady: (ctx) => CircleReadyScreen(
            circleName: DemoCircle.name,
            initials: DemoCircle.initials,
            memberCount: 1,
            onInvite: () => _go(ctx, Routes.invitePeople),
            onEnter: () => _enterApp(ctx),
          ),
      Routes.invitePeople: (ctx) => InvitePeopleScreen(
            onQr: () => _go(ctx, Routes.inviteQr),
            onCode: () => _go(ctx, Routes.inviteCode),
            onShare: () => _share(ctx, DemoCircle.inviteUrl),
            onSkip: () => _enterApp(ctx),
          ),
      Routes.inviteQr: (ctx) => QrInvitationScreen(
            inviteUrl: DemoCircle.inviteUrl,
            onShare: () => _share(ctx, DemoCircle.inviteUrl),
            onDone: () => _back(ctx),
          ),
      Routes.inviteCode: (ctx) => InviteCodeScreen(
            code: DemoCircle.inviteCode,
            onShare: () => _share(ctx, DemoCircle.inviteUrl),
          ),

      // ---------------------------------------------------------- joining
      Routes.joinCircle: (ctx) => JoinCircleScreen(
            onScan: () => _go(ctx, Routes.qrScanner),
            onEnterCode: () => _go(ctx, Routes.enterCode),
          ),
      Routes.qrScanner: (ctx) => QrScannerScreen(
            onEnterCode: () => _replace(ctx, Routes.enterCode),
            onCancel: () => _back(ctx),
          ),
      Routes.enterCode: (ctx) => EnterCodeScreen(
            prefix: DemoCircle.invitePrefix,
            onSubmit: (_) => _go(ctx, Routes.circlePreview),
          ),
      Routes.circlePreview: (ctx) => CirclePreviewScreen(
            circleName: DemoCircle.name,
            initials: DemoCircle.initials,
            memberCount: DemoCircle.members,
            onRequest: () => _go(ctx, Routes.waitingApproval),
            onNotNow: () => _back(ctx),
          ),
      Routes.waitingApproval: (ctx) => WaitingApprovalScreen(
            // Standing in for polling: a refresh resolves to approval.
            onRefresh: () => _replace(ctx, Routes.youreIn),
            onCancel: () => _popTo(ctx, Routes.joinCircle),
          ),
      Routes.youreIn: (ctx) => YoureInScreen(
            circleName: DemoCircle.name,
            initials: DemoCircle.initials,
            memberCount: DemoCircle.members + 1,
            onEnter: () => _enterApp(ctx),
          ),

      // ----------------------------------------------------------- errors
      Routes.errorNotFound: (ctx) => InvitationErrorScreen.notFound(
            onRetry: () => _replace(ctx, Routes.enterCode),
            onBack: () => _popTo(ctx, Routes.joinCircle),
          ),
      Routes.errorExpired: (ctx) => InvitationErrorScreen.expired(
            onAsk: () => _popTo(ctx, Routes.joinCircle),
          ),
      Routes.errorRevoked: (ctx) => InvitationErrorScreen.revoked(
            onBack: () => _popTo(ctx, Routes.joinCircle),
          ),
      Routes.errorUnavailable: (ctx) =>
          InvitationErrorScreen.circleUnavailable(
            onBack: () => _popTo(ctx, Routes.joinCircle),
          ),
      Routes.invitations: (ctx) => InvitationManagementScreen(
            invitations: DemoCircle.invitations,
            onInvite: () => _go(ctx, Routes.invitePeople),
          ),
      Routes.circleSwitcher: (ctx) => CircleSwitcherScreen(
            circles: DemoCircle.circles,
            onSelect: (_) => _enterApp(ctx),
            onCreate: () => _go(ctx, Routes.createCircle),
          ),
      // ------------------------------------------------------ onboarding
      Routes.splash: (ctx) => SplashScreen(
            onDone: () => _replace(ctx, Routes.welcome),
          ),
      Routes.welcome: (ctx) => WelcomeScreen(
            onStart: () => _go(ctx, Routes.ageGate),
            onLogin: () => _go(ctx, Routes.login),
          ),
      Routes.ageGate: (ctx) => AgeGateScreen(
            onContinue: () => _go(ctx, Routes.privacy),
          ),
      Routes.ageGateError: (ctx) => AgeGateScreen(
            initial: CheckState.error,
            onContinue: () => _go(ctx, Routes.privacy),
          ),
      Routes.ageGateChecked: (ctx) => AgeGateScreen(
            initial: CheckState.selected,
            onContinue: () => _go(ctx, Routes.privacy),
          ),
      Routes.privacy: (ctx) => PrivacyConsentScreen(
            onAccept: () => _go(ctx, Routes.createAccount),
            onReadPolicy: () => _share(ctx, 'https://smasher.app/privacy'),
          ),
      Routes.createAccount: (ctx) => CreateAccountScreen(
            onCreated: () => _go(ctx, Routes.verifyEmail),
            onLogin: () => _go(ctx, Routes.login),
          ),
      Routes.createAccountError: (ctx) => CreateAccountScreen(
            demoState: 'error',
            onCreated: () => _go(ctx, Routes.verifyEmail),
            onLogin: () => _go(ctx, Routes.login),
          ),
      Routes.createAccountValid: (ctx) => CreateAccountScreen(
            demoState: 'valid',
            onCreated: () => _go(ctx, Routes.verifyEmail),
            onLogin: () => _go(ctx, Routes.login),
          ),
      Routes.verifyEmail: (ctx) => EmailVerificationScreen(
            onVerified: () => _go(ctx, Routes.profileSetup),
            onChangeEmail: () => _back(ctx),
          ),
      Routes.verifyEmailError: (ctx) => EmailVerificationScreen(
            demoState: 'error',
            onVerified: () => _go(ctx, Routes.profileSetup),
            onChangeEmail: () => _back(ctx),
          ),
      Routes.verifyEmailFilled: (ctx) => EmailVerificationScreen(
            demoState: 'filled',
            onVerified: () => _go(ctx, Routes.profileSetup),
            onChangeEmail: () => _back(ctx),
          ),
      Routes.profileSetup: (ctx) => ProfileSetupScreen(
            onDone: () => _go(ctx, Routes.createPin),
          ),
      Routes.profileDenied: (ctx) => ProfileSetupScreen(
            denied: true,
            onDone: () => _go(ctx, Routes.createPin),
          ),
      Routes.createPin: (ctx) => CreatePinScreen(
            onContinue: (pin) => Navigator.of(ctx).push(
              MaterialPageRoute<void>(
                settings: const RouteSettings(name: Routes.confirmPin),
                builder: (c) => ConfirmPinScreen(
                  expected: pin,
                  onConfirmed: () => _go(c, Routes.faceId),
                  onStartOver: () => _back(c),
                ),
              ),
            ),
          ),
      Routes.confirmPin: (ctx) => ConfirmPinScreen(
            expected: DemoAuth.pin,
            onConfirmed: () => _go(ctx, Routes.faceId),
            onStartOver: () => _back(ctx),
          ),
      Routes.confirmPinError: (ctx) => ConfirmPinScreen(
            expected: DemoAuth.pin,
            demoError: true,
            onConfirmed: () => _go(ctx, Routes.faceId),
            onStartOver: () => _back(ctx),
          ),
      Routes.faceId: (ctx) => FaceIdScreen(
            onEnable: () => _go(ctx, Routes.notificationPermission),
            onSkip: () => _go(ctx, Routes.notificationPermission),
          ),
      Routes.faceIdUnavailable: (ctx) => FaceIdScreen(
            state: FaceIdState.unavailable,
            onRetry: () => _replace(ctx, Routes.faceId),
            onSkip: () => _go(ctx, Routes.notificationPermission),
          ),
      Routes.faceIdOff: (ctx) => FaceIdScreen(
            state: FaceIdState.off,
            onSkip: () => _go(ctx, Routes.notificationPermission),
            onOpenSettings: () => _share(ctx, 'app-settings:'),
          ),
      Routes.accountReady: (ctx) => AccountReadyScreen(
            onContinue: () => Navigator.of(ctx)
                .pushNamedAndRemoveUntil(Routes.circleEntry, (_) => false),
          ),
      Routes.login: (ctx) => LoginScreen(
            onLoggedIn: () => _go(ctx, Routes.pinUnlock),
            onForgot: () => _go(ctx, Routes.forgotPassword),
            onFaceId: () => _enterApp(ctx),
            onSignUp: () => _go(ctx, Routes.ageGate),
          ),
      Routes.loginInvalid: (ctx) => LoginScreen(
            demoState: 'invalid',
            onLoggedIn: () => _go(ctx, Routes.pinUnlock),
            onForgot: () => _go(ctx, Routes.forgotPassword),
            onFaceId: () => _enterApp(ctx),
            onSignUp: () => _go(ctx, Routes.ageGate),
          ),
      Routes.loginValid: (ctx) => LoginScreen(
            demoState: 'valid',
            onLoggedIn: () => _go(ctx, Routes.pinUnlock),
            onForgot: () => _go(ctx, Routes.forgotPassword),
            onFaceId: () => _enterApp(ctx),
            onSignUp: () => _go(ctx, Routes.ageGate),
          ),
      Routes.pinUnlock: (ctx) => PinUnlockScreen(
            onUnlocked: () => _enterApp(ctx),
            onFaceId: () => _enterApp(ctx),
            onOtherMethod: () => _go(ctx, Routes.login),
          ),
      Routes.pinUnlockIncorrect: (ctx) => PinUnlockScreen(
            demoState: 'incorrect',
            onUnlocked: () => _enterApp(ctx),
            onFaceId: () => _enterApp(ctx),
            onOtherMethod: () => _go(ctx, Routes.login),
          ),
      Routes.pinUnlockLocked: (ctx) => PinUnlockScreen(
            demoState: 'locked',
            onUnlocked: () => _enterApp(ctx),
            onOtherMethod: () => _go(ctx, Routes.login),
          ),
      Routes.forgotPassword: (ctx) => ForgotPasswordScreen(
            onCodeSent: () => _replace(ctx, Routes.resetPassword),
            onBackToLogin: () => _back(ctx),
          ),
      Routes.forgotPasswordSent: (ctx) => ForgotPasswordScreen(
            sent: true,
            onCodeSent: () => _replace(ctx, Routes.resetPassword),
            onBackToLogin: () => _back(ctx),
          ),
      Routes.resetPassword: (ctx) => ResetPasswordScreen(
            onUpdated: () => _replace(ctx, Routes.passwordUpdated),
          ),
      Routes.resetPasswordMismatch: (ctx) => ResetPasswordScreen(
            demoState: 'mismatch',
            onUpdated: () => _replace(ctx, Routes.passwordUpdated),
          ),
      Routes.resetPasswordValid: (ctx) => ResetPasswordScreen(
            demoState: 'valid',
            onUpdated: () => _replace(ctx, Routes.passwordUpdated),
          ),
      Routes.passwordUpdated: (ctx) => PasswordUpdatedScreen(
            onBackToLogin: () => Navigator.of(ctx)
                .pushNamedAndRemoveUntil(Routes.login, (_) => false),
          ),

      // ---------------------------------------------------------- P05
      Routes.editProfile: (ctx) => EditProfileScreen(
            onSave: () => _back(ctx),
            onChangePhoto: () => _go(ctx, Routes.mediaPicker),
            onRemovePhoto: () => _go(ctx, Routes.removePhoto),
          ),
      Routes.boundaries: (ctx) => BoundariesScreen(
            onOpen: (title) => Navigator.of(ctx).push(
              MaterialPageRoute<void>(
                settings: const RouteSettings(name: Routes.boundaryDetail),
                builder: (c) => BoundaryDetailScreen(
                  title: title,
                  onSave: () => _back(c),
                ),
              ),
            ),
          ),
      Routes.boundaryDetail: (ctx) => BoundaryDetailScreen(
            onSave: () => _back(ctx),
          ),
      Routes.privacySettings: (ctx) => PrivacySettingsScreen(
            onOpen: (k) => _go(
              ctx,
              switch (k) {
                'profile' => Routes.profileVisibility,
                'activity' => Routes.activityVisibility,
                'media' => Routes.mediaPrivacy,
                _ => Routes.circlePrivacy,
              },
            ),
          ),
      Routes.profileVisibility: (_) => const VisibilityScreen(),
      Routes.activityVisibility: (_) => const VisibilityScreen(
            title: 'Activity visibility',
            lead: 'Choose who can see your recent activity.',
            noun: 'activity',
          ),
      Routes.circlePrivacy: (_) => const CirclePrivacyScreen(),
      Routes.mediaPrivacy: (_) => const MediaPrivacyScreen(),
      Routes.security: (ctx) => SecurityScreen(
            onPin: () => _go(ctx, Routes.pinSettings),
            onSessions: () => _go(ctx, Routes.activeSessionsP08),
            onLogout: () => _go(ctx, Routes.logout),
          ),
      Routes.activeSessions: (_) => const ActiveSessionsScreen(),
      Routes.faceIdSettings: (_) => const FaceIdSettingsScreen(),
      Routes.pinSettings: (ctx) => PinSettingsScreen(
            onChange: () => _go(ctx, Routes.createPin),
            onTurnOff: () => _back(ctx),
          ),
      Routes.notificationSettings: (_) => const NotificationSettingsScreen(),
      Routes.account: (ctx) => AccountSettingsScreen(
            onEmail: () => _go(ctx, Routes.changeEmail),
            onPassword: () => _go(ctx, Routes.changePassword),
            onSecurity: () => _go(ctx, Routes.security),
            onPrivacy: () => _go(ctx, Routes.privacySafety),
            onData: () => _go(ctx, Routes.dataStorage),
            onSubscription: () => _go(
              ctx,
              DemoPremium.active ? Routes.manageSubscription : Routes.premium,
            ),
            subscriptionLabel: DemoPremium.active
                ? 'Premium · ${DemoPremium.yearly ? 'Yearly' : 'Monthly'}'
                : 'Free plan',
            onAppearance: () => _go(ctx, Routes.appearance),
            onLanguage: () => _go(ctx, Routes.language),
            onHelp: () => _go(ctx, Routes.helpSupport),
            onAbout: () => _go(ctx, Routes.about),
            onLogout: () => _go(ctx, Routes.logout),
            onDelete: () => _go(ctx, Routes.deleteAccountP08),
          ),
      Routes.logout: (ctx) => LogoutScreen(
            onLogout: () => Navigator.of(ctx)
                .pushNamedAndRemoveUntil(Routes.welcome, (_) => false),
            onStay: () => _back(ctx),
          ),
      Routes.deleteAccount: (ctx) => DeleteAccountScreen(
            onDelete: () => _go(ctx, Routes.deleteConfirm),
            onKeep: () => _back(ctx),
          ),
      Routes.deleteConfirm: (ctx) => DeleteConfirmScreen(
            onConfirm: () => Navigator.of(ctx)
                .pushNamedAndRemoveUntil(Routes.deleteSuccess, (_) => false),
            onKeep: () => _popTo(ctx, Routes.account),
          ),
      Routes.deleteSuccess: (ctx) => DeleteSuccessScreen(
            onDone: () => Navigator.of(ctx)
                .pushNamedAndRemoveUntil(Routes.welcome, (_) => false),
          ),
      Routes.mediaPicker: (ctx) => MediaPickerScreen(
            onPick: () => _back(ctx),
            onCancel: () => _back(ctx),
          ),
      Routes.removePhoto: (ctx) => RemovePhotoScreen(
            onRemove: () => _back(ctx),
            onKeep: () => _back(ctx),
          ),
      Routes.safeword: (ctx) => SafewordScreen(
            onSave: () => _back(ctx),
          ),
      Routes.pause: (ctx) => PauseScreen(
            onPause: () => _back(ctx),
            onKeep: () => _back(ctx),
          ),

      // ---------------------------------------------------------- P03
      Routes.dailyQuestion: (ctx) => DailyQuestionScreen(
            onSeeResults: () => _replace(ctx, Routes.dailyResults),
          ),
      Routes.dailyAnswered: (ctx) => DailyQuestionScreen(
            answered: true,
            onSeeResults: () => _replace(ctx, Routes.dailyResults),
          ),
      Routes.dailyResults: (ctx) => DailyResultsScreen(
            onExplore: () => _replace(ctx, Routes.ideaDeck),
          ),
      Routes.ideaDeck: (ctx) => IdeaDeckScreen(
            onMatch: (c, idea) => showMatchSheet(
              c,
              idea: idea,
              onPropose: () => _go(ctx, Routes.proposeIdea),
            ),
            onBackToTogether: () => _enterApp(ctx),
          ),
      Routes.ideaDeckEmpty: (ctx) => IdeaDeckScreen(
            initialState: DeckState.empty,
            onBackToTogether: () => _enterApp(ctx),
          ),
      Routes.ideaDeckError: (ctx) => IdeaDeckScreen(
            initialState: DeckState.error,
            onBackToTogether: () => _enterApp(ctx),
          ),
      Routes.matchDetail: (ctx) => MatchDetailScreen(
            onPropose: () => _go(ctx, Routes.proposeIdea),
            onKeepExploring: () => _replace(ctx, Routes.ideaDeck),
          ),
      Routes.proposeIdea: (ctx) => ProposeIdeaScreen(
            onSend: () => _replace(ctx, Routes.proposalSent),
          ),
      Routes.proposalSent: (ctx) => ProposalSentScreen(
            onBackToTogether: () => _enterApp(ctx),
            onViewProposal: () => _replace(ctx, Routes.receivedProposal),
          ),
      Routes.receivedProposal: (ctx) => ReceivedProposalScreen(
            onAccept: () => _replace(ctx, Routes.proposalAccepted),
            onSuggest: () => _go(ctx, Routes.suggestTime),
            onDecline: () => _go(ctx, Routes.declineProposal),
          ),
      Routes.proposalAccepted: (ctx) => ProposalAcceptedScreen(
            onViewMoment: () => _enterApp(ctx, tab: 1),
            onBackToTogether: () => _enterApp(ctx),
          ),
      Routes.suggestTime: (ctx) => SuggestTimeScreen(
            onSend: () => _replace(ctx, Routes.newTimeSent),
          ),
      Routes.newTimeSent: (ctx) => NewTimeSentScreen(
            onBackToTogether: () => _enterApp(ctx),
          ),
      Routes.declineProposal: (ctx) => DeclineProposalScreen(
            onDecline: () => _enterApp(ctx),
            onKeep: () => _back(ctx),
          ),
      Routes.togetherEmpty: (ctx) => TogetherEmptyStatesScreen(
            onExploreIdeas: () => _go(ctx, Routes.ideaDeck),
            onExploreMatches: () => _go(ctx, Routes.matchDetail),
          ),
      Routes.togetherLoading: (_) => const TogetherHomeStateScreen(
            state: TogetherHomeState.loading,
          ),
      Routes.togetherError: (ctx) => TogetherHomeStateScreen(
            state: TogetherHomeState.error,
            onRetry: () => _enterApp(ctx),
          ),
      Routes.togetherOffline: (_) => const TogetherHomeStateScreen(
            state: TogetherHomeState.offline,
          ),
      // ---------------------------------------------------------- P04
      Routes.momentsEmpty: (_) => const Scaffold(body: MomentsHome()),
      Routes.calendar: (ctx) => CalendarScreen(
            onOpen: (_) => _go(ctx, Routes.momentDetail),
            onPlan: () => _go(ctx, Routes.createMoment),
          ),
      Routes.calendarDay: (ctx) => CalendarScreen(
            showDay: true,
            onOpen: (_) => _go(ctx, Routes.momentDetail),
            onPlan: () => _go(ctx, Routes.createMoment),
          ),
      Routes.calendarEmptyDay: (ctx) => CalendarScreen(
            showDay: true,
            initialDay: 30,
            onOpen: (_) => _go(ctx, Routes.momentDetail),
            onPlan: () => _go(ctx, Routes.createMoment),
          ),
      Routes.createMoment: (ctx) => MomentFormScreen(
            onSubmit: () => _replace(ctx, Routes.momentCreated),
          ),
      Routes.momentConflict: (ctx) => MomentFormScreen(
            forceConflict: true,
            onSubmit: () => _replace(ctx, Routes.momentCreated),
          ),
      Routes.momentCreated: (ctx) => MomentCreatedScreen(
            onView: () => _replace(ctx, Routes.momentDetail),
            onBack: () => _enterApp(ctx, tab: 1),
          ),
      Routes.momentDetail: (ctx) => MomentDetailScreen(
            onEdit: () => _go(ctx, Routes.editMoment),
            onCancel: () => _go(ctx, Routes.cancelMoment),
          ),
      Routes.editMoment: (ctx) => MomentFormScreen(
            editing: true,
            onSubmit: () => _back(ctx),
          ),
      Routes.cancelMoment: (ctx) => CancelMomentScreen(
            onCancel: () => _replace(ctx, Routes.momentCancelled),
            onKeep: () => _back(ctx),
          ),
      Routes.momentCancelled: (ctx) => MomentCancelledScreen(
            onBack: () => _enterApp(ctx, tab: 1),
            onPlanNew: () => _replace(ctx, Routes.createMoment),
          ),
      Routes.pastMoments: (ctx) => PastMomentsScreen(
            onOpen: () => _go(ctx, Routes.completedMoment),
          ),
      Routes.noPastMoments: (_) => const PastMomentsScreen(empty: true),
      Routes.completedMoment: (ctx) => MomentDetailScreen(
            moment: DemoMoments.marathon,
            onPlanSimilar: () => _go(ctx, Routes.createMoment),
          ),
      Routes.momentsLoading: (_) => const MomentsHomeStateScreen(
            state: MomentsHomeState.loading,
          ),
      Routes.momentsError: (ctx) => MomentsHomeStateScreen(
            state: MomentsHomeState.error,
            onRetry: () => _enterApp(ctx, tab: 1),
          ),
      Routes.momentsOffline: (_) => const MomentsHomeStateScreen(
            state: MomentsHomeState.offline,
          ),
      Routes.invitationsEmpty: (ctx) => InvitationManagementScreen(
            invitations: const [],
            onInvite: () => _go(ctx, Routes.invitePeople),
          ),

      // ---------------------------------------------------------- P06
      Routes.storiesEmpty: (_) => const Scaffold(body: StoriesActiveHome(empty: true)),
      Routes.createStory: (_) => const CreateStoryScreen(),
      Routes.textStory: (_) => const TextStoryScreen(),
      Routes.photoStory: (_) => const PhotoStoryScreen(),
      Routes.storyEditor: (_) => const StoryEditorScreen(),
      Routes.storyPreview: (_) => const StoryPreviewScreen(),
      Routes.storyPublished: (_) => const StoryPublishedScreen(),
      Routes.storyViewer: (_) => const StoryViewerScreen(),
      Routes.storyViewers: (_) => const StoryViewersScreen(),
      Routes.storyOptions: (_) => const StoryOptionsScreen(),
      Routes.deleteStory: (_) => const DeleteStoryScreen(),
      Routes.storyDeleted: (_) => const StoryDeletedScreen(),
      Routes.storyExpired: (_) => const StoryExpiredScreen(),
      Routes.videoStory: (_) => const VideoStoryScreen(),
      Routes.storyMediaPicker: (_) => const StoryMediaPickerScreen(),
      Routes.storyMediaPermission: (_) => const StoryMediaPermissionScreen(),
      Routes.storyBackgrounds: (_) => const StoryBackgroundsScreen(),
      Routes.storyMusic: (_) => const StoryMusicScreen(),
      Routes.storyStickers: (_) => const StoryStickersScreen(),
      Routes.storyLayout: (_) => const StoryLayoutScreen(),
      Routes.storyFilters: (_) => const StoryFiltersScreen(),
      Routes.storyPrivacy: (_) => const StoryPrivacyScreen(),
      Routes.storyActivity: (_) => const StoryActivityScreen(),
      Routes.myStory: (_) => const MyStoryScreen(),
      Routes.storyDrafts: (_) => const StoryDraftsScreen(),
      Routes.storyPublishing: (_) => const StoryPublishingScreen(),
      Routes.storyUploadError: (_) => const StoryUploadErrorScreen(),
      Routes.storyVoice: (_) => const StoryVoiceScreen(),
      Routes.storyDraw: (_) => const StoryDrawScreen(),
      Routes.storyAdjust: (_) => const StoryAdjustScreen(),
      Routes.storyMore: (_) => const StoryMoreScreen(),
      Routes.storyLocation: (_) => const StoryLocationScreen(),
      Routes.storyDateTime: (_) => const StoryDateTimeScreen(),
      Routes.storyQuestion: (_) => const StoryQuestionScreen(),
      Routes.storyPoll: (_) => const StoryPollScreen(),
      Routes.storyTextTools: (_) => const TextToolsScreen(),
      Routes.storiesCaughtUp: (_) => const StoriesCaughtUpScreen(),
      Routes.storyReaction: (_) => const StoryReactionScreen(),
      Routes.storyReply: (_) => const StoryReplyScreen(),
      Routes.deleteDraft: (_) => const DeleteDraftScreen(),
      Routes.storiesOffline: (_) => const Scaffold(body: StoriesActiveHome(offline: true)),
      Routes.draftRecovery: (_) => const DraftRecoveryScreen(),

      // ---------------------------------------------------------- P07
      Routes.messagesSearch: (_) => const MessagesSearchScreen(),
      Routes.messagesEmpty: (_) => const InboxStateScreen(InboxState.empty),
      Routes.messagesLoading: (_) => const InboxStateScreen(InboxState.loading),
      Routes.messagesError: (_) => const InboxStateScreen(InboxState.error),
      Routes.conversation: (_) => const ConversationScreen(),
      Routes.messageActions: (_) => const ConversationScreen(mode: ChatMode.actions),
      Routes.messageReply: (_) => const ConversationScreen(mode: ChatMode.reply),
      Routes.attachOptions: (_) => const ConversationScreen(mode: ChatMode.attach),
      Routes.messageMediaPicker: (_) => const MessageMediaPickerScreen(),
      Routes.messageMediaPreview: (_) => const MessageMediaPreviewScreen(),
      Routes.viewOnce: (_) => const ViewOnceScreen(),
      Routes.viewOnceExpired: (_) => const ViewOnceExpiredScreen(),
      Routes.voiceRecording: (_) => const ConversationScreen(mode: ChatMode.recording),
      Routes.voicePlayer: (_) => const ConversationScreen(mode: ChatMode.voiceMessage),
      Routes.pauseConversation: (_) => const PauseConversationScreen(),
      Routes.pausedConversation: (_) => const ConversationScreen(mode: ChatMode.paused),
      Routes.circleChat: (_) => const ConversationScreen(circle: true),
      Routes.conversationSettings: (_) => const ConversationSettingsScreen(),
      Routes.safewordSend: (_) => const SafewordSendScreen(),
      Routes.safewordSent: (_) => const SafewordSentScreen(),
      Routes.safewordReceived: (_) => const SafewordReceivedScreen(),
      Routes.storyReplyRef: (_) => const ConversationScreen(mode: ChatMode.storyReply),
      Routes.momentRef: (_) => const ConversationScreen(mode: ChatMode.moment),
      Routes.deleteMessage: (_) => const DeleteMessageScreen(),
      Routes.clearConversation: (_) => const ClearConversationScreen(),
      Routes.leaveConversation: (_) => const LeaveConversationScreen(),
      Routes.messagesOffline: (_) => const InboxStateScreen(InboxState.offline),

      // ---------------------------------------------------------- P08
      Routes.circleOverview: (_) => const CircleOverviewScreen(),
      Routes.circleEmpty: (_) => const CircleEmptyScreen(),
      Routes.inviteToCircle: (_) => const InviteToCircleScreen(),
      Routes.qrInviteP08: (_) => const QrInviteScreen(),
      Routes.inviteSent: (_) => const InviteSentScreen(),
      Routes.memberProfile: (_) => const MemberProfileScreen(),
      Routes.manageConnection: (_) => const ManageConnectionScreen(),
      Routes.removeMember: (_) => const RemoveMemberScreen(),
      Routes.memberRemoved: (_) => const MemberRemovedScreen(),
      Routes.blockedPeople: (_) => const BlockedPeopleScreen(),
      Routes.privacySafety: (_) => const PrivacySafetyScreen(),
      Routes.profilePrivacyP08: (_) => const ProfilePrivacyScreen(),
      Routes.activityPrivacy: (_) => TogglePrivacyScreen(title: 'Activity privacy', lead: 'These settings control what people in your circle can see about your activity.', values: DemoSafety.activity),
      Routes.messagePrivacy: (_) => TogglePrivacyScreen(title: 'Message privacy', lead: 'Control how your private conversations behave.', values: DemoSafety.messages, white: true, subtitles: const {'Message previews': 'Show message text in notifications.'}, links: const {'Message previews': Routes.notificationPreview}),
      Routes.mediaPrivacyP08: (_) => TogglePrivacyScreen(title: 'Media privacy', lead: 'Control how private media is shared and viewed.', values: DemoSafety.media, subtitles: const {'View-once media': "Media disappears after it's viewed.", 'Screenshot protection': 'Available where supported by your device.'}, footnote: "Some protections depend on your device and can't be guaranteed by Smasher."),
      Routes.activeSessionsP08: (_) => const ActiveSessionsP08Screen(),
      Routes.signOutDevice: (_) => const SignOutDeviceScreen(),
      Routes.blockPerson: (_) => const BlockPersonScreen(),
      Routes.unblockPerson: (_) => const UnblockPersonScreen(),
      Routes.reportPerson: (_) => const ReportPersonScreen(),
      Routes.reportDetails: (_) => const ReportDetailsScreen(),
      Routes.reportSubmitted: (_) => const ReportSubmittedScreen(),
      Routes.boundariesP08: (_) => const BoundariesP08Screen(),
      Routes.changeEmail: (_) => const ChangeEmailScreen(),
      Routes.verifyNewEmail: (_) => const VerifyEmailScreen(),
      Routes.emailUpdated: (_) => const EmailUpdatedScreen(),
      Routes.changePassword: (_) => const ChangePasswordScreen(),
      Routes.passwordUpdatedP08: (_) => const PasswordUpdatedScreen2(),
      Routes.notificationPreview: (_) => const NotificationPreviewScreen(),
      Routes.safewordSettings: (_) => const SafewordSettingsScreen(),
      Routes.setSafeword: (_) => const SetSafewordScreen(),
      Routes.safewordSaved: (_) => const SafewordSavedScreen(),
      Routes.deleteAccountP08: (_) => const DeleteAccountP08Screen(),
      Routes.deleteReason: (_) => const DeleteReasonScreen(),
      Routes.deleteConfirmP08: (_) => const DeleteConfirmP08Screen(),
      Routes.deleteSuccessP08: (_) => const DeleteSuccessP08Screen(),
      Routes.sessionExpired: (_) => const SessionExpiredScreen(),
      Routes.profileLoadError: (_) => const ProfileLoadErrorScreen(),
      Routes.offlineProfile: (_) => const OfflineProfileScreen(),
      Routes.unsavedChanges: (_) => const UnsavedChangesScreen(),
      Routes.circleSettingsP08: (_) => const CircleSettingsP08Screen(),
      Routes.leaveCircle: (_) => const LeaveCircleScreen(),
      Routes.dataStorage: (_) => const DataStorageScreen(),
      Routes.downloadData: (_) => const DownloadDataScreen(),
      Routes.downloadRequested: (_) => const DownloadRequestedScreen(),
      Routes.about: (_) => const AboutScreen(),
      Routes.helpSupport: (_) => const HelpSupportScreen(),
      Routes.rateSmasher: (_) => const RateSmasherScreen(),

      // ---------------------------------------------------- generated
      Routes.notificationPermission: (ctx) => NotificationPermissionScreen(
            onDone: () => _go(ctx, Routes.accountReady),
          ),
      Routes.notifications: (_) => const NotificationsScreen(),
      Routes.newChat: (_) => const NewChatScreen(),
      Routes.failedMessage: (_) => const ConversationScreen(mode: ChatMode.failed),
      Routes.photoViewer: (_) => const PhotoViewerScreen(),
      Routes.terms: (_) => LegalScreen.terms(),
      Routes.privacyPolicy: (_) => LegalScreen.privacy(),
      Routes.helpCenter: (_) => const HelpCenterScreen(),
      Routes.contactUs: (_) => const ContactUsScreen(),
      Routes.contactSent: (_) => const ContactSentScreen(),
      Routes.micPermission: (_) => const PermissionScreen.microphone(),
      Routes.cameraPermission: (_) => const PermissionScreen.camera(),
      Routes.premium: (_) => const PremiumScreen(),
      Routes.premiumWelcome: (_) => const PremiumWelcomeScreen(),
      Routes.manageSubscription: (_) => const ManageSubscriptionScreen(),
      Routes.cancelSubscription: (_) => const CancelSubscriptionScreen(),
      Routes.appearance: (_) => const AppearanceScreen(),
      Routes.language: (_) => const LanguageScreen(),
      Routes.forceUpdate: (_) => const ForceUpdateScreen(),
      Routes.maintenance: (_) => const MaintenanceScreen(),
      Routes.noConnection: (_) => const NoConnectionScreen(),
      Routes.storiesArchive: (_) => const StoriesArchiveScreen(),
    };

void _go(BuildContext ctx, String route) =>
    Navigator.of(ctx).pushNamed(route);

void _replace(BuildContext ctx, String route) =>
    Navigator.of(ctx).pushReplacementNamed(route);

void _back(BuildContext ctx) => Navigator.of(ctx).maybePop();

/// Unwind to a screen already on the stack, or land on it fresh if it is not.
void _popTo(BuildContext ctx, String route) {
  final nav = Navigator.of(ctx);
  var found = false;
  nav.popUntil((r) {
    if (r.settings.name == route) found = true;
    return found || r.isFirst;
  });
  if (!found) nav.pushNamed(route);
}

/// Every terminal screen in the flow ends here: the module shell, with the
/// setup stack cleared so Back cannot walk into it again.
/// Back into the app shell, optionally on a given tab (1 = Moments).
void _enterApp(BuildContext ctx, {int tab = 0}) => Navigator.of(ctx)
    .pushNamedAndRemoveUntil(Routes.home, (_) => false, arguments: tab);

/// The real share sheet is a platform call. Until it is wired, say so rather
/// than leaving the button dead.
void _share(BuildContext ctx, String url) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(content: Text('Share sheet not wired yet — $url')),
  );
}
