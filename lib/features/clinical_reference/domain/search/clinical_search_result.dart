enum ClinicalSearchResultType { disease, medicine, recommendation }

class ClinicalSearchResult {
  const ClinicalSearchResult({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
  });

  final int id;
  final ClinicalSearchResultType type;
  final String title;
  final String subtitle;
}
