# Smasher — Flutter app

A private-circle app for couples and close friends: Together, Moments, Stories,
Messages and Profile. It is built pixel-for-pixel from the Smasher Figma file.

> **Status:** complete UI and navigation (front-end only). All data is demo
> data held in memory; there is no backend, login server or payments yet.

## Run it

Requirements: Flutter 3.22+ (Dart 3.4+).

```bash
# 1. Generate the platform folders (only needed once — they are not in the repo)
flutter create . --platforms android,ios,web --org com.smasher

# 2. Install packages
flutter pub get

# 3. Run
flutter run                 # phone / emulator
flutter run -d chrome       # browser
```

Build release files:

```bash
flutter build apk --release        # Android
flutter build ios --release        # iOS (needs a Mac + Xcode)
flutter build web --release        # Web
```

## Reviewing screens

- Every screen has a route. On web, open `/#/<route>` directly, e.g.
  `/#/messages/chat` or `/#/premium`. All routes are listed in
  `lib/src/app/routes.dart`.
- In debug builds, the floating buttons (bottom-right) toggle dark mode and
  open the **component gallery**, which links to every screen and state.

## Project structure

```
lib/
  main.dart                     App entry, theme, deep-link handling
  src/app/routes.dart           Every route name and the navigation wiring
  src/theme/                    Colours, typography, spacing, icons (SVG), tokens
  src/widgets/                  Shared components (buttons, headers, cards, nav…)
  src/screens/
    onboarding_screens.dart     Splash, welcome, sign up, login, PIN, Face ID
    *circle* / invite*          P02 — circle setup and invitations
    module_homes.dart           Tab home screens
    together_screens.dart       P03 — Together
    moments_screens.dart        P04 — Moments
    profile_screens.dart        P05 — Profile & settings
    stories_screens.dart        P06 — Stories
    messages_screens.dart       P07 — Messages
    circle_safety_screens.dart  P08 — Circle, privacy & safety, account
    extras_screens.dart         Screens not in Figma (notifications, Premium,
                                legal/help, permissions, appearance…)
    gallery.dart                Debug gallery of all screens
assets/                         Images / fonts folder
DESIGN_NOTES.md                 Design decisions and Figma measurements
```

## What still needs to be done for production

1. **Backend** — accounts, circles, messages, stories, media storage and push
   notifications (e.g. Firebase or a custom API). Replace the `Demo*` classes
   with real data.
2. **Payments** — connect Premium to App Store / Google Play billing.
3. **Content** — replace placeholder Terms, Privacy Policy, Help text and
   Premium prices; add real photos to `assets/images`.
4. **Store setup** — app icon, splash image, bundle ID, signing keys.
