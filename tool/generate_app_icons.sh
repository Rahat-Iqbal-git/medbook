#!/usr/bin/env bash

set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="$project_root/assets/app_icon"
work_dir="$(mktemp -d)"
trap 'rm -rf "$work_dir"' EXIT

if ! command -v magick >/dev/null 2>&1; then
  echo "ImageMagick is required (missing 'magick' command)." >&2
  exit 1
fi

for source_file in \
  app_icon.png \
  app_icon_foreground.png \
  app_icon_monochrome.png; do
  if [[ ! -f "$source_dir/$source_file" ]]; then
    echo "Missing source icon: $source_dir/$source_file" >&2
    exit 1
  fi
done

# Legacy Android launchers do not apply adaptive masks, so provide explicit
# rounded-square and circular variants with a small transparent margin.
magick -size 1024x1024 xc:none \
  -fill white -draw "roundrectangle 42,42 981,981 110,110" \
  "$work_dir/rounded-mask.png"
magick "$source_dir/app_icon.png" "$work_dir/rounded-mask.png" \
  -alpha off -compose CopyOpacity -composite "$work_dir/rounded.png"

magick -size 1024x1024 xc:none \
  -fill white -draw "circle 512,512 981,512" \
  "$work_dir/round-mask.png"
magick "$source_dir/app_icon.png" "$work_dir/round-mask.png" \
  -alpha off -compose CopyOpacity -composite "$work_dir/round.png"

densities=(mdpi hdpi xhdpi xxhdpi xxxhdpi)
legacy_sizes=(48 72 96 144 192)
foreground_sizes=(108 162 216 324 432)
android_source_sets=(main development staging)

for source_set in "${android_source_sets[@]}"; do
  android_dir="$project_root/android/app/src/$source_set"

  magick "$source_dir/app_icon.png" -resize 512x512 -depth 8 \
    "$android_dir/ic_launcher-playstore.png"

  for index in "${!densities[@]}"; do
    density="${densities[$index]}"
    legacy_size="${legacy_sizes[$index]}"
    foreground_size="${foreground_sizes[$index]}"
    mipmap_dir="$android_dir/res/mipmap-$density"
    drawable_dir="$android_dir/res/drawable-$density"

    mkdir -p "$mipmap_dir" "$drawable_dir"
    magick "$work_dir/rounded.png" \
      -resize "${legacy_size}x${legacy_size}" -depth 8 \
      "$mipmap_dir/ic_launcher.png"
    magick "$work_dir/round.png" \
      -resize "${legacy_size}x${legacy_size}" -depth 8 \
      "$mipmap_dir/ic_launcher_round.png"
    magick "$source_dir/app_icon_foreground.png" \
      -resize "${foreground_size}x${foreground_size}" -depth 8 \
      "$drawable_dir/ic_launcher_foreground.png"
    magick "$source_dir/app_icon_monochrome.png" \
      -resize "${foreground_size}x${foreground_size}" -depth 8 \
      "$drawable_dir/ic_launcher_monochrome.png"
  done
done

# The current iOS project uses Icon Composer. Its icon bundles compile this
# transparent layer into the platform-specific sizes during the Xcode build.
ios_icon_bundles=(AppIcon.icon AppIcon-dev.icon AppIcon-stg.icon)
for bundle in "${ios_icon_bundles[@]}"; do
  cp "$source_dir/app_icon_foreground.png" \
    "$project_root/ios/Runner/AppIcons/$bundle/Assets/Logo.png"
done

echo "Generated Android and iOS app-icon resources."
