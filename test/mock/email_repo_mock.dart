import 'package:gmail_oauth/model/email.dart';
import 'package:gmail_oauth/repository/email_repo.dart';

class EmailRepoMock implements EmailRepo {
  @override
  Future<Email> getEmail(String id) {
    return Future(() {
      return Email(id: 'test', snippet: 'test');
    });
  }
}