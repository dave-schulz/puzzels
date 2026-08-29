import 'package:flutter/material.dart';

/// App-specific design tokens via [ThemeExtension].
@immutable
class BrainyTheme extends ThemeExtension<BrainyTheme> {
  const BrainyTheme({
    required this.progressActive,
    required this.progressInactive,
    required this.buttonBorder,
    required this.primaryDark,
    required this.errorDark,
  });

  final Color progressActive;
  final Color progressInactive;
  final Color buttonBorder;
  final Color primaryDark;
  final Color errorDark;

  /// Indigo + slate + amber — warm accent on a cool base.
  static const light = BrainyTheme(
    progressActive: Color(0xFFF59E0B),
    progressInactive: Color(0xFFE2E8F0),
    buttonBorder: Color(0xFFCBD5E1),
    primaryDark: Color(0xFF4338CA),
    errorDark: Color(0xFFBE123C),
  );

  @override
  BrainyTheme copyWith({
    Color? progressActive,
    Color? progressInactive,
    Color? buttonBorder,
    Color? primaryDark,
    Color? errorDark,
  }) {
    return BrainyTheme(
      progressActive: progressActive ?? this.progressActive,
      progressInactive: progressInactive ?? this.progressInactive,
      buttonBorder: buttonBorder ?? this.buttonBorder,
      primaryDark: primaryDark ?? this.primaryDark,
      errorDark: errorDark ?? this.errorDark,
    );
  }

  @override
  BrainyTheme lerp(ThemeExtension<BrainyTheme>? other, double t) {
    if (other is! BrainyTheme) return this;
    return BrainyTheme(
      progressActive: Color.lerp(progressActive, other.progressActive, t)!,
      progressInactive: Color.lerp(progressInactive, other.progressInactive, t)!,
      buttonBorder: Color.lerp(buttonBorder, other.buttonBorder, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      errorDark: Color.lerp(errorDark, other.errorDark, t)!,
    );
  }
}

extension BrainyThemeContext on BuildContext {
  BrainyTheme get brainyTheme =>
      Theme.of(this).extension<BrainyTheme>() ?? BrainyTheme.light;
}
