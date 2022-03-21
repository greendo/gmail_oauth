import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gmail_oauth/model/email.dart';
import 'package:gmail_oauth/repository/email_repo_impl.dart';
import 'package:gmail_oauth/util/token_storage.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  final _exampleJson = {"id": "test", "snippet": "test"};

  final _expectedResponse = Email(id: "test", snippet: "test");

  group('email', () {
    test('status == 200', () async {
      final mockClient = MockClient((request) async {
        return Response(json.encode(_exampleJson), 200);
      });
      final repo =
      EmailRepoImpl(client: mockClient, tokenStorage: TokenStorage());
      final actualResponse = await repo.getEmail('1');
      expect(actualResponse.id, equals(_expectedResponse.id));
      expect(actualResponse.snippet, equals(_expectedResponse.snippet));
    });

    test('status != 200', () async {
      final mockClient = MockClient((request) async {
        return Response(json.encode(_exampleJson), 500);
      });
      final repo =
      EmailRepoImpl(client: mockClient, tokenStorage: TokenStorage());
      expect(
            () async => await repo.getEmail('1'),
        throwsA(predicate((e) =>
        e is EmailException &&
            e.message == 'Request ended with: 500 status code')),
      );
    });
  });
}