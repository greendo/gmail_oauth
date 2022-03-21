import 'package:flutter_test/flutter_test.dart';
import 'package:gmail_oauth/util/token_storage.dart';

void main() {
  test('should be identical', () {
    TokenStorage a = TokenStorage();
    TokenStorage b = TokenStorage();
    expect(identical(a, b), true);
  });
}