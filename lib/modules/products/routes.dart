import 'package:cico/modules/products/pages/products_page.dart';
import 'package:go_router/go_router.dart';

final productRoutes = [
  GoRoute(
    path: '/products',
    builder: (context, state) => const ProductsPage(),
  ),
];
