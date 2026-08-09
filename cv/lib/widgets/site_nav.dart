import 'package:flutter/material.dart';
import 'dart:ui';
import '../app_controller.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';

const _links = [
  ('about', 'About'),
  ('skills', 'Skills'),
  ('experience', 'Experience'),
  ('contact', 'Contact'),
];

class SiteNav extends StatelessWidget {
  const SiteNav({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final colors = context.colors;
    final foreground = Theme.of(context).colorScheme.onSurface;
    final wide = MediaQuery.sizeOf(context).width >= 768;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: app.scrolled ? Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8) : Colors.transparent,
        border: Border(bottom: BorderSide(color: app.scrolled ? colors.border : Colors.transparent)),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: app.scrolled ? ImageFilter.blur(sigmaX: 10, sigmaY: 10) : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: SizedBox(
            height: AppController.headerHeight,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1024),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => app.scrollToSection('top'),
                        child: Text(profile.name, style: AppTheme.serif(color: foreground, size: 17, letterSpacing: 0)),
                      ),
                      if (wide)
                        Row(
                          children: [
                            for (final link in _links)
                              _NavLink(
                                label: link.$2,
                                active: app.activeSection == link.$1,
                                onTap: () => app.scrollToSection(link.$1),
                                colors: colors,
                                foreground: foreground,
                              ),
                          ],
                        ),
                      Row(
                        children: [
                          _IconChip(
                            onTap: app.openPalette,
                            colors: colors,
                            foreground: foreground,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (wide) ...[
                                  Text('Search', style: TextStyle(fontSize: 13, color: colors.mutedForeground)),
                                  const SizedBox(width: 8),
                                ],
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(border: Border.all(color: colors.border), borderRadius: BorderRadius.circular(4)),
                                  child: Text('⌘K', style: AppTheme.mono(color: colors.mutedForeground, size: 10, letterSpacing: 0)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _IconChip(
                            onTap: app.toggleTheme,
                            colors: colors,
                            foreground: foreground,
                            child: Icon(app.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined, size: 17, color: colors.mutedForeground),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  final AppColors colors;
  final Color foreground;

  const _NavLink({
    required this.label,
    required this.active,
    required this.onTap,
    required this.colors,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: TextStyle(fontSize: 14, color: active ? foreground : colors.mutedForeground)),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 1,
                width: active ? 20 : 0,
                color: colors.brand,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconChip extends StatelessWidget {
  final VoidCallback onTap;
  final AppColors colors;
  final Color foreground;
  final Widget child;

  const _IconChip({required this.onTap, required this.colors, required this.foreground, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.card.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(border: Border.all(color: colors.border), borderRadius: BorderRadius.circular(8)),
          child: Center(child: child),
        ),
      ),
    );
  }
}
