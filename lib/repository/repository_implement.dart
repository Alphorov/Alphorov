import 'package:flutter_project/repository/repository.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class NewsImplementRepository extends NewsRepository {
  @override
  Future<Response> getDogs() {
    return http.get(
      Uri.parse('https://dog.ceo/api/breeds/image/random'),
    );
  }
}
