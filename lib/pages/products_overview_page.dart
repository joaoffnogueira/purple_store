import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: loadedProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, index) => Text(loadedProducts[index].title),
        ),
      ),
    );
  }
}
