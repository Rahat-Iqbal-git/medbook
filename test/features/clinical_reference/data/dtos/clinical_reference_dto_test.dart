import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medbook/features/clinical_reference/data/dtos/dtos.dart';

void main() {
  group('ClinicalReferenceDto', () {
    test('parses the live endpoint schema', () {
      final json = jsonDecode('''
        {
          "version": 1,
          "diseases": [
            {
              "id": 1,
              "name": "Aster Respiratory Veil",
              "category": "Respiratory",
              "keywords": ["respiratory", "infection", "cough"]
            }
          ],
          "antibiotics": [
            {
              "id": 10,
              "name": "Medicine Alpha",
              "generic_name": "Formula A"
            }
          ],
          "recommendations": [
            {
              "id": 100,
              "disease_id": 1,
              "antibiotic_id": 10,
              "type": "First Line",
              "dose": "500 mg",
              "frequency": "Twice daily",
              "duration": "5 days"
            }
          ]
        }
      ''');

      final dto = ClinicalReferenceDto.fromDecodedJson(json);

      expect(dto.version, 1);
      expect(dto.diseases.single.name, 'Aster Respiratory Veil');
      expect(dto.diseases.single.keywords, [
        'respiratory',
        'infection',
        'cough',
      ]);
      expect(dto.antibiotics.single.genericName, 'Formula A');
      expect(dto.recommendations.single.diseaseId, 1);
      expect(dto.recommendations.single.antibioticId, 10);
    });

    test('rejects a malformed record rather than coercing it', () {
      final json = jsonDecode('''
        {
          "version": 1,
          "diseases": [
            {
              "id": 1,
              "name": "Aster Respiratory Veil",
              "category": "Respiratory",
              "keywords": ["cough", 4]
            }
          ],
          "antibiotics": [],
          "recommendations": []
        }
      ''');

      expect(
        () => ClinicalReferenceDto.fromDecodedJson(json),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test('rejects a fractional version rather than truncating it', () {
      final json = jsonDecode('''
        {
          "version": 1.5,
          "diseases": [],
          "antibiotics": [],
          "recommendations": []
        }
      ''');

      expect(
        () => ClinicalReferenceDto.fromDecodedJson(json),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });
  });
}
