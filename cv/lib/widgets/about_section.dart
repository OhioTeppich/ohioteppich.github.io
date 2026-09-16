import 'package:flutter/material.dart';
import '../app_controller.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import 'section_heading.dart';
import 'section_wrapper.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final colors = context.colors;
    final foreground = Theme.of(context).colorScheme.onSurface;
    final wide = MediaQuery.sizeOf(context).width >= 768;

    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < profile.intro.length; i++) ...[
          if (i > 0) const SizedBox(height: 20),
          Text(
            profile.intro[i],
            style: TextStyle(
              fontSize: i == 0 ? 18 : 16,
              height: 1.65,
              color: i == 0 ? foreground : foreground.withValues(alpha: 0.8),
            ),
          ),
        ],
      ],
    );

    final facts = Container(
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(border: Border(left: BorderSide(color: colors.border))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Fact(label: 'Based in', value: profile.location, colors: colors, foreground: foreground),
          _Fact(label: 'Focus', value: 'Interfaces, tooling & performance', colors: colors, foreground: foreground),
          _Fact(label: 'Experience', value: '+3 years shipping products', colors: colors, foreground: foreground),
          _Fact(label: 'Status', value: 'Open to new work', colors: colors, foreground: colors.brand, isLast: true),
        ],
      ),
    );

    return SectionWrapper(
      sectionKey: app.sectionKeys['about']!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(index: '01', label: 'About', title: 'Engineering that gets out of the way.'),
          wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: intro),
                    const SizedBox(width: 48),
                    Expanded(flex: 2, child: facts),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [intro, const SizedBox(height: 40), facts],
                ),
        ],
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  final String label;
  final String value;
  final AppColors colors;
  final Color foreground;
  final bool isLast;

  const _Fact({
    required this.label,
    required this.value,
    required this.colors,
    required this.foreground,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTheme.mono(color: colors.mutedForeground, size: 10)),
          const SizedBox(height: 4),
          Text(value, style: AppTheme.mono(color: foreground, size: 13, weight: FontWeight.w400, letterSpacing: 0)),
        ],
      ),
    );
  }
}
