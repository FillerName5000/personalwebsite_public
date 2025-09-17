enum ApiType { dotnet, java }

extension ApiTypeToString on ApiType {
  String toStr() {
    switch (this) {
      case ApiType.dotnet:
        return '.NET';
      case ApiType.java:
        return 'Java';
    }
  }
}
