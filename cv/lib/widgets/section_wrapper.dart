import 'package:flutter/material.dart';

/// Centers content at a max width of 1024 (the site's `max-w-5xl`) and
/// tags the section with its scroll-spy [GlobalKey].
class SectionWrapper extends StatelessWidget {
  final GlobalKey sectionKey;
  final Widget child;
  final EdgeInsets padding;

  const SectionWrapper({
    super.key,
    required this.sectionKey,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 88),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: padding,
      child: Center(
        child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1024), child: child),
      ),
    );
  }
}
