/// Shared sizes and breakpoints so no widget hard-codes its own magic numbers.
abstract final class LayoutConstants {
  /// Screen width (dp) from which the app switches to the two-pane layout.
  /// Covers tablets and phones in landscape.
  static const double wideBreakpoint = 600;

  /// Width of the add-expense sheet (dp) from which the form goes side by side.
  static const double formWideBreakpoint = 500;

  /// Content never grows wider than this, so huge screens stay readable.
  static const double maxContentWidth = 1100;

  /// Maximum width of the add-expense bottom sheet.
  static const double maxSheetWidth = 640;

  /// Empty space at the bottom of scrollables so the FAB never hides a row.
  static const double fabClearance = 96;

  static bool isWide(double width) => width >= wideBreakpoint;
}
