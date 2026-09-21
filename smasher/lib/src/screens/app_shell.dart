import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/structures.dart';
import '../app/routes.dart';
import 'module_homes.dart';
import 'messages_screens.dart';
import 'moments_screens.dart';
import 'stories_screens.dart';

/// P02 08 — Main App Shell.
///
/// Holds the five module homes behind the bottom navigation. Each tab keeps
/// its own scroll position, which is why this uses an IndexedStack rather than
/// rebuilding the page on every tap.
class AppShell extends StatefulWidget {
  const AppShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _index = widget.initialIndex;

  static const _pages = <Widget>[
    TogetherHome(),
    _MomentsTab(),
    StoriesActiveHome(),
    MessagesInbox(),
    ProfileHome(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.backgroundPrimary,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: SmasherBottomNav(
        currentIndex: _index,
        badges: const {3: true},
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

/// Moments tab — the active home (P04 02), wired to the module's routes.
class _MomentsTab extends StatelessWidget {
  const _MomentsTab();

  @override
  Widget build(BuildContext context) {
    void go(String r) => Navigator.of(context).pushNamed(r);
    return MomentsActiveHome(
      onOpen: (_) => go(Routes.momentDetail),
      onCalendar: () => go(Routes.calendar),
      onCreate: () => go(Routes.createMoment),
      onPast: () => go(Routes.pastMoments),
    );
  }
}
