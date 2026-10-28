import 'package:Currex/currency_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final width in [
    1440.0,
    1200.0,
    1050.0,
    900.0,
    768.0,
    600.0,
    430.0,
    375.0,
  ]) {
    testWidgets('background fills the viewport at $width px', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = Size(width, 900);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(home: CurrencyConvertorMaterialPage()),
      );
      await tester.pumpAndSettle();

      expect(tester.getSize(find.byType(Stack).first), Size(width, 900));
      final exception = tester.takeException();
      expect(exception, isNull, reason: '$exception');

      if (width <= 600) {
        expect(
          tester
              .getSize(find.byKey(const ValueKey('currency-amount-card')))
              .height,
          lessThan(210),
        );
      }

      if (width == 1440) {
        expect(
          tester
              .getCenter(find.byKey(const ValueKey('currency-page-content')))
              .dy,
          closeTo(450, 1),
        );
      }
    });
  }
}
