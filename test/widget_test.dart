import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_app/main.dart';

void main() {
  testWidgets('Grocery app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GroceryApp());

    // Verify empty state is shown
    expect(find.text('Your grocery list is empty'), findsOneWidget);
    expect(find.text('Grocery List'), findsOneWidget);

    // Add an item
    await tester.enterText(find.byType(TextField), 'Milk');
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Verify item appears
    expect(find.text('Milk'), findsOneWidget);
    expect(find.text('Your grocery list is empty'), findsNothing);
  });
}
