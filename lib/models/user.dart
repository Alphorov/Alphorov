import 'dart:convert';

class User {
  User({
    required this.name,
    required this.login,
    required this.pswrd,
    required this.date,
  });
  final DateTime? date;
  final String? login;
  final String? pswrd;
  final String? name;

  String toJson() {
    return jsonEncode({
      'name': name,
      'login': login,
      'pswrd': pswrd,
      'date': date?.toIso8601String()
    });
  }

  @override
  String toString() {
    return 'name: $name, login: $login, pswrd: $pswrd, date: $date';
  }

  factory User.fromJson(json) {
    final decoded = jsonDecode(json);
    return User(
      date: DateTime.parse(decoded['date']),
      name: decoded['name'],
      pswrd: decoded['pswrd'],
      login: decoded['login'],
    );
  }
}
