import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:medbook/app/dependency_injection/dependency_injection.dart';
import 'package:medbook/core/app_theme/theme/app_theme.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/home/presentation/pages/homepage.dart';
import 'package:medbook/features/search/presentation/pages/search_page.dart';
import 'package:medbook/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({this.clinicalReferenceRepository, super.key});

  final ClinicalReferenceRepository? clinicalReferenceRepository;

  @override
  Widget build(BuildContext context) {
    final repository =
        clinicalReferenceRepository ?? getIt<ClinicalReferenceRepository>();
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => HomePage(clinicalReferenceRepository: repository),
        ),
        GoRoute(
          path: '/search',
          builder: (_, _) =>
              SearchPage(clinicalReferenceRepository: repository),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
