import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_controller.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';

enum _Group { navigate, actions, elsewhere }

class _Command {
  final String id;
  final String label;
  final String? hint;
  final _Group group;
  final String keywords;
  final IconData icon;
  final VoidCallback perform;
  final bool keepOpen;

  const _Command({
    required this.id,
    required this.label,
    this.hint,
    required this.group,
    this.keywords = '',
    required this.icon,
    required this.perform,
    this.keepOpen = false,
  });
}

/// Ctrl/Cmd+K modal: fuzzy-ish substring search over navigation, actions and
/// external links, with arrow-key navigation and Enter to run.
class CommandPalette extends StatefulWidget {
  const CommandPalette({super.key});

  @override
  State<CommandPalette> createState() => _CommandPaletteState();
}

class _CommandPaletteState extends State<CommandPalette> {
  final _searchFocus = FocusNode();
  final _controller = TextEditingController();
  int _active = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _searchFocus.requestFocus());
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _controller.dispose();
    super.dispose();
  }

  List<_Command> _commands(AppController app) {
    return [
      _Command(
        id: 'nav-about',
        label: 'About',
        hint: 'Who I am',
        group: _Group.navigate,
        keywords: 'bio intro story',
        icon: Icons.person_outline,
        perform: () => app.scrollToSection('about'),
      ),
      _Command(
        id: 'nav-skills',
        label: 'Skills & Stack',
        hint: 'What I build with',
        group: _Group.navigate,
        keywords: 'tech tools languages frameworks',
        icon: Icons.layers_outlined,
        perform: () => app.scrollToSection('skills'),
      ),
      _Command(
        id: 'nav-experience',
        label: 'Experience',
        hint: 'Where I have worked',
        group: _Group.navigate,
        keywords: 'work history jobs timeline',
        icon: Icons.work_outline,
        perform: () => app.scrollToSection('experience'),
      ),
      _Command(
        id: 'nav-contact',
        label: 'Contact',
        hint: 'Get in touch',
        group: _Group.navigate,
        keywords: 'email hire reach message',
        icon: Icons.mail_outline,
        perform: () => app.scrollToSection('contact'),
      ),
      _Command(
        id: 'action-email',
        label: app.emailCopied ? 'Copied to clipboard' : 'Copy email address',
        hint: profile.email,
        group: _Group.actions,
        keywords: 'mail contact copy clipboard',
        icon: app.emailCopied ? Icons.check : Icons.copy_outlined,
        keepOpen: true,
        perform: () {
          Clipboard.setData(ClipboardData(text: profile.email));
          app.setEmailCopied();
        },
      ),
      _Command(
        id: 'action-theme',
        label: app.isDark ? 'Switch to light mode' : 'Switch to dark mode',
        hint: 'Toggle appearance',
        group: _Group.actions,
        keywords: 'theme dark light appearance color',
        icon: app.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        keepOpen: true,
        perform: app.toggleTheme,
      ),
      for (final s in socials)
        _Command(
          id: 'social-${s.label}',
          label: s.label,
          hint: s.handle,
          group: _Group.elsewhere,
          keywords: '${s.label} ${s.handle} social link',
          icon: Icons.north_east,
          perform: () => launchUrl(Uri.parse(s.href), mode: LaunchMode.externalApplication),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final colors = context.colors;
    final foreground = Theme.of(context).colorScheme.onSurface;

    final all = _commands(app);
    final query = _controller.text.trim().toLowerCase();
    final filtered = query.isEmpty
        ? all
        : all.where((c) => '${c.label} ${c.hint ?? ''} ${c.keywords}'.toLowerCase().contains(query)).toList();

    if (_active >= filtered.length) _active = filtered.isEmpty ? 0 : filtered.length - 1;

    void run(_Command c) {
      c.perform();
      if (!c.keepOpen) app.closePalette();
    }

    void onKey(KeyEvent event) {
      if (event is! KeyDownEvent) return;
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        app.closePalette();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        if (filtered.isNotEmpty) setState(() => _active = (_active + 1) % filtered.length);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        if (filtered.isNotEmpty) setState(() => _active = (_active - 1 + filtered.length) % filtered.length);
      } else if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (filtered.isNotEmpty) run(filtered[_active]);
      }
    }

    final groups = [
      (_Group.navigate, 'Navigate'),
      (_Group.actions, 'Actions'),
      (_Group.elsewhere, 'Elsewhere'),
    ];

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: app.closePalette,
            child: Container(color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.7)),
          ),
        ),
        Align(
          alignment: const Alignment(0, -0.55),
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: onKey,
            autofocus: true,
            child: Material(
              color: colors.card,
              elevation: 24,
              borderRadius: BorderRadius.circular(14),
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.border))),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Icon(Icons.search, size: 18, color: colors.mutedForeground),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                focusNode: _searchFocus,
                                onChanged: (_) => setState(() => _active = 0),
                                style: TextStyle(fontSize: 15, color: foreground),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search or jump to…',
                                  hintStyle: TextStyle(color: colors.mutedForeground),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                              ),
                            ),
                            Text('esc', style: AppTheme.mono(color: colors.mutedForeground, size: 10, letterSpacing: 0)),
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.5),
                        child: filtered.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 48),
                                child: Column(
                                  children: [
                                    Icon(Icons.auto_awesome, size: 18, color: colors.mutedForeground),
                                    const SizedBox(height: 8),
                                    Text('No matches', style: TextStyle(fontSize: 14, color: foreground)),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Try "experience", "email" or "theme".',
                                      style: TextStyle(fontSize: 12, color: colors.mutedForeground),
                                    ),
                                  ],
                                ),
                              )
                            : ListView(
                                padding: const EdgeInsets.all(8),
                                shrinkWrap: true,
                                children: [
                                  for (final group in groups)
                                    if (filtered.any((c) => c.group == group.$1)) ...[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                                        child: Text(group.$2, style: AppTheme.mono(color: colors.mutedForeground, size: 10)),
                                      ),
                                      for (final c in filtered.where((c) => c.group == group.$1))
                                        _CommandRow(
                                          command: c,
                                          active: filtered.indexOf(c) == _active,
                                          onTap: () => run(c),
                                          colors: colors,
                                          foreground: foreground,
                                        ),
                                    ],
                                ],
                              ),
                      ),
                      Container(
                        decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.border))),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('↑↓ navigate · ↵ select', style: TextStyle(fontSize: 11, color: colors.mutedForeground)),
                            Text(profile.name, style: AppTheme.mono(color: colors.mutedForeground, size: 10, letterSpacing: 0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CommandRow extends StatelessWidget {
  final _Command command;
  final bool active;
  final VoidCallback onTap;
  final AppColors colors;
  final Color foreground;

  const _CommandRow({
    required this.command,
    required this.active,
    required this.onTap,
    required this.colors,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? colors.brand.withValues(alpha: 0.12) : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: active ? Theme.of(context).scaffoldBackgroundColor : colors.card,
                  border: Border.all(color: colors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(command.icon, size: 16, color: active ? colors.brand : colors.mutedForeground),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(command.label, style: TextStyle(fontSize: 14, color: foreground)),
                    if (command.hint != null)
                      Text(command.hint!, style: TextStyle(fontSize: 11.5, color: colors.mutedForeground)),
                  ],
                ),
              ),
              if (active) Icon(Icons.keyboard_return, size: 15, color: colors.mutedForeground),
            ],
          ),
        ),
      ),
    );
  }
}
