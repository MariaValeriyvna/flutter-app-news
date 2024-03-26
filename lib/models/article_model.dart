import 'source_model.dart';
    
class ArticleModel {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  bool favorite;

  ArticleModel(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content,
      required this.favorite});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? "",
      title: json['title'] as String,
      description: json['description'] ?? "",
      url: json['url'] as String,
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] as String,
      content: json['content'] ?? "",
      favorite: json['favorite'] ?? false
    );
  }
}