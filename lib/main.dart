import 'package:cico/app.dart';
import 'package:cico/constants/locales.dart';
import 'package:cico/modules/global/providers/package_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  // Initialize widget bindings
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize translations
  await EasyLocalization.ensureInitialized();

  // Initialize package info
  platformPackageInfo = await PackageInfo.fromPlatform();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [localeEn, localeDe],
      child: const ProviderScope(
        child: AwesomeApp(),
      ),
    ),
  );
}
