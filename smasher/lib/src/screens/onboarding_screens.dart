import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/onboarding.dart';
import '../widgets/primitives.dart';

/// Onboarding & Entry, sections 01–11: splash, welcome, 18+, privacy,
/// account, email code, profile photo, PIN, Face ID, ready, log in, PIN
/// unlock, password recovery. Every state artboard is reachable either
/// through the flow or by opening the screen in that state (gallery).

/// Demo account state shared by the flow until there is a backend.
abstract final class DemoAuth {
  static String pin = '123456';
  static String email = 'jamie@example.com';
  static const initials = 'JM';
  static const lockAfter = 5;
}

final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

// ─── 01 Splash ───────────────────────────────────────────────────────────────

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.onDone});

  final VoidCallback? onDone;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1600), () => widget.onDone?.call());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onDone,
      child: Container(
        decoration: const BoxDecoration(gradient: ObGradient.night),
        alignment: Alignment.center,
        child: const ObLogo(large: true),
      ),
    );
  }
}

// ─── 02 Welcome ──────────────────────────────────────────────────────────────

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, this.onStart, this.onLogin});

  final VoidCallback? onStart;
  final VoidCallback? onLogin;

  @override
  Widget build(BuildContext context) {
    return ObScaffold(
      back: false,
      top: [
        const SizedBox(height: 12),
        const Align(alignment: Alignment.centerLeft, child: ObLogo()),
        const _WelcomeHero(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'A private space',
              style: ObText.headline.copyWith(color: ObInk.muted),
            ),
            const SizedBox(height: 6),
            Text('for the people you trust.', style: ObText.headline),
          ],
        ),
        Text(
          'Explore shared ideas, discover what feels mutual, and plan '
          'moments together — privately.',
          style: ObText.body.copyWith(color: ObInk.body),
        ),
      ],
      bottom: [
        Row(
          children: [
            const SmasherIcon(SmasherIcons.lock, size: 11, color: ObInk.muted),
            const SizedBox(width: 8),
            Text(
              'Private by invitation',
              style: ObText.small.copyWith(color: ObInk.muted),
            ),
          ],
        ),
        ObButton(label: 'Get Started', onPressed: onStart),
        ObButton(
          label: 'I already have an account',
          kind: ObButtonKind.tertiary,
          onPressed: onLogin,
        ),
      ],
    );
  }
}

/// Pattern/Hero (Dark) — 200 tall r28 night gradient, pad 24; title 24/32
/// and a 75% subtitle, with the circle-of-people illustration above.
///
/// The file places a raster illustration here; it is redrawn as vectors
/// (five ringed silhouettes, largest in the middle) so it stays sharp at
/// every density.
class _WelcomeHero extends StatelessWidget {
  const _WelcomeHero();

