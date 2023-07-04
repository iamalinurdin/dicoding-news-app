import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/model/articles.dart';
import 'package:news_app/utils/result_state.dart';

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;
  late ArticleResult _articleResult;
  late ResultState _state;
  String _message = '';

  NewsProvider({required this.apiService}) {
    fetchAllArticles();
  }

  String get message => _message;
  ArticleResult get result => _articleResult;
  ResultState get state => _state;

  Future<dynamic> fetchAllArticles() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiService.topHeadlines();

      if (response.articles.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();

        return _articleResult = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error -> $e';
    }
  }
}