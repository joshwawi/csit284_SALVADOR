import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/layout_constants.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/empty_state.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list_header.dart';
import 'package:expense_tracker/widgets/summary_card.dart';

/// Tablets and landscape: summary and chart on the left, list on the right.
/// Each pane scrolls on its own, so the list stays visible while you browse.
class WideLayout extends StatelessWidget {
  const WideLayout({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: LayoutConstants.fabClearance),
            child: Column(
              children: [
                SummaryCard(expenses: expenses),
                Chart(expenses: expenses),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: expenses.isEmpty
              ? const EmptyState()
              : CustomScrollView(
                  slivers: [
                    const ExpensesListHeader(),
                    ExpensesList(
                      expenses: expenses,
                      onRemoveExpense: onRemoveExpense,
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: LayoutConstants.fabClearance),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
