// test/widget_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:fltrdfctscn/main.dart';          // теперь тянет public App
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  testWidgets('ScanScreen отрисовался', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.flash_on), findsOneWidget);
    expect(find.byType(MobileScanner), findsOneWidget);
  });
}
