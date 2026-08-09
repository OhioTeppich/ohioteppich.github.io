import 'package:flutter/material.dart';
import '../app_controller.dart';
import '../theme/app_theme.dart';

/// Soft radial glow that follows the pointer, tinted by the active section —
/// a lightweight stand-in for the original `CursorBackground` spotlight.
class CursorGlow extends StatelessWidget {
  const CursorGlow({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final position = app.pointerPosition;
    final accent = AppColors.sectionAccents[app.activeSection] ?? context.colors.brand;

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
