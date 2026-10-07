import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/format.dart';
import 'package:expense_tracker/widgets/app_panel.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final now = DateTime.now();

    final monthTotal = expenses
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .fold<double>(0, (sum, e) => sum + e.amount);

    return AppPanel(
      color: scheme.primary,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spent in ${DateFormat.MMMM().format(now)}',
            style: theme.textTheme.titleMedium
                ?.copyWith(color: scheme.onPrimary.withValues(alpha: 0.8)),
          ),
          const SizedBox(height: 6),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: monthTotal),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => Text(
              peso.format(value),
              style: theme.textTheme.displaySmall
                  ?.copyWith(color: scheme.onPrimary),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${expenses.length} ${expenses.length == 1 ? 'expense' : 'expenses'} recorded in total',
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: scheme.onPrimary.withValues(alpha: 0.75)),
          ),
        ],
      ),
    );
  }
}
