extension UrlStringExtensions on String {
  String urlEncoded() => replaceAll(' ', '_');
  String urlDecoded() => replaceAll('_', ' ');
}
