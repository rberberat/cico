import 'dart:convert';
import 'dart:developer';

import 'package:cico/modules/global/providers/file_providers.dart';
import 'package:cico/modules/products/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final asyncProductsProvider = AsyncNotifierProvider<AsyncProductsNotifier, List<Product>>(AsyncProductsNotifier.new);

class AsyncProductsNotifier extends AsyncNotifier<List<Product>> {
  Future<List<Product>> _fetchProducts() async {
    final productsFile = await ref.read(productsFileProvider.future);
    try {
      final json = productsFile.readAsStringSync();
      final products = jsonDecode(json) as List<dynamic>;
      return products.map((p) {
        return Product.fromJson(p as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      log('Product parsing failed.', error: e);
      return [];
    }
  }

  @override
  Future<List<Product>> build() async {
    return _fetchProducts();
  }

  Future<void> addProduct(Product product) async {
    final products = state.requireValue;
    if(products.any((element) => element.name == product.name)) {
      return;
    } else {
      products.add(product);
    }

    // Set the state to loading
    state = const AsyncValue.loading();

    // Add the new product and reload the list from the remote repository
    state = await AsyncValue.guard(() async {
      await _writeProducts(products);
      return _fetchProducts();
    });
  }

  Future<void> removeProduct(Product product) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new product and reload the list from the remote repository
    state = await AsyncValue.guard(() async {
      final products = state.requireValue..remove(product);
      await _writeProducts(products);
      return _fetchProducts();
    });
  }

  Future<void> _writeProducts(List<Product> products) async {
    final productsFile = await ref.read(productsFileProvider.future);
    final productsAsJson = products.map((e) => e.toJson()).toList(growable: false);
    productsFile.writeAsStringSync(jsonEncode(productsAsJson));
  }
}
