import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _date = DateTime.now();
  Category _category = Category.food;

  String? _titleError;
  String? _amountError;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );
    if (picked == null) return;
    setState(() => _date = picked);
  }

  void _submit() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text.replaceAll(',', ''));

    setState(() {
      _titleError = title.isEmpty ? 'Enter what you spent on' : null;
      _amountError =
          (amount == null || amount <= 0) ? 'Enter an amount above 0' : null;
    });
    if (_titleError != null || _amountError != null) return;

    widget.onAddExpense(
      Expense(
        title: title,
        amount: amount!,
        date: _date,
        category: _category,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final keyboard = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + keyboard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Add expense', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 18),
          TextField(
            controller: _titleController,
            maxLength: 50,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'What was it for?',
              errorText: _titleError,
              counterText: '',
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    prefixText: '₱ ',
                    errorText: _amountError,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      suffixIcon: Icon(Icons.calendar_month_rounded),
                    ),
                    child: Text(DateFormat.yMMMd().format(_date)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text('Category', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final c in Category.values)
                ChoiceChip(
                  avatar: Icon(c.icon, size: 18, color: c.color),
                  label: Text(c.label),
                  selected: _category == c,
                  onSelected: (_) => setState(() => _category = c),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _submit,
                child: const Text('Save expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
