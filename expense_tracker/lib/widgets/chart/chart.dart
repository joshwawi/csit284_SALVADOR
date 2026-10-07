import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/app_panel.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      for (final category in Category.values)
        ExpenseBucket.forCategory(expenses, category),
    ];
  }

  double get maxTotalExpense {
    double maxTotal = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotal) {
        maxTotal = bucket.totalExpenses;
      }
    }
    return maxTotal;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentBuckets = buckets;
    final maxTotal = maxTotalExpense;

    return AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Where it went', style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          SizedBox(
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final bucket in currentBuckets)
                  ChartBar(
                    category: bucket.category,
                    total: bucket.totalExpenses,
                    fill: maxTotal == 0 ? 0 : bucket.totalExpenses / maxTotal,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
