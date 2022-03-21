class TokenStorage {
  static final TokenStorage _singleton = TokenStorage._internal();

  /// token should be stored properly, but left like this for simplicity
  Map<String, String>? token;

  factory TokenStorage() {
    return _singleton;
  }

  TokenStorage._internal();
}
