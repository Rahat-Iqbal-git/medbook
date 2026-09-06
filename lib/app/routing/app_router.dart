import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medbook/app/routing/app_routes.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/presentation/disease_detail/pages/disease_detail_page.dart';
import 'package:medbook/features/clinical_reference/presentation/medicine_detail/pages/medicine_detail_page.dart';
import 'package:medbook/features/home/presentation/pages/homepage.dart';
import 'package:medbook/features/search/presentation/pages/search_page.dart';

GoRouter createAppRouter({
  required ClinicalReferenceRepository clinicalReferenceRepository,
}) {
  return GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (_, _) => HomePage(
          clinicalReferenceRepository: clinicalReferenceRepository,
        ),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (_, _) => SearchPage(
          clinicalReferenceRepository: clinicalReferenceRepository,
        ),
      ),
      GoRoute(
        path: AppRoutes.diseaseDetails,
        builder: (_, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          return id == null || id <= 0
              ? const _InvalidRoutePage()
              : DiseaseDetailPage(
                  id: id,
                  clinicalReferenceRepository: clinicalReferenceRepository,
                );
        },
      ),
      GoRoute(
        path: AppRoutes.medicineDetails,
        builder: (_, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          return id == null || id <= 0
              ? const _InvalidRoutePage()
              : MedicineDetailPage(
                  id: id,
                  clinicalReferenceRepository: clinicalReferenceRepository,
                );
        },
      ),
    ],
  );
}

class _InvalidRoutePage extends StatelessWidget {
  const _InvalidRoutePage();

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: Text('This clinical reference could not be opened.')),
  );
}
