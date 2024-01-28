import 'package:cico/modules/doge/providers/shibe_client_provider.dart';
import 'package:cico/modules/doge/repositories/doge_images_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides for a list of doge image urls
final dogeImagesProvider = FutureProvider.autoDispose.family<List<String>, int>((ref, count) async {
  final shibeClient = ref.read(shibeClientProvider);
  return DogeImagesRepository(shibeClient).getDogeImages(count);
});
