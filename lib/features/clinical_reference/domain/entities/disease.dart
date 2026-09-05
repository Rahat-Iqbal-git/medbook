/// A fictional clinical condition available in the local reference.
class Disease {
  const Disease({
    required this.id,
    required this.name,
    required this.category,
    required this.keywords,
  });

  final int id;
  final String name;
  final String category;
  final List<String> keywords;
}
