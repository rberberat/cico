import 'dart:io';

import 'package:cico/modules/global/providers/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides for a list of doge image urls
final productsFileProvider = FutureProvider<File>((ref) async {
  final localPath = await ref.read(localPathProvider.future);
  return File('$localPath/products.json');
});
