import 'package:http/http.dart' as http;

abstract class NewsRepository {
  Future<http.Response> getDogs();
}
