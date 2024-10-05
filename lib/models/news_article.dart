/// NewsArticle class representing a news article with attributes
/// such as source, title, description, image URL, and publication date.
class NewsArticle {
  final String source;
  final String title;
  final String? description;
  final String? imageUrl;
  final String pubDate;

  NewsArticle({
    required this.source,
    required this.title,
    this.description,
    this.imageUrl,
    required this.pubDate,
  });

  /// Factory constructor to create a NewsArticle instance from a JSON map.
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      source: json['source_name'],
      title: json['title'] ?? 'No Title',
      description: json['description'],
      imageUrl: json['image_url'],
      pubDate: json['pubDate'] ?? '',
    );
  }
}
