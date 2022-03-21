import 'package:flutter_test/flutter_test.dart';

import 'package:gmail_oauth/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    expect(find.text('authorize'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
  });
}
