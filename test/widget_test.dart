import 'package:flutter_test/flutter_test.dart';

import 'package:rubrica_celular/main.dart';

void main() {
  testWidgets('App renders home screen and navigation flow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('EcoCell'), findsOneWidget);
    expect(find.text('Controla el uso de tu celular'), findsOneWidget);
    expect(find.text('Comenzar registro'), findsOneWidget);

    await tester.tap(find.text('Comenzar registro'));
    await tester.pumpAndSettle();

    expect(find.text('Registro de uso'), findsOneWidget);
  });
}
