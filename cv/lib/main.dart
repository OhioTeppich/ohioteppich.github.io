import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_controller.dart';
import 'theme/app_theme.dart';
import 'widgets/about_section.dart';
import 'widgets/command_palette.dart';
import 'widgets/contact_section.dart';
import 'widgets/cursor_glow.dart';
import 'widgets/experience_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/site_footer.dart';
import 'widgets/site_nav.dart';
import 'widgets/skills_section.dart';

void main() {
  runApp(const CvApp());
}

class CvApp extends StatefulWidget {
  const CvApp({super.key});

  @override
  State<CvApp> createState() => _CvAppState();
}

class _CvAppState extends State<CvApp> {
  final AppController _controller = AppController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      controller: _controller,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return MaterialApp(
            title: 'Christian Maciosek',
            debugShowCheckedModeBanner: false,
            themeMode: _controller.themeMode,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            home: const _HomePage(),
          );
        },
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final _focusNode = FocusNode();

  bool _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) return false;
    final app = AppScope.of(context);
    final isK = event.logicalKey == LogicalKeyboardKey.keyK;
    final modifier = HardwareKeyboard.instance.isControlPressed || HardwareKeyboard.instance.isMetaPressed;
    if (isK && modifier) {
      app.togglePalette();
      return true;
    }
    if (event.logicalKey == LogicalKeyboardKey.slash && !app.paletteOpen) {
      app.openPalette();
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);

    return Scaffold(
      body: Focus(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (node, event) => _handleKey(event) ? KeyEventResult.handled : KeyEventResult.ignored,
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerHover: (e) => app.setPointer(e.position),
          child: MouseRegion(
            onExit: (_) => app.setPointer(null),
            child: Stack(
              children: [
                const Positioned.fill(child: CursorGlow()),
                SingleChildScrollView(
                  controller: app.scrollController,
                  child: const Column(
                    children: [
                      HeroSection(),
                      AboutSection(),
                      SkillsSection(),
                      ExperienceSection(),
                      ContactSection(),
                      SiteFooter(),
                    ],
                  ),
                ),
                const Positioned(top: 0, left: 0, right: 0, child: SiteNav()),
                if (app.paletteOpen) const Positioned.fill(child: CommandPalette()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
