import 'package:cico/modules/products/models/product.dart';
import 'package:cico/modules/products/providers/products_provider.dart';
import 'package:cico/modules/products/widgets/create_product_overlay.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  Future<void> addProduct(WidgetRef ref) async {
    await ref.read(asyncProductsProvider.notifier).addProduct(const Product(name: 'name', caloriesPer100g: 100));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsProvider = ref.watch(asyncProductsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('products.title'.tr())),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => showDialog<void>(context: context, builder: (c) => CreateProductOverlay()),
      ),
      body: productsProvider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => ErrorWidget(err),
        data: (products) {
          // Return a SliverGrid with card of images
          return RefreshIndicator(
            onRefresh: () => ref.refresh(asyncProductsProvider.future),
            child: CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products.elementAt(index);
                    return Dismissible(
                      key: Key(product.name),
                      background: Container(color: Colors.red,),
                      onDismissed: (direction) {
                        ref.read(asyncProductsProvider.notifier).removeProduct(product);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('${product.name} deleted.')));
                      },
                      child: ListTile(
                        title: Text(product.name),
                        subtitle: Text(
                          product.caloriesPer100g.toString(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
