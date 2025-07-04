/*
 * Copyright 2025 Martin Edlman - Anycode <ac@anycode.dev>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

library version_banner;

import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ac_version_banner/src/enum.dart';

/// Version Banner Widget
///
/// An app Banner Widget that shows the current app version. Can be used with
/// App Flavors (https://flutter.dev/docs/deployment/flavors) to show what flavor
/// of the app is currently being used.
///
/// Usage:
///
/// ```
/// VersionBanner(
///           text: "Yay!",
///           child: MaterialApp(
///                        debugShowCheckedModeBanner: false,
///                        title: 'Flutter Demo',
///                        theme: ThemeData(
///                          primarySwatch: Colors.blue,
///                        ),
///                        home: MyHomePage(title: 'Flutter Demo Home Page'),
///                      )
///       );
/// ```
class VersionBanner extends StatelessWidget {
  /// Material or Cupertino App Widget
  ///
  /// The VersionBanner Widget should wrap the Material or Cupertino App Widgets
  ///
  /// ```
  /// class MyApp extends StatelessWidget {
  ///   MyApp();
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return VersionBanner(
  ///         text: "Yay!",
  ///         child: var materialApp = MaterialApp(
  ///           debugShowCheckedModeBanner: false,
  ///           title: 'Flutter Demo',
  ///           theme: ThemeData(
  ///             primarySwatch: Colors.blue,
  ///           ),
  ///           home: MyHomePage(title: 'Flutter Demo Home Page'),
  ///         );
  ///     );
  ///   }
  /// }
  /// ```
  final Widget child;

  /// Banner Location on the app, see [BannerLocation] for possible values.
  ///
  /// Has a default value of BannerLocation.topEnd
  final BannerLocation location;

  /// Text Style to be applied in the Banner
  ///
  /// Has a default value of a white bold text
  final TextStyle textStyle;

  /// Banner message
  final String? text;

  /// Banner color
  ///
  /// Has a default value of Red
  final Color color;

  /// Visibility of the banner
  final bool visible;

  /// List of package extensions to hide or show
  ///
  /// Checks if the package name has a string in the array, eg.:
  ///   `com.vanethos.example.dev` with array `["dev"]`
  ///
  /// This property is overriden by [visible]. If [visible] is false,
  /// the banner will not be shown.
  final List<String>? packageExtensions;

  final VersionBannerExtensionMatching extensionMatching;

  VersionBanner({
    required this.child,
    this.text,
    this.location = BannerLocation.topEnd,
    this.textStyle = const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
    this.color = const Color.fromARGB(255, 255, 0, 0),
    this.visible = true,
    this.extensionMatching = VersionBannerExtensionMatching.contains,
    this.packageExtensions,
  });

  @override
  Widget build(BuildContext context) {
    if (visible) {
      /// If the banner is visible, we need to check if we are going to present
      /// the default text OR if we are going to check the visibility of the
      /// banner via the package extensions.
      /// If this is the case, we will need to access the package_info plugin
      if (text == null || packageExtensions != null) {
        return FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var isDev = false;
                if (packageExtensions != null) {
                  for (var package in packageExtensions!) {
                    if (snapshot.data != null &&
                        isPackageNameMeetExtension(
                          snapshot.data!.packageName,
                          package,
                        )) {
                      isDev = true;
                      break;
                    }
                  }
                } else {
                  isDev = true;
                }

                if (isDev) {
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: Banner(
                      color: color,
                      message: text ?? snapshot.data?.version ?? '',
                      location: location,
                      textStyle: textStyle,
                      child: child,
                    ),
                  );
                }
              }

              /// If we are not in a development package, return the original child
              return child;
            });
      }

      /// If we don't use the default text or search the package names, then
      /// we return the banner with the user's input

      if (text == null) {
        throw 'Text attribute should be defined';
      }

      return Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          color: color,
          message: text!,
          location: location,
          textStyle: textStyle,
          child: child,
        ),
      );
    }

    /// The banner is not visible, return the child instead
    return child;
  }

  bool isPackageNameMeetExtension(
    String appPackageName,
    String packageNameToMatch,
  ) {
    if (this.extensionMatching ==
        VersionBannerExtensionMatching.contains)
      return appPackageName.contains(packageNameToMatch);

    return appPackageName.endsWith(packageNameToMatch);
  }
}
