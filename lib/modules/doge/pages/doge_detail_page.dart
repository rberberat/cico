import 'package:cico/modules/doge/actions/share_doge_image.dart';
import 'package:cico/modules/doge/widgets/doge_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DogeDetailPage extends StatelessWidget {
  const DogeDetailPage({required this.imageUrl, super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('doge.detail'.tr()),
        actions: [
          IconButton(
            onPressed: () => shareDogeImage(imageUrl),
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Center(
        child: DogeImage(imageUrl: imageUrl),
      ),
    );
  }
}
