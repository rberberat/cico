import 'package:cico/constants/keys.dart';
import 'package:cico/modules/products/models/product.dart';
import 'package:cico/modules/products/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateProductOverlay extends ConsumerWidget {
  const CreateProductOverlay({super.key});

  String? validateText(String? string) {
    if (string == null || string.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String? validateNumber(String? string) {
    if (string == null || string.isEmpty) {
      return 'Please enter a valid number';
    }

    final intValue = int.tryParse(string);

    if (intValue == null || intValue.isNaN) {
      return 'Please enter a valid number';
    }

    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productName = '';
    var productGrammsPer100g = 0;

    return AlertDialog(
      content: Form(
        key: productFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                maxLines: 2,
                minLines: 1,
                validator: validateText,
                onSaved: (value) => productName = value!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                validator: validateNumber,
                onSaved: (value) => productGrammsPer100g = int.tryParse(value!)!,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (productFormKey.currentState!.validate()) {
              productFormKey.currentState!.save();
              ref.read(asyncProductsProvider.notifier).addProduct(
                    Product(
                      name: productName,
                      caloriesPer100g: productGrammsPer100g,
                    ),
                  );
              context.pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
