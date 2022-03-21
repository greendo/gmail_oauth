class EmailId {
  late String id;

  EmailId({required this.id});

  EmailId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}