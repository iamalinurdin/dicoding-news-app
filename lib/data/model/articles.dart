class ArticleResult {
  String status;
  int totalResults;
  List<Article> articles;

  ArticleResult({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ArticleResult.fromJson(Map<String, dynamic> json) => ArticleResult(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from((json['articles'] as List)
                .map((item) => Article.fromJson(item))
                .where((article) => 
                  article.author != null &&
                  article.urlToImage != null &&
                  article.publishedAt != null &&
                  article.content != null
                )),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((item) => item.toJson())),
  };
}

class Article {
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String? content;

  Article({
    required this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    author: json["author"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt?.toIso8601String(),
    "content": content,
  };
}