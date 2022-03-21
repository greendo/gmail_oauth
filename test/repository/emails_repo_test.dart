import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gmail_oauth/model/email_id.dart';
import 'package:gmail_oauth/repository/emails_list_repo_impl.dart';
import 'package:gmail_oauth/util/token_storage.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import '../mock/example.dart';

void main() {
  final _expectedResponse = [
    EmailId(id: "17fa685e91a101f3")
  ];

  group('emails', () {
    test('status == 200', () async {
      final mockClient = MockClient((request) async {
        return Response(json.encode(exampleJson), 200);
      });
      final repo =
          EmailsListRepoImpl(client: mockClient, tokenStorage: TokenStorage());
      final actualResponse = await repo.getEmailIds();
      expect(actualResponse[0].id, equals(_expectedResponse[0].id));
    });

    test('status != 200', () async {
      final mockClient = MockClient((request) async {
        return Response(json.encode(exampleJson), 500);
      });
      final repo =
          EmailsListRepoImpl(client: mockClient, tokenStorage: TokenStorage());
      expect(
        () async => await repo.getEmailIds(),
        throwsA(predicate((e) =>
            e is EmailsListException &&
            e.message == 'Request ended with: 500 status code')),
      );
    });
  });
}
