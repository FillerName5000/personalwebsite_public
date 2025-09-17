class Blogpost {
  Blogpost({
    required this.id,
    required this.title,
    required this.content,
    required this.postDate,
  });

  /// Throws [FormatException] for invalid JSON.
  factory Blogpost.fromJson(Map<String, dynamic> json) => switch (json) {
    {
      'id': final int id,
      'title': final String title,
      'content': final String content,
      'postDate': final String postDate,
    } =>
      Blogpost(
        id: id,
        title: title,
        content: content,
        postDate: DateTime.parse(postDate).toUtc(),
      ),
    _ => throw const FormatException('Failed to load blog post.'),
  };

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'content': content,
    'postDate': postDate.toIso8601String(),
  };

  int id;
  String title;
  String content;
  DateTime postDate;
}
