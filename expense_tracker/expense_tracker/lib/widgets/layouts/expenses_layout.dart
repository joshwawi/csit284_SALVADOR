import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/layout_constants.dart';
import 'package:expense_tracker/widgets/layouts/compact_layout.dart';
import 'package:expense_tracker/widgets/layouts/wide_layout.dart';

/// Picks the compact or wide layout from the space actually available,
/// keeps it inside the device's safe area, and caps its width.
class ExpensesLayout extends StatelessWidget {
  const ExpensesLayout({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    // top and bottom are handled by the AppBar and the scrollables' padding;
    // left and right keep content clear of notches in landscape.
    return SafeArea(
      top: false,
      bottom: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = LayoutConstants.isWide(constraints.maxWidth);

          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: LayoutConstants.maxContentWidth,
              ),
              child: isWide
                  ? WideLayout(
                      expenses: expenses,
                      onRemoveExpense: onRemoveExpense,
                    )
                  : CompactLayout(
                      expenses: expenses,
                      onRemoveExpense: onRemoveExpense,
                    ),
            ),
          );
        },
      ),
    );
  }
}
