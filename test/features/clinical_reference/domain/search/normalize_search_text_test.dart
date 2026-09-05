import 'package:flutter_test/flutter_test.dart';
import 'package:medbook/features/clinical_reference/domain/search/normalize_search_text.dart';

void main() {
  group('normalizeSearchText', () {
    test('converts text to lowercase', () {
      expect(normalizeSearchText('Medicine ALPHA'), 'medicine alpha');
    });

    test('trims and collapses whitespace', () {
      expect(
        normalizeSearchText('  First\tLine\n  Treatment  '),
        'first line treatment',
      );
    });

    test('returns an empty string for whitespace-only input', () {
      expect(normalizeSearchText(' \t\n '), isEmpty);
    });
  });
}
