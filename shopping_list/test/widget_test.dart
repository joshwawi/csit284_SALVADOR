import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shopping_list/main.dart';

void main() {
  testWidgets('shopping list starts empty and opens the add item screen',
      (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Your Groceries'), findsOneWidget);
    expect(find.text('No items added yet.'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Add New Item'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Quantity'), findsOneWidget);
  });
}
