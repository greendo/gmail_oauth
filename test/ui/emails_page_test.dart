import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmail_oauth/bloc/emails_bloc.dart';
import 'package:gmail_oauth/ui/emails_page.dart';
import '../mock/emails_repo_mock.dart';

void main() {
  testWidgets('Emails has a title and tappable button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<EmailsBloc>(
          create: (_) => EmailsBloc(EmailsListRepoMock()),
          child: const EmailsPage(),
        ),
      ),
    );

    // title
    expect(find.text('Emails'), findsOneWidget);
    // text
    expect(find.text('fetching...'), findsOneWidget);
    await tester.pumpAndSettle();
    // card
    expect(find.text('id: test'), findsOneWidget);
  });
}
