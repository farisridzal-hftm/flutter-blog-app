import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_blog_app/main.dart';

void main() {
  testWidgets('Zeigt Blog-Einträge und fügt per Button einen hinzu',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Zu Beginn: 3 Einträge
    expect(find.byType(Card), findsNWidgets(3));
    expect(find.text('Mein Blog (3)'), findsOneWidget);

    // Button drücken
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Jetzt: 4 Einträge, neuer steht oben
    expect(find.byType(Card), findsNWidgets(4));
    expect(find.text('Mein Blog (4)'), findsOneWidget);
    expect(find.text('Hot Reload ist genial'), findsOneWidget);
  });
}