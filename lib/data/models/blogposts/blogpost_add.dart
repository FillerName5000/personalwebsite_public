class BlogpostAdd {
  BlogpostAdd({
    required this.title,
    required this.content,
    required this.postDate,
    required this.credential,
  });

  /// Throws [FormatException] for invalid JSON.
  factory BlogpostAdd.fromJson(Map<String, dynamic> json) => switch (json) {
    {
      'title': final String title,
      'content': final String content,
      'postDate': final String postDate,
      'credential': final String credential,
    } =>
      BlogpostAdd(
        title: title,
        content: content,
        postDate: DateTime.parse(postDate).toUtc(),
        credential: credential,
      ),
    _ => throw const FormatException('Failed to load blog post.'),
  };

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'content': content,
    'postDate': postDate.toIso8601String(),
    'credential': credential,
  };

  String title;
  String content;
  DateTime postDate;
  String credential;
}
