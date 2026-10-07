import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

/// Row of selectable category chips that wraps onto more lines when needed.
class CategoryChips extends StatelessWidget {
  const CategoryChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final Category selected;
  final void Function(Category category) onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final c in Category.values)
          ChoiceChip(
            avatar: Icon(c.icon, size: 18, color: c.color),
            label: Text(c.label),
            selected: selected == c,
            onSelected: (_) => onSelected(c),
          ),
      ],
    );
  }
}
