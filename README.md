# Medbook

Medbook is a small offline-first clinical reference built with Flutter. It
downloads a fictional dataset, saves it on the device, and lets you search
diseases, medicines, and treatment recommendations without a connection.

The sample content is fictional and is not medical advice.

## How it works

On launch, the app downloads the complete dataset from a
[public mock endpoint](https://rahat-iqbal-git.github.io/medbook-mock-data/api/v1/clinical-reference.json).
The response is parsed and validated before anything is saved. A valid update
replaces the previous data in one Drift transaction, so a broken or incomplete
download can never wipe a usable cache.

If refreshing fails and saved data exists, Medbook opens normally and shows an
offline banner. If there is no saved data yet, it shows the error with a Retry
button. All screens and searches read from the local database.

## Search

Search is case-insensitive, debounced, and supports partial and multi-word
queries. It checks disease names and keywords, medicine and generic names, and
treatment type, dose, frequency, and duration.

Results are ranked in this order:

1. Exact name
2. Name prefix
3. Exact generic name
4. Partial name
5. Generic-name prefix or partial match
6. Disease keyword
7. Recommendation details

Ties are settled by title, result type, and ID, which keeps the order stable.
Normalized searchable columns and relationship columns are indexed. The data
is deliberately tiny, so straightforward SQLite `LIKE` queries felt more
appropriate than adding a full-text search dependency.

## Structure

The app uses feature folders with small Clean Architecture boundaries:

```text
lib/
  app/                         dependency wiring, routing, theme
  core/                        configuration, failures, networking
  features/
    clinical_reference/
      domain/                  entities and repository contract
      data/                    API, validation, Drift, repository
      presentation/            disease and medicine details
    home/presentation/         startup sync and overview
    search/presentation/       debounced global search
```

Presentation depends on the domain contract; the data layer implements it.
Concrete dependencies are assembled in `app/` and passed in through
constructors. Bloc/Cubit owns UI state, while Drift remains the runtime source
of truth.

## Run it

Flutter and Dart versions are listed in `pubspec.yaml`. Create the local flavor
files first:

```sh
cp env/dev.example.json env/dev.json
cp env/staging.example.json env/staging.json
cp env/prod.example.json env/prod.json
```

Then run a flavor, for example development:

```sh
flutter run --flavor development \
  --target lib/main_development.dart \
  --dart-define-from-file=env/dev.json
```

The same pattern works with `staging` and `production` and their matching entry
points and environment files.

## Checks

The local CI script runs formatting, analysis, Bloc lint, tests, and the 80%
coverage gate:

```sh
./tool/ci.sh
```

Tests use fakes and in-memory databases; they do not call the public endpoint.

## Android build

```sh
flutter build apk --release \
  --flavor production \
  --target lib/main_production.dart \
  --dart-define-from-file=env/prod.json
```

The APK is written to Flutter's usual `build/app/outputs/flutter-apk/`
directory. iOS uses the same Dart code and the production scheme in Xcode.

## Main trade-off

This is an assessment-sized app, so I kept the moving parts modest: one local
database, one repository, explicit mapping, and focused Cubits. There is no
backend, account system, or background sync. The goal is dependable offline
reference access rather than a large product shell.
