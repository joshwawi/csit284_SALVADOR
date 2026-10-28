import 'package:flutter/material.dart';

/// Shown in place of the list when there are no expenses yet.
class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          'No expenses yet. Tap Add expense to record your first one.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
