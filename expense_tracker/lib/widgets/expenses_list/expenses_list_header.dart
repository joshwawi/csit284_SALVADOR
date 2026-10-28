import 'package:flutter/material.dart';

/// "Recent" heading above the list. Place it inside a CustomScrollView.
class ExpensesListHeader extends StatelessWidget {
  const ExpensesListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: Text('Recent', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
