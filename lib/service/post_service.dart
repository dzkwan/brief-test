import 'dart:convert';

import 'package:http/http.dart' as http;

class PostService {
  Future getAll() async {
    try {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/');
      final response = await http.get(uri);
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
