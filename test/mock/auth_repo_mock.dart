import 'package:gmail_oauth/repository/auth_repo.dart';

class AuthRepoMock implements AuthRepo {
  @override
  Future<Map<String, String>> auth() {
    return Future(() {
      return {'test': 'test'};
    });
  }
}