import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:personal_website/data/models/blogposts/blogpost.dart';
import 'package:personal_website/data/models/blogposts/blogpost_add.dart';
import 'package:personal_website/data/models/blogposts/blogpost_no_content.dart';

const String baseUrl = "https://briekgoethalsdev.be";

class BlogpostProvider with ChangeNotifier {
  List<BlogpostNoContent>? _blogpostsNoContent;
  String? _errorMessage;

  List<BlogpostNoContent>? get blogpostsNoContent => _blogpostsNoContent;
  String? get errorMessage => _errorMessage;

  bool hasError() => _errorMessage != null;

  Future<List<BlogpostNoContent>> fetchBlogpostsNoContent() async {
    _errorMessage = null;

    if (_blogpostsNoContent != null) {
      if (kDebugMode) {
        debugPrint('Returning cached blog posts');
      }
      return _blogpostsNoContent!;
    }

    try {
      final http.Response response = await http.get(
        Uri.parse('$baseUrl/api/Blogposts'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _blogpostsNoContent =
            data.map((dynamic b) => BlogpostNoContent.fromJson(b)).toList();
        notifyListeners();
        return _blogpostsNoContent!;
      } else {
        _errorMessage = 'Failed to fetch blog posts';
        throw Exception('Error fetching blog posts: ${response.statusCode}');
      }
    } on Exception catch (e) {
      _errorMessage = 'Failed to fetch blog posts';
      throw Exception('Exception in fetchBlogpostsNoContent: $e');
    }
  }

  Future<Blogpost> fetchBlogpostById(int id) async {
    _errorMessage = null;

    try {
      final http.Response response = await http.get(
        Uri.parse('$baseUrl/api/Blogposts/$id'),
      );

      if (response.statusCode == 200) {
        return Blogpost.fromJson(jsonDecode(response.body));
      } else {
        _errorMessage = 'Failed to fetch blog post';
        throw Exception('Error fetching blog post: ${response.statusCode}');
      }
    } on Exception catch (e) {
      _errorMessage = 'Failed to fetch blog post';
      throw Exception('Exception in fetchBlogpostById: $e');
    }
  }

  Future<void> addBlogpost(BlogpostAdd blogpost) async {
    _errorMessage = null;

    try {
      final http.Response response = await http.post(
        Uri.parse('$baseUrl/api/Blogposts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(blogpost.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('title')) {
          if (kDebugMode) {
            debugPrint('Added blog post with title: ${responseData['title']}');
          }
        }
      } else {
        _errorMessage = 'Failed to add blog post';
      }
    } on Exception catch (e) {
      _errorMessage = 'Failed to add blog post';
      if (kDebugMode) {
        debugPrint('Exception in addBlogpost: $e');
      }
    }
  }
}