  @override
  Widget build(BuildContext context) {
    Widget person(double d) => Container(
          width: d,
          height: d,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0x33FFFFFF),
            border: Border.all(color: const Color(0xCCEDE6FD), width: 2),
          ),
          alignment: Alignment.bottomCenter,
          child: SmasherIcon(
            SmasherIcons.profile,
            size: d * 0.78,
            color: const Color(0xFFE4D9FF),
          ),
        );

    return Container(
      height: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: ObGradient.night,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Opacity(
            opacity: 0.8,
            child: SizedBox(
              height: 66,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  person(34),
                  Transform.translate(
                    offset: const Offset(-6, 0),
                    child: person(44),
                  ),
                  Transform.translate(
                    offset: const Offset(-10, 0),
                    child: person(62),
                  ),
                  Transform.translate(
                    offset: const Offset(-14, 0),
                    child: person(44),
                  ),
                  Transform.translate(
                    offset: const Offset(-20, 0),
                    child: person(34),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Text(
            'Only you and your circle',
            textAlign: TextAlign.center,
            style: ObText.heroTitle.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Nothing leaves this space.',
            textAlign: TextAlign.center,
            style: ObText.body.copyWith(
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 03 18+ Confirmation ─────────────────────────────────────────────────────

class AgeGateScreen extends StatefulWidget {
  const AgeGateScreen({super.key, this.onContinue, this.initial = CheckState.idle});

  final VoidCallback? onContinue;
  final CheckState initial;

  @override
  State<AgeGateScreen> createState() => _AgeGateScreenState();
}

class _AgeGateScreenState extends State<AgeGateScreen> {
  late CheckState _state = widget.initial;

  @override
  Widget build(BuildContext context) {
    final ok = _state == CheckState.selected;
    return ObScaffold(
      top: [
        const SizedBox(height: 8),
        const ObScreenIcon(SmasherIcons.shieldCheck),
        Text('18+ only', style: ObText.headline),
        Text(
          'Smasher is a private space for adults. You must be 18 or older to '
          'continue.',
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        ObCard(
          children: [
            ObCheckbox(
              label: 'I confirm that I am 18 or older.',
              state: _state,
              onTap: () => setState(
                () => _state = ok ? CheckState.idle : CheckState.selected,
              ),
            ),
          ],
        ),
      ],
      bottom: [
        if (_state == CheckState.error)
          const ObFeedback(
            'Please confirm that you are 18 or older to continue.',
          ),
        Text(
          'By continuing, you agree to our Terms of Service and acknowledge '
          'our Privacy Policy.',
          style: ObText.small.copyWith(color: ObInk.muted),
        ),
        ObButton(
          label: 'Continue',
          enabled: ok,
          onPressed: widget.onContinue,
          onDisabledTap: () => setState(() => _state = CheckState.error),
        ),
      ],
    );
  }
}

// ─── 04 Privacy & Consent ────────────────────────────────────────────────────

class PrivacyConsentScreen extends StatelessWidget {
  const PrivacyConsentScreen({super.key, this.onAccept, this.onReadPolicy});

  final VoidCallback? onAccept;
  final VoidCallback? onReadPolicy;

  static const _points = [
    (
      icon: SmasherIcons.users,
      title: 'Private circles',
      body: 'Connect only with people you choose to trust.',
    ),
    (
      icon: SmasherIcons.checkCircle,
      title: 'Consent first',
      body: 'Your interest stays private until it is mutual.',
    ),
    (
      icon: SmasherIcons.settings,
      title: 'You’re in control',
      body: 'Manage your boundaries, privacy and sharing at any time.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ObScaffold(
      top: [
        const SizedBox(height: 8),
        const ObScreenIcon(SmasherIcons.lock),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your privacy',
              style: ObText.headline.copyWith(color: ObInk.muted),
            ),
            const SizedBox(height: 4),
            Text('comes first.', style: ObText.headline),
          ],
        ),
        Text(
          'Your circle is private. Your reactions stay private. You decide '
          'what you share and who can see it.',
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        Column(
          children: [
            for (final p in _points) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ObInk.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: ObShadow.card,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: ObGradient.brand,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: SmasherIcon(p.icon, size: 24, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.title, style: ObText.bodyStrong),
                          const SizedBox(height: 2),
                          Text(
                            p.body,
                            style: ObText.small.copyWith(color: ObInk.body),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (p != _points.last) const SizedBox(height: 12),
            ],
          ],
        ),
      ],
      bottom: [
        ObButton(label: 'I understand', onPressed: onAccept),
        ObButton(
          label: 'Read Privacy Policy',
          kind: ObButtonKind.link,
          onPressed: onReadPolicy,
        ),
      ],
    );
  }
}

// ─── 05 Create Account ───────────────────────────────────────────────────────

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({
    super.key,
    this.onCreated,
    this.onLogin,
    this.demoState,
  });

  final VoidCallback? onCreated;
  final VoidCallback? onLogin;

  /// 'error' or 'valid' pre-fills the matching artboard (gallery).
  final String? demoState;

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  late final _name = TextEditingController(
    text: widget.demoState == 'valid' ? 'Jamie' : '',
  );
  late final _email = TextEditingController(
    text: switch (widget.demoState) {
      'valid' => 'jamie@example.com',
      'error' => 'jamie@',
      _ => '',
    },
  );
  late final _password = TextEditingController(
    text: widget.demoState == 'valid' ? 'smasher#2026' : '',
  );
  late bool _showEmailError = widget.demoState == 'error';

  bool get _passwordOk =>
      _password.text.length >= 8 &&
      RegExp(r'\d').hasMatch(_password.text) &&
      RegExp(r'[^A-Za-z0-9]').hasMatch(_password.text);

  bool get _valid =>
      _name.text.trim().isNotEmpty &&
      _emailPattern.hasMatch(_email.text.trim()) &&
      _passwordOk;

  @override
  Widget build(BuildContext context) {
    final filled = _valid;
    return ObScaffold(
      top: [
        const SizedBox(height: 4),
        Text('Create your account', style: ObText.headline),
        Text(
          'Set up your private Smasher account. You can change your profile '
          'details later.',
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        ObCard(
          children: [
            ObInput(
              label: 'Name',
              hint: 'Enter your name',
              controller: _name,
              onChanged: (_) => setState(() {}),
            ),
            Focus(
              onFocusChange: (f) {
                if (!f && _email.text.isNotEmpty) {
                  setState(
                    () => _showEmailError =
                        !_emailPattern.hasMatch(_email.text.trim()),
                  );
                }
              },
              child: ObInput(
                label: 'Email',
                hint: 'you@example.com',
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                error: _showEmailError ? 'Enter a valid email address.' : null,
                onChanged: (_) => setState(() {
                  if (_emailPattern.hasMatch(_email.text.trim())) {
                    _showEmailError = false;
                  }
                }),
              ),
            ),
            ObInput(
              label: 'Password',
              hint: 'Create a password',
              controller: _password,
              password: true,
              helper: filled
                  ? null
                  : 'Use at least 8 characters, including a number and a '
                      'symbol.',
              onChanged: (_) => setState(() {}),
            ),
          ],
        ),
      ],
      bottom: [
        ObButton(
          label: 'Create account',
          enabled: filled,
          onPressed: () {
            DemoAuth.email = _email.text.trim();
            widget.onCreated?.call();
          },
          onDisabledTap: () => setState(
            () => _showEmailError = _email.text.isNotEmpty &&
                !_emailPattern.hasMatch(_email.text.trim()),
          ),
        ),
        ObButton(
          label: 'Already have an account? Log in',
          kind: ObButtonKind.tertiary,
          onPressed: widget.onLogin,
        ),
      ],
    );
  }
}

// ─── 06 Email Verification ───────────────────────────────────────────────────

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({
    super.key,
    this.onVerified,
    this.onChangeEmail,
    this.demoState,
  });

  final VoidCallback? onVerified;
  final VoidCallback? onChangeEmail;

  /// 'error' or 'filled' (gallery).
  final String? demoState;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late String _code = widget.demoState == null ? '' : '284917';
  late bool _error = widget.demoState == 'error';

  /// Demo rule: the code in the file's error artboard is the "wrong" one.
  static const _wrong = '284917';

  @override
  Widget build(BuildContext context) {
    return ObScaffold(
      top: [
        const SizedBox(height: 8),
        const ObScreenIcon(SmasherIcons.mail),
        Text('Check your inbox', style: ObText.headline),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We sent a 6-digit verification code to',
              style: ObText.body.copyWith(color: ObInk.body),
            ),
            const SizedBox(height: 20),
            Text(DemoAuth.email, style: ObText.bodyStrong),
          ],
        ),
        ObCard(
          center: true,
          children: [
            ObOtpInput(
              initial: _code,
              error: _error
                  ? 'That code is incorrect. Check your email and try again.'
                  : null,
              onChanged: (v) => setState(() {
                _code = v;
                _error = false;
              }),
            ),
            Text(
              'Didn’t receive the code?',
              textAlign: TextAlign.center,
              style: ObText.small.copyWith(color: ObInk.body),
            ),
            ObButton(
              label: 'Resend code',
              kind: ObButtonKind.link,
              expand: false,
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('A new code is on its way.')),
              ),
            ),
          ],
        ),
      ],
      bottom: [
        ObButton(
          label: 'Verify email',
          enabled: _code.length == 6,
          onPressed: () {
            if (_code == _wrong && !_error && widget.demoState == null) {
              setState(() => _error = true);
              return;
            }
            widget.onVerified?.call();
          },
        ),
        ObButton(
          label: 'Change email',
          kind: ObButtonKind.tertiary,
          onPressed: widget.onChangeEmail,
        ),
      ],
    );
  }
}

