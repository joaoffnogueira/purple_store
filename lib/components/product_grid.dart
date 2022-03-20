import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_store/components/product_item.dart';
import 'package:purple_store/models/product_list.dart';
import 'package:purple_store/models/products.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> loadedProducts =
        Provider.of<ProductList>(context).itens;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider(
        create: (_) => loadedProducts[index],
        child: ProductItem(),
      ),
    );
  }
}
