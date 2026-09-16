import 'package:cv/app_controller.dart';
import 'package:cv/theme/app_theme.dart';
import 'package:cv/widgets/cursor_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppController.sectionAtPointer', () {
    const bounds = <String, Rect>{
      'top': Rect.fromLTWH(0, 0, 1200, 400),
      'about': Rect.fromLTWH(0, 400, 1200, 600),
      'skills': Rect.fromLTWH(0, 1000, 1200, 500),
    };

    test('returns the section under the pointer', () {
      expect(
        AppController.sectionAtPointer(const Offset(300, 650), bounds),
        'about',
      );
    });

    test('returns null when the pointer is outside every section', () {
      expect(
        AppController.sectionAtPointer(const Offset(300, 1600), bounds),
        isNull,
      );
    });
  });

  test('uses blue for About and purple for Skills & Stack', () {
    expect(AppColors.sectionAccents['about'], const Color(0xFF4C6BE0));
    expect(AppColors.sectionAccents['skills'], const Color(0xFF8A5CD6));
  });

  test('uses one accent color for the section under the pointer', () {
    expect(glowAccent('about', Colors.black), const Color(0xFF4C6BE0));
    expect(glowAccent('skills', Colors.black), const Color(0xFF8A5CD6));
    expect(glowAccent('unknown', Colors.black), Colors.black);
  });
}
