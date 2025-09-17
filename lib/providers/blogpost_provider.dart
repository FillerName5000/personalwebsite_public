import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:personal_website/data/models/blogposts/blogpost.dart';
import 'package:personal_website/data/models/blogposts/blogpost_add.dart';
import 'package:personal_website/data/models/blogposts/blogpost_no_content.dart';
import 'package:personal_website/providers/api_url_provider.dart';
import 'package:provider/provider.dart';

// Riverpod could've been a better option (have not tried yet), provider has been quite annoying and not that useful.
// Research into how exactly it expects to handle state changes from fetches has been unsatisfying.
// Even in a small app with little complexity it's taken too much time compared to other frameworks.
class BlogpostProvider with ChangeNotifier {
  List<BlogpostNoContent>? _blogpostsNoContent;
  String? _errorMessage;

  List<BlogpostNoContent>? get blogpostsNoContent => _blogpostsNoContent;
  String? get errorMessage => _errorMessage;

  Future<List<BlogpostNoContent>?> fetchBlogpostsNoContent(
    BuildContext context,
  ) async {
    _errorMessage = null;

    if (_blogpostsNoContent != null) {
      if (kDebugMode) {
        debugPrint('Returning cached blog posts');
      }
      return _blogpostsNoContent!;
    }

    try {
      final String fullBaseUrl =
          Provider.of<ApiTypeProvider>(context, listen: false).fullBaseUrl;
      final http.Response response = await http.get(
        Uri.parse('$fullBaseUrl/blogposts/v2'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _blogpostsNoContent =
            data.map((dynamic b) => BlogpostNoContent.fromJson(b)).toList();
        notifyListeners();
        return _blogpostsNoContent!;
      } else {
        _errorMessage = 'Could not find blog posts.';
        return null;
      }
    } on Exception {
      _errorMessage = 'Could not find blog posts.';
      return null;
    }
  }

  Future<Blogpost?> fetchBlogpostByTitle(
    BuildContext context,
    String title,
  ) async {
    _errorMessage = null;

    try {
      final String fullBaseUrl =
          Provider.of<ApiTypeProvider>(context, listen: false).fullBaseUrl;
      final http.Response response = await http.get(
        Uri.parse('$fullBaseUrl/blogposts/v2/$title'),
      );

      if (response.statusCode == 200) {
        return Blogpost.fromJson(jsonDecode(response.body));
      } else {
        _errorMessage = 'Could not find blog post $title.';
        return null;
      }
    } on Exception {
      _errorMessage = 'Could not find blog post $title.';
      return null;
    }
  }

  Future<void> addBlogpost(BuildContext context, BlogpostAdd blogpost) async {
    _errorMessage = null;

    try {
      final String fullBaseUrl =
          Provider.of<ApiTypeProvider>(context, listen: false).fullBaseUrl;
      final http.Response response = await http.post(
        Uri.parse('$fullBaseUrl/blogposts/v2'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(blogpost.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('title')) {
          if (kDebugMode) {
            debugPrint('Added blog post with title: ${responseData['title']}.');
          }
        }
      } else {
        _errorMessage = 'Failed to add blog post.';
      }
    } on Exception {
      _errorMessage = 'Failed to add blog post.';
      if (kDebugMode) {
        debugPrint('Failed to add blog post.');
      }
    }
  }
}
