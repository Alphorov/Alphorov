import 'dart:convert';

import 'package:flutter_project/models/dogs_model.dart';
import 'package:flutter_project/repository/repository_implement.dart';

abstract class NewsApi {
  final _repositort = NewsImplementRepository();
  Future<Dogs> getDogs() async {
    final response = await _repositort.getDogs();
    return Dogs.fromJson(jsonDecode(response.body));
  }
}
