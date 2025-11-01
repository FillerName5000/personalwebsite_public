import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:personal_website/data/models/adv_of_code/adv_of_code_24_completion.dart';
import 'package:personal_website/providers/api_url_provider.dart';
import 'package:provider/provider.dart';

class AdvOfCode24Provider with ChangeNotifier {
  List<AdvOfCode24Completion>? _completions;
  String? _errorMessage;

  List<AdvOfCode24Completion>? get completions => _completions;
  String? get errorMessage => _errorMessage;

  Future<List<AdvOfCode24Completion>?> fetchAdvOfCode24Completions(
    BuildContext context,
  ) async {
    _errorMessage = null;

    if (_completions != null) {
      if (kDebugMode) {
        debugPrint('Returning cached Advent of Code 2024 completions');
      }
      return _completions!;
    }

    try {
      final String fullBaseUrl =
          Provider.of<ApiTypeProvider>(context, listen: false).fullBaseUrl;
      final http.Response response = await http.get(
        Uri.parse('$fullBaseUrl/AdvOfCode/v2/24'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _completions =
            data.map((dynamic c) => AdvOfCode24Completion.fromJson(c)).toList();
        notifyListeners();
        return _completions!;
      } else {
        _errorMessage = 'Could not find Advent of Code 2024 completions.';
        return null;
      }
    } on Exception {
      _errorMessage = 'Could not find Advent of Code 2024 completions.';
      return null;
    }
  }
}
