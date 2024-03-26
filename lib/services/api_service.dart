import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/article_model.dart';

class ApiService {
  final endPointUrl =
      "http://newsapi.org/v2/top-headlines?country=us&apiKey=56f7801630c14a25b16d00e8e6d09119";

  Future<List<ArticleModel>> getArticles() async {
    // final response = await Dio().get(endPointUrl);
    final response = await http.get(Uri.parse(endPointUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      List<ArticleModel> articles = body.map((dynamic item) {
        ArticleModel article = ArticleModel.fromJson(item);
        article.favorite = false;
        return article;
      }).toList();
      return articles;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<ArticleModel>> getCategoryArticles(category, search) async {
    print(search);
    print(category);
    final response =
        await http.get(Uri.parse('$endPointUrl&category=$category&q=$search'));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      List<ArticleModel> articles = body.map((dynamic item) {
        ArticleModel article = ArticleModel.fromJson(item);
        article.favorite = false;
        return article;
      }).toList();
      return articles;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
