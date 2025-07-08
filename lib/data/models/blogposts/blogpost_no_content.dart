class BlogpostNoContent {
  BlogpostNoContent({required this.id, required this.title});

  factory BlogpostNoContent.fromJson(Map<String, dynamic> json) =>
      switch (json) {
        {'id': final int id, 'title': final String title} => BlogpostNoContent(
          id: id,
          title: title,
        ),
        _ => throw const FormatException('Failed to load blog post.'),
      };

  final int id;
  final String title;
}
