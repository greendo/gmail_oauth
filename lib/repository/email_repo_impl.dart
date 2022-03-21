import 'dart:convert';
import 'package:gmail_oauth/model/email.dart';
import 'package:gmail_oauth/repository/email_repo.dart';
import 'package:gmail_oauth/util/token_storage.dart';
import 'package:http/http.dart' as http;

class EmailException implements Exception {
  final String message;

  EmailException(this.message);
}

class EmailRepoImpl implements EmailRepo {
  final String uri = 'https://gmail.googleapis.com/gmail/v1/users/me/messages/';
  final http.Client client;
  final TokenStorage tokenStorage;

  EmailRepoImpl({required this.client, required this.tokenStorage});

  @override
  Future<Email> getEmail(String id) async {
    final http.Response response = await client.get(
      Uri.parse(uri + id),
      headers: tokenStorage.token,
    );
    
    if (response.statusCode != 200) {
      throw EmailException('Request ended with: ${response.statusCode} status code');
    }

    return Email.fromJson(jsonDecode(response.body));
  }
}
