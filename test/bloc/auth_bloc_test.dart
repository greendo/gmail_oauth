import 'package:bloc_test/bloc_test.dart';
import 'package:gmail_oauth/bloc/auth_bloc.dart';
import 'package:gmail_oauth/util/token_storage.dart';

import '../mock/auth_repo_mock.dart';

void main() {
  blocTest(
    'on event AuthBloc state should be true',
    build: () => AuthBloc(AuthRepoMock(), TokenStorage()),
    expect: () => [true],
    act: (bloc) => (bloc as AuthBloc).add(AuthEvent()),
    wait: const Duration(milliseconds: 300),
  );
}