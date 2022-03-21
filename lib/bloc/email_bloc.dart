import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_oauth/model/email.dart';
import 'package:gmail_oauth/repository/email_repo.dart';
import 'package:gmail_oauth/repository/email_repo_impl.dart';
import 'package:gmail_oauth/util/net_states.dart';

class EmailEvent {
  final String id;

  EmailEvent(this.id);
}

class EmailBloc extends Bloc<EmailEvent, NetStates> {
  EmailBloc(this.repository) : super(NetStates.initial) {
    on<EmailEvent>(_fetchEmail);
  }

  final EmailRepo repository;
  late Email? email;

  _fetchEmail(EmailEvent event, Emitter<NetStates> emit) async {
    NetStates state = NetStates.loading;
    emit(state);

    try {
      state = NetStates.success;
      email = await repository.getEmail(event.id);
    } on EmailException {
      state = NetStates.error;
    } finally {
      emit(state);
    }
  }
}