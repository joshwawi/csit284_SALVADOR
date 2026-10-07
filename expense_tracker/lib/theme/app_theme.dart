import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom color palette for the app.
class AppColors {
  static const teal = Color.fromARGB(255, 251, 255, 0);
  static const marigold = Color.fromARGB(255, 255, 122, 14);
  static const berry = Color.fromARGB(255, 22, 119, 9);
  static const paper = Color(0xFFF6F7F4);
  static const nightSurface = Color(0xFF0E1A1E);
}

/// App-wide theme. Light and dark share one builder so they stay consistent.
class AppTheme {
  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;

    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.teal,
      brightness: brightness,
    ).copyWith(
      secondary: AppColors.marigold,
      error: AppColors.berry,
      surface: isLight ? AppColors.paper : AppColors.nightSurface,
    );

    // Custom fonts: DM Sans for body text, Sora for headings and numbers.
    final base = ThemeData(brightness: brightness).textTheme;
    final body = GoogleFonts.dmSansTextTheme(base)
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    TextStyle? sora(TextStyle? s, FontWeight w) =>
        GoogleFonts.sora(textStyle: s, fontWeight: w);

    final textTheme = body.copyWith(
      displaySmall: sora(body.displaySmall, FontWeight.w700),
      headlineMedium: sora(body.headlineMedium, FontWeight.w700),
      headlineSmall: sora(body.headlineSmall, FontWeight.w600),
      titleLarge: sora(body.titleLarge, FontWeight.w600),
      titleMedium: GoogleFonts.dmSans(
        textStyle: body.titleMedium,
        fontWeight: FontWeight.w600,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.secondary,
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.onSurface.withValues(alpha: 0.06),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.error, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: textTheme.titleMedium,
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide.none,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
