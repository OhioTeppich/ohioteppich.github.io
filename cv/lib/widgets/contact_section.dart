import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_controller.dart';
import '../data/site_data.dart';
import '../theme/app_theme.dart';
import 'section_heading.dart';
import 'section_wrapper.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _copied = false;

  Future<void> _copyEmail() async {
    await Clipboard.setData(ClipboardData(text: profile.email));
    if (!mounted) return;
    setState(() => _copied = true);
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final colors = context.colors;
    final foreground = Theme.of(context).colorScheme.onSurface;
    final wide = MediaQuery.sizeOf(context).width >= 768;

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Text(
            "I'm currently open to full-time roles. The fastest way to reach me is by email — I read everything.",
            style: TextStyle(fontSize: 17, height: 1.6, color: foreground.withValues(alpha: 0.8)),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 14,
          runSpacing: 10,
          children: [
            GestureDetector(
              onTap: () => launchUrl(Uri(scheme: 'mailto', path: profile.email)),
              child: Text(
                profile.email,
                style: AppTheme.serif(
                  color: foreground,
                  size: wide ? 30 : 22,
                  letterSpacing: 0,
                ).copyWith(decoration: TextDecoration.underline, decorationColor: colors.brand),
              ),
            ),
            _CopyButton(copied: _copied, onTap: _copyEmail, colors: colors),
          ],
        ),
      ],
    );

    final right = Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.border))),
      child: Column(
        children: [for (final social in socials) _SocialRow(social: social, colors: colors, foreground: foreground)],
      ),
    );

    return SectionWrapper(
      sectionKey: app.sectionKeys['contact']!,
      padding: const EdgeInsets.fromLTRB(24, 88, 24, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(index: '04', label: 'Contact', title: 'Have something worth building?'),
          wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: left),
                    const SizedBox(width: 48),
                    Expanded(flex: 2, child: right),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [left, const SizedBox(height: 40), right],
                ),
        ],
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  final bool copied;
  final VoidCallback onTap;
  final AppColors colors;

  const _CopyButton({required this.copied, required this.onTap, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.card.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(border: Border.all(color: colors.border), borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(copied ? Icons.check : Icons.copy, size: 14, color: copied ? colors.brand : colors.mutedForeground),
              const SizedBox(width: 6),
              Text(copied ? 'Copied' : 'Copy', style: TextStyle(fontSize: 12, color: colors.mutedForeground)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  final SocialLink social;
  final AppColors colors;
  final Color foreground;

  const _SocialRow({required this.social, required this.colors, required this.foreground});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(social.href), mode: LaunchMode.externalApplication),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.border))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SocialIcon(label: social.label, color: colors.brand),
                      const SizedBox(width: 8),
                      Text(social.label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: foreground)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(social.handle, style: AppTheme.mono(color: colors.mutedForeground, size: 11, letterSpacing: 0)),
                ],
              ),
              Icon(Icons.north_east, size: 16, color: colors.mutedForeground),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final String label;
  final Color color;

  const _SocialIcon({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    if (label == 'TryHackMe') {
      return FaIcon(FontAwesomeIcons.userSecret, size: 15, color: color);
    }

    final icon = switch (label) {
      'GitHub' => FontAwesomeIcons.github,
      'LinkedIn' => FontAwesomeIcons.linkedinIn,
      _ => Icons.link,
    };
    return FaIcon(icon, size: 15, color: color);
  }
}
