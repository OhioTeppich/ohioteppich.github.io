import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Extra design tokens that don't map onto Flutter's [ColorScheme], mirrored
/// from the `--brand` / `--muted-foreground` / `--border` / `--card`
/// custom properties in the original site's globals.css.
class AppColors extends ThemeExtension<AppColors> {
  final Color brand;
  final Color mutedForeground;
  final Color border;
  final Color card;

  const AppColors({
    required this.brand,
    required this.mutedForeground,
    required this.border,
    required this.card,
  });

  static const sectionAccents = <String, Color>{
    'top': Color(0xFF4C6BE0),
    'about': Color(0xFF8A5CD6),
    'skills': Color(0xFF2FA98C),
    'experience': Color(0xFFC9922E),
    'contact': Color(0xFFD1467F),
  };

  @override
  AppColors copyWith({Color? brand, Color? mutedForeground, Color? border, Color? card}) {
    return AppColors(
      brand: brand ?? this.brand,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      border: border ?? this.border,
      card: card ?? this.card,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      brand: Color.lerp(brand, other.brand, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      border: Color.lerp(border, other.border, t)!,
      card: Color.lerp(card, other.card, t)!,
    );
  }
}

extension BuildContextTheme on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

class AppTheme {
  AppTheme._();

  static const _lightBackground = Color(0xFFFCFBF8);
  static const _lightForeground = Color(0xFF2E2B27);
  static const _lightCard = Color(0xFFFEFDFA);
  static const _lightMuted = Color(0xFF87817A);
  static const _lightBorder = Color(0xFFE4E0D8);
  static const _lightBrand = Color(0xFF3B5FE0);

  static const _darkBackground = Color(0xFF201E1B);
  static const _darkForeground = Color(0xFFF2F0EB);
  static const _darkCard = Color(0xFF2A2724);
  static const _darkMuted = Color(0xFFACA79E);
  static const _darkBorder = Color(0x1FFFFFFF);
  static const _darkBrand = Color(0xFF8CA0F5);

  static ThemeData light() => _build(
    brightness: Brightness.light,
    background: _lightBackground,
    foreground: _lightForeground,
    card: _lightCard,
    muted: _lightMuted,
    border: _lightBorder,
    brand: _lightBrand,
    primary: _lightForeground,
    onPrimary: _lightBackground,
  );

  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    background: _darkBackground,
    foreground: _darkForeground,
    card: _darkCard,
    muted: _darkMuted,
    border: _darkBorder,
    brand: _darkBrand,
    primary: _darkForeground,
    onPrimary: _darkCard,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color foreground,
    required Color card,
    required Color muted,
    required Color border,
    required Color brand,
    required Color primary,
    required Color onPrimary,
  }) {
    final base = ThemeData(brightness: brightness, useMaterial3: true);
    final sans = GoogleFonts.interTextTheme(base.textTheme);

    return base.copyWith(
      scaffoldBackgroundColor: background,
      canvasColor: background,
      colorScheme: ColorScheme(
        brightness: brightness,
        surface: background,
        onSurface: foreground,
        primary: primary,
        onPrimary: onPrimary,
        secondary: brand,
        onSecondary: onPrimary,
        error: const Color(0xFFC94141),
        onError: background,
      ),
      textTheme: sans.copyWith(
        bodyLarge: sans.bodyLarge?.copyWith(color: foreground.withValues(alpha: 0.8), height: 1.6),
        bodyMedium: sans.bodyMedium?.copyWith(color: foreground.withValues(alpha: 0.8), height: 1.6),
        bodySmall: sans.bodySmall?.copyWith(color: muted),
      ),
      extensions: [
        AppColors(brand: brand, mutedForeground: muted, border: border, card: card),
      ],
      dividerColor: border,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }

  /// Serif display font, mirrors `--font-serif` (Instrument Serif).
  static TextStyle serif({
    required Color color,
    double size = 32,
    FontWeight weight = FontWeight.w400,
    FontStyle style = FontStyle.normal,
    double? height,
    double letterSpacing = -0.5,
  }) => GoogleFonts.instrumentSerif(
    color: color,
    fontSize: size,
    fontWeight: weight,
    fontStyle: style,
    height: height,
    letterSpacing: letterSpacing,
  );

  /// Monospace label font, mirrors `--font-mono` (Geist Mono).
  static TextStyle mono({
    required Color color,
    double size = 11,
    FontWeight weight = FontWeight.w500,
    double letterSpacing = 1.2,
  }) => GoogleFonts.jetBrainsMono(
    color: color,
    fontSize: size,
    fontWeight: weight,
    letterSpacing: letterSpacing,
  );
}
