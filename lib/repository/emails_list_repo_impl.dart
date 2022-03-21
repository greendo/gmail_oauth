import 'dart:convert';

import 'package:gmail_oauth/model/email_id.dart';
import 'package:gmail_oauth/repository/emails_list_repo.dart';
import 'package:gmail_oauth/util/token_storage.dart';
import 'package:http/http.dart' as http;

class EmailsListException implements Exception {
  final String message;

  EmailsListException(this.message);
}

class EmailsListRepoImpl implements EmailsListRepo {
  final String uri = 'https://gmail.googleapis.com/gmail/v1/users/me/messages?maxResults=10';
  final http.Client client;
  final TokenStorage tokenStorage;

  EmailsListRepoImpl({required this.client, required this.tokenStorage});

  @override
  Future<List<EmailId>> getEmailIds() async {
    final http.Response response = await client.get(
      Uri.parse(uri),
      headers: tokenStorage.token,
    );

    if (response.statusCode != 200) {
      throw EmailsListException('Request ended with: ${response.statusCode} status code');
    }

    var messages = jsonDecode(response.body)['messages'] as List<dynamic>;
    return messages.map((e) => EmailId.fromJson(e)).toList();
  }
}