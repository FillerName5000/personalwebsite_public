import 'package:flutter/material.dart';
import 'package:personal_website/data/models/blogposts/blogpost.dart';
import 'package:personal_website/layout/generic/generic_loading/loading_text.dart';
import 'package:personal_website/providers/blogpost_provider.dart';
import 'package:provider/provider.dart';

class SingleBlogpostText extends StatefulWidget {
  const SingleBlogpostText({super.key, required this.id});
  final int id;

  @override
  State<SingleBlogpostText> createState() => _SingleBlogpostTextState();
}

class _SingleBlogpostTextState extends State<SingleBlogpostText> {
  Future<Blogpost> _blogpostFuture = Future<Blogpost>.value(
    Blogpost(id: 0, title: 'Loading...', content: 'Loading blogpost text...', postDate: DateTime.now()),
  );

  @override
  Widget build(BuildContext context) {
    final BlogpostProvider blogpostProvider = Provider.of<BlogpostProvider>(
      context,
    );
    _blogpostFuture = blogpostProvider.fetchBlogpostById(widget.id);

    return FutureBuilder<Blogpost>(
      future: _blogpostFuture,
      builder: (BuildContext context, AsyncSnapshot<Blogpost> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingText(additionalText: 'blog post'));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Item not found'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(6),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    snapshot.data!.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(snapshot.data!.content),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
