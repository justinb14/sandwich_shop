import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/profile_screen.dart';

void main() {
  testWidgets('ProfileScreen displays fields and saves', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(),
      ),
    );

    // Check for title and input fields
    expect(find.text('Your Details'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Name'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);

    // Enter text in fields
    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Alice');
    await tester.enterText(find.widgetWithText(TextField, 'Email'), 'alice@example.com');

    // Tap Save and check for SnackBar
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
    await tester.pump(); // Start SnackBar animation
    expect(find.text('Profile saved (not persisted)'), findsOneWidget);
  });
}
