class Email {
  late String id;
  late String snippet;

  Email({required this.id, required this.snippet});

  Email.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    snippet = json['snippet'];
  }
}