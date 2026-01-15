import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('widget test', (WidgetTester tester) async {

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('My App')),
          body: const Center(child: Text('Test')),
        ),
      ),
    );


    await tester.pump();

    expect(find.text('My App'), findsOneWidget);      // AppBar title
    expect(find.text('test'), findsOneWidget); // Body text
    expect(find.byType(Center), findsOneWidget);      // Center widget
  });
}
