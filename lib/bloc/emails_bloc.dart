import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_oauth/model/email_id.dart';
import 'package:gmail_oauth/repository/emails_list_repo.dart';
import 'package:gmail_oauth/repository/emails_list_repo_impl.dart';
import 'package:gmail_oauth/util/net_states.dart';

class EmailsEvent {}

class EmailsBloc extends Bloc<EmailsEvent, NetStates> {
  EmailsBloc(this.repository) : super(NetStates.initial) {
    on<EmailsEvent>(_fetchEmails);
  }

  final EmailsListRepo repository;
  late List<EmailId>? ids;

  _fetchEmails(EmailsEvent event, Emitter<NetStates> emit) async {
    NetStates state = NetStates.loading;
    emit(state);

    try {
      state = NetStates.success;
      ids = await repository.getEmailIds();
    } on EmailsListException {
      state = NetStates.error;
    } finally {
      emit(state);
    }
  }
}