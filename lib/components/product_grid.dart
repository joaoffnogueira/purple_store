// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_store/components/product_grid_item.dart';
import 'package:purple_store/models/product_list.dart';
import 'package:purple_store/models/products.dart';

class ProductGrid extends StatelessWidget {
  final bool showOnlyFavorites;

  const ProductGrid({required this.showOnlyFavorites, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        showOnlyFavorites ? provider.favoriteItens : provider.itens;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index],
        child: ProductGridItem(),
      ),
    );
  }
}
