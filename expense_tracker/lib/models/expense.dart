import 'package:flutter/material.dart';

enum Category { food, transport, bills, game, other }

extension CategoryX on Category {
  String get label => switch (this) {
        Category.food => 'Food',
        Category.transport => 'Transport',
        Category.bills => 'Bills',
        Category.game => 'Leisure',
        Category.other => 'Other',
      };

  IconData get icon => switch (this) {
        Category.food => Icons.ramen_dining_rounded,
        Category.transport => Icons.directions_bus_rounded,
        Category.bills => Icons.receipt_long_rounded,
        Category.game => Icons.sports_esports_rounded,
        Category.other => Icons.category_rounded,
      };

  Color get color => switch (this) {
        Category.food => const Color.fromARGB(255, 240, 150, 48),
        Category.transport => const Color.fromARGB(255, 155, 49, 31),
        Category.bills => const Color.fromARGB(255, 13, 92, 165),
        Category.game => const Color.fromARGB(255, 187, 22, 151),
        Category.other => const Color.fromARGB(255, 236, 236, 236),
      };
}

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = '${DateTime.now().microsecondsSinceEpoch}-${_counter++}';

  static int _counter = 0;

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}

/// Groups all expenses that belong to one category.
class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  /// Alternative constructor: builds a bucket by filtering a full list.
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses =
            allExpenses.where((expense) => expense.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
