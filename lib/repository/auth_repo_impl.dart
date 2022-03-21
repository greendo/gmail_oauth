import 'package:gmail_oauth/repository/auth_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class AuthRepoImpl implements AuthRepo {
  final GoogleSignIn gSignIn;

  AuthRepoImpl({required this.gSignIn});

  @override
  Future<Map<String, String>> auth() async {
    var a = await gSignIn.signIn();
    if (a == null) {
      throw AuthException('Could not authenticate');
    }

    return a.authHeaders;
  }
}
