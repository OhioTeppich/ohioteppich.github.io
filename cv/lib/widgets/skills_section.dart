import 'package:flutter/material.dart';
import '../app_controller.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import 'section_heading.dart';
import 'section_wrapper.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final colors = context.colors;
    final wide = MediaQuery.sizeOf(context).width >= 600;

    return SectionWrapper(
      sectionKey: app.sectionKeys['skills']!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            index: '02',
            label: 'Skills & Stack',
            title: 'A toolkit built for speed and longevity.',
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: colors.border),
              borderRadius: BorderRadius.circular(14),
            ),
            clipBehavior: Clip.antiAlias,
            child: wide ? _GridLayout(border: colors.border) : _StackedLayout(),
          ),
        ],
      ),
    );
  }
}

class _GridLayout extends StatelessWidget {
  final Color border;

  const _GridLayout({required this.border});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var row = 0; row < skillGroups.length; row += 2) ...[
          if (row > 0) Container(height: 1, color: border),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _GroupTile(group: skillGroups[row])),
                Container(width: 1, color: border),
                Expanded(
                  child: row + 1 < skillGroups.length
                      ? _GroupTile(group: skillGroups[row + 1])
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _StackedLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final border = context.colors.border;
    return Column(
      children: [
        for (var i = 0; i < skillGroups.length; i++) ...[
          if (i > 0) Container(height: 1, color: border),
          _GroupTile(group: skillGroups[i]),
        ],
      ],
    );
  }
}

class _GroupTile extends StatelessWidget {
  final SkillGroup group;

  const _GroupTile({required this.group});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foreground = Theme.of(context).colorScheme.onSurface;

    return Container(
      color: colors.card,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(group.title, style: AppTheme.mono(color: colors.mutedForeground, size: 10)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in group.items)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(item, style: TextStyle(fontSize: 13, color: foreground.withValues(alpha: 0.9))),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
