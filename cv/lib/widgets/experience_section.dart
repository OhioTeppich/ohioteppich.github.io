import 'package:flutter/material.dart';
import '../app_controller.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import 'section_heading.dart';
import 'section_wrapper.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final colors = context.colors;
    final foreground = Theme.of(context).colorScheme.onSurface;
    final wide = MediaQuery.sizeOf(context).width >= 768;

    return SectionWrapper(
      sectionKey: app.sectionKeys['experience']!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            index: '03',
            label: 'Experience',
            title: 'Eight years, three teams, one obsession with craft.',
          ),
          for (final job in experience)
            Container(
              margin: const EdgeInsets.only(bottom: 32),
              padding: const EdgeInsets.only(top: 32),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.border))),
              child: wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: _JobMeta(job: job, colors: colors, foreground: foreground)),
                        const SizedBox(width: 40),
                        Expanded(flex: 2, child: _JobBody(job: job, colors: colors, foreground: foreground)),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _JobMeta(job: job, colors: colors, foreground: foreground),
                        const SizedBox(height: 16),
                        _JobBody(job: job, colors: colors, foreground: foreground),
                      ],
                    ),
            ),
        ],
      ),
    );
  }
}

class _JobMeta extends StatelessWidget {
  final Job job;
  final AppColors colors;
  final Color foreground;

  const _JobMeta({required this.job, required this.colors, required this.foreground});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(job.period, style: AppTheme.mono(color: colors.mutedForeground, size: 11)),
        const SizedBox(height: 6),
        Text(job.company, style: AppTheme.serif(color: foreground, size: 24)),
        const SizedBox(height: 4),
        Text(job.location, style: TextStyle(fontSize: 13, color: colors.mutedForeground)),
      ],
    );
  }
}

class _JobBody extends StatelessWidget {
  final Job job;
  final AppColors colors;
  final Color foreground;

  const _JobBody({required this.job, required this.colors, required this.foreground});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(job.role, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: foreground)),
        const SizedBox(height: 10),
        Text(job.summary, style: TextStyle(fontSize: 15, height: 1.6, color: foreground.withValues(alpha: 0.8))),
        const SizedBox(height: 16),
        for (final highlight in job.highlights)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: colors.brand),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    highlight,
                    style: TextStyle(fontSize: 13.5, height: 1.55, color: colors.mutedForeground),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
