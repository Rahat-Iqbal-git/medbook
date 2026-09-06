# Medbook app icon sources

- `app_icon.png`: opaque 1024×1024 icon for iOS and legacy Android.
- `app_icon_foreground.png`: transparent Android adaptive-icon foreground.
- `app_icon_monochrome.png`: single-color Android themed-icon layer.

The background color is `#0022EE`. The compact lowercase `m` uses Inter Display
Bold at 60% of the original type size and is centered with generous padding
inside Android's adaptive-icon safe area.

Regenerate the native Android and iOS resources from the project root:

```sh
./tool/generate_app_icons.sh
```

ImageMagick is required. These are build-time source files and are intentionally
not registered as Flutter runtime assets in `pubspec.yaml`.
