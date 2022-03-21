import 'package:bloc_test/bloc_test.dart';
import 'package:gmail_oauth/bloc/email_bloc.dart';
import 'package:gmail_oauth/util/net_states.dart';

import '../mock/email_repo_mock.dart';

void main() {
  blocTest(
    'on event EmailBloc state should be loading and success',
    build: () => EmailBloc(EmailRepoMock()),
    expect: () => [NetStates.loading, NetStates.success],
    act: (bloc) => (bloc as EmailBloc).add(EmailEvent('0')),
    wait: const Duration(milliseconds: 300),
  );
}
