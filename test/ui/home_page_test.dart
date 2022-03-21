import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmail_oauth/bloc/auth_bloc.dart';
import 'package:gmail_oauth/ui/home_page.dart';
import 'package:gmail_oauth/util/token_storage.dart';

import '../mock/auth_repo_mock.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('HomePage has a title and tappable button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(AuthRepoMock(), TokenStorage()),
          child: const HomePage(),
        ),
      ),
    );

    // title
    expect(find.text('Home'), findsOneWidget);
    // button
    expect(find.text('authorize'), findsOneWidget);

    // tap button, expect new text
    await tester.tap(find.byType(MaterialButton));
    await tester.pumpAndSettle();
    expect(find.text('go to emails'), findsOneWidget);
  });
}