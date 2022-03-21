import 'package:gmail_oauth/model/email.dart';

abstract class EmailRepo {
  Future<Email> getEmail(String id);
}