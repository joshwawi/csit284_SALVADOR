import 'package:flutter/material.dart';

/// Reusable rounded container so every section shares the same look.
class AppPanel extends StatelessWidget {
  const AppPanel({
    super.key,
    required this.child,
    this.color,
    this.padding = const EdgeInsets.all(20),
    this.margin = const EdgeInsets.fromLTRB(16, 8, 16, 8),
  });

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? scheme.onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
