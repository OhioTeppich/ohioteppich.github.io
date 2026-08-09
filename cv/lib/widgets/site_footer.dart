import 'package:flutter/material.dart';
import '../app_controller.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final colors = context.colors;
    final year = DateTime.now().year;
    final wide = MediaQuery.sizeOf(context).width >= 640;

    final items = [
      Text('© $year ${profile.name}', style: AppTheme.mono(color: colors.mutedForeground, size: 11, letterSpacing: 0)),
      GestureDetector(
        onTap: app.openPalette,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Press ', style: AppTheme.mono(color: colors.mutedForeground, size: 11, letterSpacing: 0)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(border: Border.all(color: colors.border), borderRadius: BorderRadius.circular(4)),
              child: Text('⌘K', style: AppTheme.mono(color: colors.mutedForeground, size: 10, letterSpacing: 0)),
            ),
            Text(' anywhere', style: AppTheme.mono(color: colors.mutedForeground, size: 11, letterSpacing: 0)),
          ],
        ),
      ),
      Text('Built with intent.', style: AppTheme.mono(color: colors.mutedForeground, size: 11, letterSpacing: 0)),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1024),
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.border))),
            child: wide
                ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: items)
                : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    for (var i = 0; i < items.length; i++) ...[
                      if (i > 0) const SizedBox(height: 10),
                      items[i],
                    ],
                  ]),
          ),
        ),
      ),
    );
  }
}
