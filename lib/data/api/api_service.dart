import 'dart:convert';

import 'package:news_app/data/model/articles.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseURL = 'https://newsapi.org/v2/';
  static const String apiKey = '741cfda95e4b4bdbbdcfb3b0ff79cc18';
  static const String category = 'business';
  static const String country = 'id';

  Future<ArticleResult> topHeadlines() async {
    final response = await http.get(Uri.parse("https://newsapi.org/v2/everything?q=bitcoin&apiKey=741cfda95e4b4bdbbdcfb3b0ff79cc18"));
  
    if (response.statusCode == 200) {
      return ArticleResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch top headlines');
    }
  }
}