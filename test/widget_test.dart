// Basic smoke test for Subway Surfers game.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:subway_surfers_game/main.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const SubwaySurfersApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
