import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_oauth/repository/auth_repo.dart';
import 'package:gmail_oauth/util/token_storage.dart';

class AuthEvent {}

class AuthBloc extends Bloc<AuthEvent, bool> {
  AuthBloc(this.repository, this.storage) : super(false) {
    on<AuthEvent>(_login);
  }

  final AuthRepo repository;
  final TokenStorage storage;
  
  _login(AuthEvent event, Emitter<bool> emit) async {
    await repository.auth().then((value) => storage.token = value);
    emit(storage.token != null);
  }
}