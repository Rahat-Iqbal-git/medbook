import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medbook/app/routing/app_router.dart';
import 'package:medbook/core/app_theme/theme/app_theme.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/l10n/l10n.dart';

class App extends StatefulWidget {
  const App({required this.clinicalReferenceRepository, super.key});

  final ClinicalReferenceRepository clinicalReferenceRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createAppRouter(
      clinicalReferenceRepository: widget.clinicalReferenceRepository,
    );
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
