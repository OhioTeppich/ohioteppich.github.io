import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Mirrors `SectionHeading`: an index/label row on the left, a serif title
/// on the right (stacked on narrow screens), sitting on a top border.
class SectionHeading extends StatelessWidget {
  final String index;
  final String label;
  final String title;

  const SectionHeading({super.key, required this.index, required this.label, required this.title});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foreground = Theme.of(context).colorScheme.onSurface;
    final wide = MediaQuery.sizeOf(context).width >= 768;

    final meta = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(index, style: AppTheme.mono(color: colors.brand)),
        const SizedBox(width: 10),
        Text(label, style: AppTheme.mono(color: colors.mutedForeground)),
      ],
    );

    final titleText = Text(
      title,
      textAlign: wide ? TextAlign.right : TextAlign.left,
      style: AppTheme.serif(color: foreground, size: wide ? 34 : 28, height: 1.15),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 48),
      padding: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.border))),
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [meta, Flexible(child: Align(alignment: Alignment.centerRight, child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 560), child: titleText)))],
            )
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [meta, const SizedBox(height: 14), titleText]),
    );
  }
}
