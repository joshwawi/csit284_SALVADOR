import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/layout_constants.dart';
import 'package:expense_tracker/widgets/layouts/expenses_layout.dart';
import 'package:expense_tracker/widgets/new_expense/new_expense.dart';
import 'package:expense_tracker/widgets/theme_toggle_button.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key, this.onToggleTheme});

  final void Function(bool isDark)? onToggleTheme;

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Jeepney and MyBus fare',
      amount: 84,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: Category.transport,
    ),
    Expense(
      title: 'Lunch at the canteen',
      amount: 145,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: Category.food,
    ),
    Expense(
      title: 'Internet load',
      amount: 299,
      date: DateTime.now().subtract(const Duration(days: 3)),
      category: Category.bills,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,

      constraints: const BoxConstraints(maxWidth: LayoutConstants.maxSheetWidth),
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
      _registeredExpenses.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() => _registeredExpenses.remove(expense));

    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(
            () => _registeredExpenses.insert(expenseIndex, expense),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker',
            style: TextStyle(color: Color.fromARGB(255, 89, 160, 75))),
        actions: [
          if (widget.onToggleTheme != null)
            ThemeToggleButton(onToggle: widget.onToggleTheme!),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddExpenseOverlay,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add expense'),
      ),
      body: ExpensesLayout(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      ),
    );
  }
}