// ─── 07 Profile Setup ────────────────────────────────────────────────────────

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({
    super.key,
    this.onDone,
    this.denied = false,
  });

  final VoidCallback? onDone;

  /// P 07 — Permission denied.
  final bool denied;

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  late bool _denied = widget.denied;

  @override
  Widget build(BuildContext context) {
    return ObScaffold(
      top: [
        const SizedBox(height: 4),
        Text('Set up your profile', style: ObText.headline),
        Text(
          'Add a photo so people in your circle can recognize you.',
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        Center(
          child: SizedBox(
            width: 124,
            height: 124,
            child: Stack(
              children: [
                // Gradient ring, 6px, around a white 112px disc.
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: ObGradient.brand,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ObInk.surface,
                    ),
                    alignment: Alignment.center,
                    child: const SmasherIcon(
                      SmasherIcons.profile,
                      size: 52,
                      color: ObInk.disabledInk,
                    ),
                  ),
                ),
                Positioned(
                  left: 86,
                  top: 72,
                  child: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ObInk.brand,
                      border: Border.all(color: ObInk.page, width: 3),
                    ),
                    child: const SmasherIcon(
                      SmasherIcons.upload,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      bottom: [
        if (_denied)
          const ObFeedback(
            'Photo access is turned off. Enable it in your device settings '
            'to choose a photo.',
            kind: FeedbackKind.warning,
          ),
        ObButton(
          label: _denied ? 'Continue without photo' : 'Add photo',
          onPressed: _denied
              ? widget.onDone
              : () => setState(() => _denied = true),
        ),
        ObButton(
          label: 'Skip for now',
          kind: ObButtonKind.tertiary,
          onPressed: widget.onDone,
        ),
      ],
    );
  }
}

// ─── 08 / 09 Create & Confirm PIN ────────────────────────────────────────────

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key, this.onContinue, this.initial = ''});

  final ValueChanged<String>? onContinue;
  final String initial;

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  late String _pin = widget.initial;

  @override
  Widget build(BuildContext context) {
    return ObScaffold(
      top: [
        const SizedBox(height: 4),
        Text('Create your private PIN', style: ObText.headline),
        Text(
          'Use this PIN to unlock Smasher when you return.',
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        ObPinCard(
          tall: true,
          showLock: true,
          child: ObPinDots(
            length: _pin.length,
            helper: 'Choose a PIN you don’t use for other accounts.',
          ),
        ),
      ],
      bottom: [
        ObKeypad(
          onDigit: (d) {
            if (_pin.length < 6) setState(() => _pin += d);
          },
          onDelete: () {
            if (_pin.isNotEmpty) {
              setState(() => _pin = _pin.substring(0, _pin.length - 1));
            }
          },
        ),
        ObButton(
          label: 'Continue',
          enabled: _pin.length == 6,
          onPressed: () => widget.onContinue?.call(_pin),
        ),
      ],
    );
  }
}

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({
    super.key,
    required this.expected,
    this.onConfirmed,
    this.onStartOver,
    this.demoError = false,
  });

  final String expected;
  final VoidCallback? onConfirmed;
  final VoidCallback? onStartOver;
  final bool demoError;

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  late String _pin = widget.demoError ? '000000' : '';
  late bool _error = widget.demoError;

  @override
  Widget build(BuildContext context) {
    return ObScaffold(
      gap: 24,
      bottomGap: 8,
      top: [
        Text('Confirm your PIN', style: ObText.headlineSmall),
        Text(
          'Enter your PIN again to make sure everything is correct.',
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        ObPinCard(
          child: ObPinDots(
            length: _pin.length,
            state: _error ? PinState.error : PinState.idle,
          ),
        ),
        if (_error) const ObFeedback('The PINs don’t match. Try again.'),
      ],
      bottom: [
        ObKeypad(
          onDigit: (d) => setState(() {
            if (_error) {
              _pin = '';
              _error = false;
            }
            if (_pin.length < 6) _pin += d;
          }),
          onDelete: () => setState(() {
            _error = false;
            if (_pin.isNotEmpty) _pin = _pin.substring(0, _pin.length - 1);
          }),
        ),
        const SizedBox(height: 16),
        ObButton(
          label: 'Confirm PIN',
          enabled: _pin.length == 6,
          onPressed: () {
            if (_pin == widget.expected) {
              DemoAuth.pin = _pin;
              widget.onConfirmed?.call();
            } else {
              setState(() => _error = true);
            }
          },
        ),
        ObButton(
          label: 'Start over',
          kind: ObButtonKind.tertiary,
          onPressed: widget.onStartOver,
        ),
      ],
    );
  }
}

// ─── 10 Face ID ──────────────────────────────────────────────────────────────

enum FaceIdState { offer, unavailable, off }

class FaceIdScreen extends StatelessWidget {
  const FaceIdScreen({
    super.key,
    this.state = FaceIdState.offer,
    this.onEnable,
    this.onSkip,
    this.onRetry,
    this.onOpenSettings,
  });

  final FaceIdState state;
  final VoidCallback? onEnable;
  final VoidCallback? onSkip;
  final VoidCallback? onRetry;
  final VoidCallback? onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final note = switch (state) {
      FaceIdState.offer => 'You can change this anytime in Security Settings.',
      FaceIdState.unavailable =>
        'Your PIN always works, even when Face ID does not.',
      FaceIdState.off => null,
    };

    final top = switch (state) {
      FaceIdState.offer => [
          const Center(child: ObDisc(icon: SmasherIcons.scanFace)),
          Text(
            'Unlock faster',
            textAlign: TextAlign.center,
            style: ObText.headlineSmall,
          ),
          Text(
            'Use Face ID to securely unlock Smasher in seconds. Your PIN will '
            'always be available as a backup.',
            textAlign: TextAlign.center,
            style: ObText.body.copyWith(color: ObInk.body),
          ),
          Column(
            children: [
              for (final b in const [
                'Faster and secure access',
                'No need to enter your PIN every time',
                'Your PIN remains available as backup',
              ]) ...[
                Row(
                  children: [
                    const SmasherIcon(
                      SmasherIcons.check,
                      size: 18,
                      color: ObInk.brand,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        b,
                        style: ObText.small.copyWith(color: ObInk.body),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
          ObButton(label: 'Enable Face ID', onPressed: onEnable),
          ObButton(
            label: 'Not now',
            kind: ObButtonKind.tertiary,
            onPressed: onSkip,
          ),
        ],
      // The file shows a sample face photo inside a 238px error-tinted disc;
      // redrawn here with the Face ID glyph so no stock photo ships.
      FaceIdState.unavailable => [
          const Center(
            child: ObDisc(
              icon: SmasherIcons.scanFace,
              size: 238,
              iconSize: 96,
              color: ObInk.errorTint,
              ink: ObInk.error,
              border: ObInk.error,
            ),
          ),
          Text(
            'Face ID unavailable',
            textAlign: TextAlign.center,
            style: ObText.headlineSmall,
          ),
          const ObFeedback(
            'We couldn’t verify your Face ID. Please check your device '
            'settings or try again.',
          ),
          ObButton(label: 'Try again', onPressed: onRetry),
          ObButton(
            label: 'Use PIN instead',
            kind: ObButtonKind.secondary,
            onPressed: onSkip,
          ),
        ],
      FaceIdState.off => [
          const Center(
            child: ObDisc(
              icon: SmasherIcons.scanFace,
              color: ObInk.warningTint,
              ink: ObInk.warning,
              border: ObInk.warning,
            ),
          ),
          Text(
            'Face ID is turned off',
            textAlign: TextAlign.center,
            style: ObText.headlineSmall,
          ),
          Text(
            'You can turn Face ID on later from your device settings. Your '
            'PIN keeps working either way.',
            textAlign: TextAlign.center,
            style: ObText.body.copyWith(color: ObInk.body),
          ),
          const ObFeedback(
            'Face ID access is turned off in your device settings.',
            kind: FeedbackKind.warning,
          ),
          ObButton(label: 'Continue with PIN', onPressed: onSkip),
          ObButton(
            label: 'Open Settings',
            kind: ObButtonKind.tertiary,
            onPressed: onOpenSettings,
          ),
        ],
    };

    return ObScaffold(
      centerTop: true,
      gap: 24,
      top: top,
      bottom: [
        if (note != null)
          Text(
            note,
            textAlign: TextAlign.center,
            style: ObText.small.copyWith(color: ObInk.muted),
          ),
      ],
    );
  }
}

// ─── 11 Account Ready ────────────────────────────────────────────────────────

class AccountReadyScreen extends StatelessWidget {
  const AccountReadyScreen({super.key, this.onContinue, this.faceId = true});

  final VoidCallback? onContinue;
  final bool faceId;

  @override
  Widget build(BuildContext context) {
    return ObScaffold(
      back: false,
      centerTop: true,
      gap: 24,
      top: [
        const Center(
          child: ObDisc(icon: SmasherIcons.check, size: 104, iconSize: 44),
        ),
        Text(
          'You’re all set!',
          textAlign: TextAlign.center,
          style: ObText.headlineSmall,
        ),
        Text(
          'Your account is ready. Next, connect with the people you trust.',
          textAlign: TextAlign.center,
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        if (faceId)
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: ObInk.successTint,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'Face ID is enabled',
                style: ObText.badge.copyWith(color: ObInk.success),
              ),
            ),
          ),
        ObButton(label: 'Continue', onPressed: onContinue),
      ],
      bottom: [
        Text(
          'You can change your security and privacy settings anytime.',
          textAlign: TextAlign.center,
          style: ObText.small.copyWith(color: ObInk.muted),
        ),
      ],
    );
  }
}

// ─── 13 Login ────────────────────────────────────────────────────────────────

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    this.onLoggedIn,
    this.onForgot,
    this.onFaceId,
    this.onSignUp,
    this.demoState,
  });

  final VoidCallback? onLoggedIn;
  final VoidCallback? onForgot;
  final VoidCallback? onFaceId;
  final VoidCallback? onSignUp;

  /// 'invalid' or 'valid' (gallery).
  final String? demoState;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final _email = TextEditingController(
    text: widget.demoState == 'valid' ? DemoAuth.email : '',
  );
  late final _password = TextEditingController(
    text: widget.demoState == 'valid' ? 'smasher#2026' : '',
  );
  late bool _invalid = widget.demoState == 'invalid';

  bool get _ready =>
      _email.text.trim().isNotEmpty && _password.text.isNotEmpty;

  void _submit() {
    // Demo rule: anything that is not a well-formed email, or a password
    // under 8 characters, is "incorrect".
    final ok = _emailPattern.hasMatch(_email.text.trim()) &&
        _password.text.length >= 8;
    if (ok) {
      widget.onLoggedIn?.call();
    } else {
      setState(() => _invalid = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ObScaffold(
      gap: 24,
      bottomGap: 8,
      top: [
        Text('Welcome back', style: ObText.headlineSmall),
        Text(
          'Your private space is waiting.',
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        ObCard(
          outlined: true,
          children: [
            ObInput(
              label: 'Email',
              hint: 'you@example.com',
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              error: _invalid ? '' : null,
              onChanged: (_) => setState(() => _invalid = false),
            ),
            ObInput(
              label: 'Password',
              hint: 'Enter your password',
              controller: _password,
              password: true,
              error: _invalid ? '' : null,
              onChanged: (_) => setState(() => _invalid = false),
            ),
            if (_invalid) const ObFeedback('Email or password is incorrect.'),
            Align(
              alignment: Alignment.centerRight,
              child: ObButton(
                label: 'Forgot password?',
                kind: ObButtonKind.link,
                expand: false,
                onPressed: widget.onForgot,
              ),
            ),
          ],
        ),
      ],
      bottom: [
        ObButton(label: 'Log in', enabled: _ready || _invalid, onPressed: _submit),
        ObButton(
          label: 'Use Face ID',
          kind: ObButtonKind.secondary,
          onPressed: widget.onFaceId,
        ),
        const SizedBox(height: 12),
        ObButton(
          label: 'Don’t have an account? Get started',
          kind: ObButtonKind.tertiary,
          onPressed: widget.onSignUp,
        ),
      ],
    );
  }
}

// ─── 14 PIN Unlock ───────────────────────────────────────────────────────────

class PinUnlockScreen extends StatefulWidget {
  const PinUnlockScreen({
    super.key,
    this.onUnlocked,
    this.onFaceId,
    this.onOtherMethod,
    this.demoState,
  });

  final VoidCallback? onUnlocked;
  final VoidCallback? onFaceId;
  final VoidCallback? onOtherMethod;

  /// 'incorrect' or 'locked' (gallery).
  final String? demoState;

  @override
  State<PinUnlockScreen> createState() => _PinUnlockScreenState();
}

class _PinUnlockScreenState extends State<PinUnlockScreen> {
  String _pin = '';
  late int _attempts = switch (widget.demoState) {
    'incorrect' => 1,
    'locked' => DemoAuth.lockAfter,
    _ => 0,
  };
  late bool _error = widget.demoState == 'incorrect';

  bool get _locked => _attempts >= DemoAuth.lockAfter;

  void _digit(String d) {
    setState(() {
      if (_error) {
        _error = false;
        _pin = '';
      }
      _pin += d;
    });
    if (_pin.length == 6) {
      if (_pin == DemoAuth.pin) {
        widget.onUnlocked?.call();
      } else {
        setState(() {
          _attempts++;
          _error = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ObScaffold(
      gap: 24,
      bottomGap: 8,
      top: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ObInk.field,
                border: Border.all(color: ObInk.disabledBorder),
              ),
              child: Text(
                DemoAuth.initials,
                style: ObText.label.copyWith(color: ObInk.body),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              DemoAuth.email,
              style: ObText.label.copyWith(color: ObInk.body),
            ),
          ],
        ),
        Text('Welcome back', style: ObText.headlineSmall),
        Text(
          'Enter your PIN to continue.',
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        ObPinCard(
          child: ObPinDots(
            length: _pin.length,
            state: _locked
                ? PinState.disabled
                : _error
                    ? PinState.error
                    : PinState.idle,
          ),
        ),
        if (_locked)
          const ObFeedback(
            'Too many attempts. Try again in 15 minutes.',
            kind: FeedbackKind.warning,
          )
        else if (_error)
          const ObFeedback('Incorrect PIN. Please try again.'),
      ],
      bottom: [
        ObKeypad(
          enabled: !_locked,
          onDigit: _digit,
          onDelete: () => setState(() {
            _error = false;
            if (_pin.isNotEmpty) _pin = _pin.substring(0, _pin.length - 1);
          }),
        ),
        const SizedBox(height: 16),
        ObButton(
          label: 'Use Face ID',
          kind: ObButtonKind.secondary,
          enabled: !_locked,
          leadingIcon: _locked ? SmasherIcons.scanFace : null,
          onPressed: widget.onFaceId,
        ),
        ObButton(
          label: 'Use another sign-in method',
          kind: ObButtonKind.tertiary,
          onPressed: widget.onOtherMethod,
        ),
      ],
    );
  }
}

// ─── 15 Forgot Password ──────────────────────────────────────────────────────

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
    this.onCodeSent,
    this.onBackToLogin,
    this.sent = false,
  });

  final VoidCallback? onCodeSent;
  final VoidCallback? onBackToLogin;
  final bool sent;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final _email = TextEditingController(
    text: widget.sent ? DemoAuth.email : '',
  );
  late bool _sent = widget.sent;

  @override
  Widget build(BuildContext context) {
    return ObScaffold(
      gap: 24,
      bottomGap: 8,
      top: [
        const Align(
          alignment: Alignment.centerLeft,
          child: ObDisc(icon: SmasherIcons.mail),
        ),
        Text('Forgot your password?', style: ObText.headlineSmall),
        Text(
          'Enter the email associated with your Smasher account and we’ll '
          'send you a verification code.',
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        ObCard(
          outlined: true,
          children: [
            ObInput(
              label: 'Email',
              hint: 'you@example.com',
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => setState(() => _sent = false),
            ),
            if (_sent)
              GestureDetector(
                onTap: widget.onCodeSent,
                child: const ObFeedback(
                  'If an account exists with this email, we’ll send a '
                  'verification code.',
                  kind: FeedbackKind.success,
                ),
              ),
          ],
        ),
      ],
      bottom: [
        ObButton(
          label: 'Send code',
          enabled: !_sent && _emailPattern.hasMatch(_email.text.trim()),
          onPressed: () {
            setState(() => _sent = true);
            Future<void>.delayed(
              const Duration(milliseconds: 1400),
              () {
                if (mounted) widget.onCodeSent?.call();
              },
            );
          },
        ),
        ObButton(
          label: 'Back to login',
          kind: ObButtonKind.tertiary,
          onPressed: widget.onBackToLogin,
        ),
      ],
    );
  }
}

// ─── 16 Reset Password / 17 Updated ──────────────────────────────────────────

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, this.onUpdated, this.demoState});

  final VoidCallback? onUpdated;

  /// 'mismatch' or 'valid' (gallery).
  final String? demoState;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final _a = TextEditingController(
    text: widget.demoState == null ? '' : 'smasher2026',
  );
  late final _b = TextEditingController(
    text: switch (widget.demoState) {
      'mismatch' => 'smash202',
      'valid' => 'smasher2026',
      _ => '',
    },
  );

  @override
  Widget build(BuildContext context) {
    final p = _a.text;
    final rules = [
      ('At least 8 characters', p.length >= 8),
      ('At least 1 number', RegExp(r'\d').hasMatch(p)),
      ('At least 1 symbol', RegExp(r'[^A-Za-z0-9]').hasMatch(p)),
    ];
    final touched = p.isNotEmpty;
    final mismatch = _b.text.isNotEmpty && _b.text != p;
    final valid = rules.every((r) => r.$2) && _b.text == p;

    return ObScaffold(
      gap: 24,
      top: [
        Text('Create a new password', style: ObText.headlineSmall),
        Text(
          'Choose a new password for your Smasher account.',
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        ObCard(
          outlined: true,
          children: [
            ObInput(
              label: 'New password',
              hint: 'Enter new password',
              controller: _a,
              password: true,
              onChanged: (_) => setState(() {}),
            ),
            ObInput(
              label: 'Confirm password',
              hint: 'Enter password again',
              controller: _b,
              password: true,
              error: mismatch ? 'Passwords don’t match.' : null,
              onChanged: (_) => setState(() {}),
            ),
            Column(
              children: [
                for (final r in rules) ...[
                  Row(
                    children: [
                      SmasherIcon(
                        !touched || r.$2
                            ? SmasherIcons.check
                            : SmasherIcons.close,
                        size: 16,
                        color: !touched
                            ? ObInk.muted
                            : r.$2
                                ? ObInk.success
                                : ObInk.error,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        r.$1,
                        style: ObText.small.copyWith(
                          color: !touched
                              ? ObInk.muted
                              : r.$2
                                  ? ObInk.success
                                  : ObInk.error,
                        ),
                      ),
                    ],
                  ),
                  if (r != rules.last) const SizedBox(height: 8),
                ],
              ],
            ),
          ],
        ),
      ],
      bottom: [
        ObButton(
          label: 'Update password',
          enabled: valid,
          onPressed: widget.onUpdated,
        ),
      ],
    );
  }
}

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key, this.onBackToLogin});

  final VoidCallback? onBackToLogin;

  @override
  Widget build(BuildContext context) {
    return ObScaffold(
      back: false,
      centerTop: true,
      gap: 24,
      top: [
        const Center(
          child: ObDisc(icon: SmasherIcons.check, size: 104, iconSize: 44),
        ),
        Text(
          'Password updated',
          textAlign: TextAlign.center,
          style: ObText.headlineSmall,
        ),
        Text(
          'Your password has been changed successfully. You can now sign in '
          'with your new password.',
          textAlign: TextAlign.center,
          style: ObText.body.copyWith(color: ObInk.body),
        ),
        ObButton(label: 'Back to login', onPressed: onBackToLogin),
      ],
    );
  }
}
