final _repeatedWhitespace = RegExp(r'\s+');

/// Normalizes stored text and search queries into the same form.
String normalizeSearchText(String value) {
  return value.trim().toLowerCase().replaceAll(_repeatedWhitespace, ' ');
}
