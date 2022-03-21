import 'package:bloc_test/bloc_test.dart';
import 'package:gmail_oauth/bloc/emails_bloc.dart';
import 'package:gmail_oauth/util/net_states.dart';

import '../mock/emails_repo_mock.dart';

void main() {
  blocTest(
    'on event EmailsBloc state should be loading and success',
    build: () => EmailsBloc(EmailsListRepoMock()),
    expect: () => [NetStates.loading, NetStates.success],
    act: (bloc) => (bloc as EmailsBloc).add(EmailsEvent()),
    wait: const Duration(milliseconds: 300),
  );
}
