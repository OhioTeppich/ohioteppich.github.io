import 'package:flutter/material.dart';
import '../app_controller.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import 'section_wrapper.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final colors = context.colors;
    final foreground = Theme.of(context).colorScheme.onSurface;
    final wide = MediaQuery.sizeOf(context).width >= 640;
    final size = MediaQuery.sizeOf(context);

    return SectionWrapper(
      sectionKey: app.sectionKeys['top']!,
      padding: const EdgeInsets.fromLTRB(24, 140, 24, 80),
      child: SizedBox(
        height: (size.height - 72).clamp(420, 760),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (profile.available) _AvailableBadge(pulse: _pulse, colors: colors),
                if (profile.available) const SizedBox(height: 28),
                Text(
                  profile.name,
                  style: AppTheme.serif(
                    color: foreground,
                    size: wide ? 76 : 48,
                    height: 1.0,
                    letterSpacing: -1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profile.role,
                  style: AppTheme.serif(
                    color: colors.mutedForeground,
                    size: wide ? 26 : 20,
                    style: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 28),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Text(
                    profile.tagline,
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.6,
                      color: foreground.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 20,
                  runSpacing: 12,
                  children: [
                    _ExploreButton(onTap: app.openPalette),
                    GestureDetector(
                      onTap: () => app.scrollToSection('contact'),
                      child: Text(
                        'Or just say hello →',
                        style: TextStyle(fontSize: 14, color: colors.mutedForeground, decoration: TextDecoration.underline, decorationColor: colors.mutedForeground),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (wide)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(profile.location, style: AppTheme.mono(color: colors.mutedForeground)),
                    Text('Scroll to read on', style: AppTheme.mono(color: colors.mutedForeground)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AvailableBadge extends StatelessWidget {
  final Animation<double> pulse;
  final AppColors colors;

  const _AvailableBadge({required this.pulse, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 14, 6),
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(999),
        color: colors.card.withValues(alpha: 0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: pulse,
            builder: (context, _) {
              final t = pulse.value;
              return SizedBox(
                width: 16,
                height: 16,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: (1 - t).clamp(0, 1),
                      child: Container(
                        width: 8 + t * 10,
                        height: 8 + t * 10,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: colors.brand),
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: colors.brand),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          Text('Available for select work', style: TextStyle(fontSize: 12, color: colors.mutedForeground)),
        ],
      ),
    );
  }
}

class _ExploreButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ExploreButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.primary,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Explore this site', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: scheme.onPrimary)),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: scheme.onPrimary.withValues(alpha: 0.2)),
                  borderRadius: BorderRadius.circular(4),
                  color: scheme.onPrimary.withValues(alpha: 0.1),
                ),
                child: Text('⌘K', style: AppTheme.mono(color: scheme.onPrimary, size: 11, letterSpacing: 0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
