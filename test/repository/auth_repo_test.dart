import 'package:flutter_test/flutter_test.dart';
import 'package:gmail_oauth/repository/auth_repo.dart';
import 'package:gmail_oauth/repository/auth_repo_impl.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  late MockGoogleSignIn googleSignIn;
  setUp(() {
    googleSignIn = MockGoogleSignIn();
  });
  test('should fail authentication', () async {
    googleSignIn.setIsCancelled(true);
    AuthRepo repo = AuthRepoImpl(gSignIn: googleSignIn);

    expect(
          () async => await repo.auth(),
      throwsA(predicate((e) =>
      e is AuthException &&
          e.message == 'Could not authenticate')),
    );
  });
}
