import 'package:flutter/cupertino.dart'
    show CupertinoAlertDialog, CupertinoDialogAction, showCupertinoDialog;
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/layout_constants.dart';
import 'package:expense_tracker/widgets/new_expense/category_chips.dart';
import 'package:expense_tracker/widgets/new_expense/date_field.dart';

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

  /// Shows an iOS-style dialog on Apple platforms and a Material one elsewhere.
  /// Uses the theme's platform (not dart:io) so it also works on web.
  void _showInvalidInputDialog() {
    final platform = Theme.of(context).platform;
    final isApple =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    const title = Text('Invalid input');
    const content = Text(
      'Please make sure a valid title and an amount above 0 were entered.',
    );

    if (isApple) {
      showCupertinoDialog<void>(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: title,
          content: content,
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: title,
          content: content,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submit() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text.replaceAll(',', ''));

    setState(() {
      _titleError = title.isEmpty ? 'Enter what you spent on' : null;
      _amountError =
          (amount == null || amount <= 0) ? 'Enter an amount above 0' : null;
    });
    if (_titleError != null || _amountError != null) {
      _showInvalidInputDialog();
      return;
    }

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

  Widget _buildTitleField() {
    return TextField(
      controller: _titleController,
      maxLength: 50,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'What was it for?',
        errorText: _titleError,
        counterText: '',
      ),
    );
  }

  Widget _buildAmountField() {
    return TextField(
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Amount',
        prefixText: '₱ ',
        errorText: _amountError,
      ),
    );
  }

  Widget _buildActions() {
    return Row(
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
    );
  }

  /// Narrow sheet (portrait phone): title, then amount + date, then chips.
  List<Widget> _buildNarrowFields() {
    return [
      _buildTitleField(),
      const SizedBox(height: 14),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildAmountField()),
          const SizedBox(width: 12),
          Expanded(child: DateField(date: _date, onTap: _pickDate)),
        ],
      ),
      const SizedBox(height: 18),
      _CategorySection(
        selected: _category,
        onSelected: (c) => setState(() => _category = c),
      ),
    ];
  }

  /// Wide sheet (tablet, landscape): title + amount share a row, and the
  /// category chips share a row with the date, so the form stays short.
  List<Widget> _buildWideFields() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _buildTitleField()),
          const SizedBox(width: 12),
          Expanded(flex: 2, child: _buildAmountField()),
        ],
      ),
      const SizedBox(height: 18),
      Text('Category', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CategoryChips(
              selected: _category,
              onSelected: (c) => setState(() => _category = c),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 190,
            child: DateField(date: _date, onTap: _pickDate),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final keyboard = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= LayoutConstants.formWideBreakpoint;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + keyboard),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add expense', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 18),
              ...(isWide ? _buildWideFields() : _buildNarrowFields()),
              const SizedBox(height: 24),
              _buildActions(),
            ],
          ),
        );
      },
    );
  }
}

/// "Category" label with its chips, used by the narrow form.
class _CategorySection extends StatelessWidget {
  const _CategorySection({required this.selected, required this.onSelected});

  final Category selected;
  final void Function(Category category) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        CategoryChips(selected: selected, onSelected: onSelected),
      ],
    );
  }
}
