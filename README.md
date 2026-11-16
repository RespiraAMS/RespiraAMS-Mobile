# RespiraAMS-Mobile

This is the mobile client of RespiraAMS

## Structure

All source code located in `./respiraams/`

The folder `./respiraams/lib` containing all the Flutter code. The inner structure
consists of 4 directories:

- `core`: containing all the shared, configuration code like app navigation, API
  configuration, router, theme and utility
- `design_system`: containing the UI design system of the app
- `features`: containing actual feature code.
- `l10n`: generated code for localization

The folder `./respiraams/test` containing the test of this project

`./respiraams/design_system.md` is used for AI agent for design system

## To run this project

Move to the working directory, then:

```bash
cd respiraams
flutter run
```

If you preferred to run this on actual device, without the need for hot reload:

```bash
# Build to APK file
flutter build apk

# The result should be in: build/app/outputs/flutter-apk/app-release.apk
```
