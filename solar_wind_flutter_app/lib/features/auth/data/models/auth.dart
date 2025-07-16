class Auth {
  final bool isRegistered;
  final String id;
  final String token;

  Auth({required this.isRegistered, required this.id, required this.token});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      isRegistered: json['isRegistered'] == "true",
      id: json['id'].toString(),
      token: json['token'],
    );
  }
}
