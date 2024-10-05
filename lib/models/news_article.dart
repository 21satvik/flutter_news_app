class NewsArticle {
  final String source;
  final String title;
  final String? description; // Can be null
  final String? imageUrl; // Can be null
  final String pubDate; // Publication date

  NewsArticle({
    required this.source,
    required this.title,
    this.description,
    this.imageUrl,
    required this.pubDate,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      source: json['source_name'], // Article ID
      title: json['title'] ?? 'No Title',
      description: json['description'], // Can be null
      imageUrl: json['image_url'], // Can be null
      pubDate: json['pubDate'] ?? '',
    );
  }
}
