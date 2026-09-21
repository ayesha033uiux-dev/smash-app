import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'src/app/routes.dart';
import 'src/screens/extras_screens.dart' show AppSettings;
import 'src/theme/app_theme.dart';

void main() => runApp(const SmasherApp());

class SmasherApp extends StatefulWidget {
  const SmasherApp({super.key});

  @override
  State<SmasherApp> createState() => _SmasherAppState();
}

class _SmasherAppState extends State<SmasherApp> {
  final _routes = smasherRoutes();

  /// The URL's route when the app is opened on one, otherwise the splash.
  static String get _initial {
    final link = PlatformDispatcher.instance.defaultRouteName;
    return link == '/' ? Routes.splash : link;
  }

  void _toggleTheme() {
    final m = AppSettings.themeMode;
    m.value = m.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppSettings.themeMode,
      builder: (context, mode, _) => MaterialApp(
      title: 'Smasher',
      debugShowCheckedModeBanner: false,
      theme: SmasherTheme.light(),
      darkTheme: SmasherTheme.dark(),
      themeMode: mode,
      routes: _routes,
      builder: (context, child) {
        if (!kDebugMode || child == null) return child ?? const SizedBox();
        return _DevOverlay(onToggleTheme: _toggleTheme, child: child);
      },
      initialRoute: _initial,
      // A deep link (e.g. /#/messages/chat) opens that screen over the app
      // shell, so every screen can be reviewed straight from its URL.
      onGenerateInitialRoutes: (name) {
        Route<void> page(String n) => MaterialPageRoute<void>(
              settings: RouteSettings(name: n),
              builder: _routes[n] ?? _routes[Routes.splash]!,
            );
        if (name == Routes.splash || !_routes.containsKey(name)) {
          return [page(Routes.splash)];
        }
        if (name == Routes.home) return [page(Routes.home)];
        return [page(Routes.home), page(name)];
      },
    ),
    );
  }
}

/// Debug-only affordances so the design system can be reviewed without
/// wiring temporary buttons into real screens. Never ships: the whole
/// overlay is behind kDebugMode.
class _DevOverlay extends StatelessWidget {
  const _DevOverlay({required this.child, required this.onToggleTheme});

  final Widget child;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final c = context.palette;
    return Stack(
      children: [
        child,
        Positioned(
          right: 8,
          bottom: 110,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DevButton(
                  icon: context.isDark ? Icons.light_mode : Icons.dark_mode,
                  tooltip: 'Toggle theme',
                  onTap: onToggleTheme,
                  color: c.textPrimary,
                  background: c.surfaceElevated,
                ),
                const SizedBox(height: 8),
                _DevButton(
                  icon: Icons.widgets_outlined,
                  tooltip: 'Component gallery',
                  onTap: () => Navigator.of(context).pushNamed(Routes.gallery),
                  color: c.textPrimary,
                  background: c.surfaceElevated,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DevButton extends StatelessWidget {
  const _DevButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.color,
    required this.background,
  });

  /// A constant from [SmasherIcons].
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    // Deliberately not a Tooltip: this overlay is installed through
    // MaterialApp.builder, which sits above the Navigator, so there is no
    // Overlay ancestor in scope and Tooltip would assert. Semantics gives the
    // same label without needing one.
    return Semantics(
      label: tooltip,
      button: true,
      child: Material(
        color: background,
        shape: const CircleBorder(),
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 36,
            height: 36,
            child: Icon(icon, size: 18, color: color),
          ),
        ),
      ),
    );
  }
}
