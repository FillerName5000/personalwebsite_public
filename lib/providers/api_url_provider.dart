import 'package:flutter/material.dart';
import 'package:personal_website/constants/api_types.dart';

const String baseUrl = "https://briekgoethalsdev.be";

class ApiTypeProvider extends ChangeNotifier {
  ApiType _apiType = ApiType.dotnet;

  ApiType get apiType => _apiType;

  set apiType(ApiType value) {
    _apiType = value;
    notifyListeners();
  }

  String get fullBaseUrl => _apiType == ApiType.dotnet ? "$baseUrl/api" : "$baseUrl/java-api";
}
