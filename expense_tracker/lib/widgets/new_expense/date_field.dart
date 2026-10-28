import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Read-only field that shows a date and calls [onTap] to change it.
class DateField extends StatelessWidget {
  const DateField({super.key, required this.date, required this.onTap});

  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Date',
          suffixIcon: Icon(Icons.calendar_month_rounded),
        ),
        child: Text(DateFormat.yMMMd().format(date)),
      ),
    );
  }
}
