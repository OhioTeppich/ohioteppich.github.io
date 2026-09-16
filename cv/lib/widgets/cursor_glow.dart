import 'package:flutter/material.dart';
import '../app_controller.dart';
import '../theme/app_theme.dart';

/// Resolves the one accent color used by the complete cursor glow.
Color glowAccent(String pointerSection, Color fallback) {
  return AppColors.sectionAccents[pointerSection] ?? fallback;
}

/// Soft, single-color radial glow that follows the pointer.
class CursorGlow extends StatelessWidget {
  const CursorGlow({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final position = app.pointerPosition;
    final accent = glowAccent(app.pointerSection, context.colors.brand);

    return IgnorePointer(
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            left: (position?.dx ?? -1000) - 320,
            top: (position?.dy ?? -1000) - 320,
            child: AnimatedOpacity(
              opacity: position == null ? 0 : 1,
              duration: const Duration(milliseconds: 250),
              child: Container(
                width: 640,
                height: 640,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      accent.withValues(alpha: context.isDark ? 0.16 : 0.12),
                      accent.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
