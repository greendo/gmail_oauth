import 'package:gmail_oauth/model/email_id.dart';

abstract class EmailsListRepo {
  Future<List<EmailId>> getEmailIds();
}