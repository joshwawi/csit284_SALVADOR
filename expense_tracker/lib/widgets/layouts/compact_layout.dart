import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/layout_constants.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/empty_state.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list_header.dart';
import 'package:expense_tracker/widgets/summary_card.dart';

/// Phone portrait: everything stacked in one scrolling column.
class CompactLayout extends StatelessWidget {
  const CompactLayout({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SummaryCard(expenses: expenses)),
        SliverToBoxAdapter(child: Chart(expenses: expenses)),
        if (expenses.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyState(),
          )
        else ...[
          const ExpensesListHeader(),
          ExpensesList(
            expenses: expenses,
            onRemoveExpense: onRemoveExpense,
          ),
        ],
        const SliverToBoxAdapter(
          child: SizedBox(height: LayoutConstants.fabClearance),
        ),
      ],
    );
  }
}
