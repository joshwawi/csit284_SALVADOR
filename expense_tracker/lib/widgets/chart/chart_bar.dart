import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/format.dart';

/// One vertical bar of the chart. [fill] is a value from 0 to 1.
class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
    required this.category,
    required this.total,
  });

  final double fill;
  final Category category;
  final double total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Expanded(
      child: Tooltip(
        message: '${category.label}: ${peso.format(total)}',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.onSurface.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: fill),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) => FractionallySizedBox(
                      alignment: Alignment.bottomCenter,
                      heightFactor: value,
                      widthFactor: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: category.color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Icon(category.icon, size: 20, color: category.color),
              const SizedBox(height: 2),
              Text(
                category.label,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
