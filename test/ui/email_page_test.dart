import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmail_oauth/repository/email_repo.dart';
import 'package:gmail_oauth/ui/email_page.dart';

import '../mock/email_repo_mock.dart';

void main() {
  testWidgets('Email has a title and a card', (WidgetTester tester) async {
    final key = GlobalKey<NavigatorState>();
    // hack for passing args
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: key,
        home: MaterialButton(
          onPressed: () => key.currentState?.push(
            MaterialPageRoute<void>(
              settings: const RouteSettings(arguments: 'test'),
              builder: (_) => RepositoryProvider<EmailRepo>(
                create: (_) => EmailRepoMock(),
                child: const EmailPage(),
              ),
            ),
          ),
          child: const SizedBox(),
        ),
      ),
    );

    await tester.tap(find.byType(MaterialButton));
    await tester.pumpAndSettle();
    // title
    expect(find.text('Email'), findsOneWidget);
    await tester.pumpAndSettle();
    // // card
    expect(find.text('Id: test'), findsOneWidget);
    expect(find.text('Snippet: test'), findsOneWidget);
  });
}
