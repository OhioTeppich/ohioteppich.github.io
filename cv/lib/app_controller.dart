import 'package:flutter/material.dart';

/// Section ids, in document order — mirrors the `id="..."` anchors in the
/// original React site (hero="top").
const sectionOrder = <String>['top', 'about', 'skills', 'experience', 'contact'];

/// Centralised app state: theme, scroll position / active section, command
/// palette visibility and the cursor-glow pointer position. One controller
/// instead of scattered hooks, exposed to the widget tree via [AppScope].
class AppController extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDark => themeMode == ThemeMode.dark;

  final ScrollController scrollController = ScrollController();
  final Map<String, GlobalKey> sectionKeys = {
    for (final id in sectionOrder) id: GlobalKey(debugLabel: id),
  };

  static const double headerHeight = 72;

  bool scrolled = false;
  String activeSection = 'top';
  bool paletteOpen = false;
  bool emailCopied = false;
  Offset? pointerPosition;

  AppController() {
    scrollController.addListener(_onScroll);
  }

  void toggleTheme() {
    themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void openPalette() {
    if (paletteOpen) return;
    paletteOpen = true;
    notifyListeners();
  }

  void closePalette() {
    if (!paletteOpen) return;
    paletteOpen = false;
    emailCopied = false;
    notifyListeners();
  }

  void togglePalette() => paletteOpen ? closePalette() : openPalette();

  void setEmailCopied() {
    emailCopied = true;
    notifyListeners();
  }

  void setPointer(Offset? position) {
    pointerPosition = position;
    notifyListeners();
  }

  void scrollToSection(String id) {
    final key = sectionKeys[id];
    final renderObject = key?.currentContext?.findRenderObject();
    if (renderObject is! RenderBox || !scrollController.hasClients) return;
    final globalY = renderObject.localToGlobal(Offset.zero).dy;
    final target = scrollController.offset + globalY - headerHeight - 8;
    scrollController.animateTo(
      target.clamp(0.0, scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onScroll() {
    final wasScrolled = scrolled;
    scrolled = scrollController.offset > 12;

    String best = 'top';
    for (final id in sectionOrder) {
      final renderObject = sectionKeys[id]?.currentContext?.findRenderObject();
      if (renderObject is! RenderBox) continue;
      final top = renderObject.localToGlobal(Offset.zero).dy;
      if (top <= headerHeight + 24) {
        best = id;
      }
    }

    if (wasScrolled != scrolled || best != activeSection) {
      activeSection = best;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }
}

/// Makes an [AppController] available to the whole subtree, rebuilding
/// dependents whenever it calls `notifyListeners()`.
class AppScope extends InheritedNotifier<AppController> {
  const AppScope({super.key, required AppController controller, required super.child})
    : super(notifier: controller);

  static AppController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'No AppScope found in context');
    return scope!.notifier!;
  }
}
