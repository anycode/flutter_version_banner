# Version Banner

[![pub package](https://img.shields.io/pub/v/ac_geojson.svg)](https://pub.dev/packages/ac_version_banner)
[![license](https://img.shields.io/badge/license-BSD%202-green)](https://github.com/anycode/flutter_version_banner/blob/main/LICENSE)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://dart.dev/guides/language/effective-dart)

An app Banner Widget that shows the current app version. Can be used with [App Flavors](https://flutter.dev/docs/deployment/flavors) to show what flavor of the app is currently being used.

## Package name change

The original package [*flutter_version_banner*](https://github.com/FaganOoi/flutter_version_banner) 
is still available on pub.dev but seems not to
be maintained. There's my PR for Dart 3 from May 7th 2024 not accepted yet.

That's why I published my version as *ac_version_banner*.

## Getting Started

This widget should wrap `MaterialApp` or `CupertinoApp`.

![Example](https://user-images.githubusercontent.com/10728633/59044609-5aa82c00-8876-11e9-99d2-da84a81af2e6.png)

```dart
VersionBanner(
          text: "Yay!",
          packageExtensions: [".dev"],
          extensionHandling: VersionBannerExtensionHandling.packageContainDev,
          child: MaterialApp(
                       debugShowCheckedModeBanner: false,
                       title: 'Flutter Demo',
                       theme: ThemeData(
                         primarySwatch: Colors.blue,
                       ),
                       home: MyHomePage(title: 'Flutter Demo Home Page'),
                     )
      );
```

`packageExtensions` will check the app's package name with the given array based on value of `extensionHandling`.

[Original/Default Behavior] If `extensionHandling` is `VersionBannerExtensionHandling.packageContainDev` and the package name contains part of the String in the array, then the banner is visible.

If `extensionHandling` is `VersionBannerExtensionHandling.packageSuffixDev` and the package name ends with any of the String in the array, then the banner is visible.

The following properties can be changed:

- `color` - Banner's color
- `textStyle` - Banner's text style
- `text` - The text to appear. If set to null will show the `pubspec` version
- `location` - the banner's location on the screen, based on the class [BannerLocation](https://api.flutter.dev/flutter/widgets/BannerLocation-class.html)
- `packageExtensions` - will check the app's package name with the given array and decide the banner's visibility
- `extensionHandling` - will control the behavior for `packageExtensions` to work
- `visible` - decides if the banner is visible or not. If set to `false`, it overrides the `packageExtensions` attribute
