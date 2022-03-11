import 'package:flutter/material.dart';
import 'package:purple_store/components/product_item.dart';
import 'package:purple_store/data/dummy_data.dart';
import 'package:purple_store/models/products.dart';

class ProductsOverviewPage extends StatelessWidget {
  List<Product> loadedProducts = dummyProducts;

  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purple Store'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) =>
            ProductItem(product: loadedProducts[index]),
      ),
    );
  }
}
