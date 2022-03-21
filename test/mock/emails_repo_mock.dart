import 'package:gmail_oauth/model/email_id.dart';
import 'package:gmail_oauth/repository/emails_list_repo.dart';

class EmailsListRepoMock implements EmailsListRepo {
  @override
  Future<List<EmailId>> getEmailIds() {
    return Future(() {
      return [EmailId(id: 'test')];
    });
  }
}