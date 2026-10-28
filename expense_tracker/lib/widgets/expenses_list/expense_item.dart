import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/format.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    super.key,
    required this.expense,
    required this.onRemoveExpense,
  });

  final Expense expense;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final category = expense.category;

    return Dismissible(
      key: ValueKey(expense.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemoveExpense(expense),
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.only(right: 24),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: scheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_rounded, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: scheme.onSurface.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(category.icon, color: category.color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${category.label}, ${DateFormat.MMMd().format(expense.date)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurface.withValues(alpha: 0.65),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              peso.format(expense.amount),
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
