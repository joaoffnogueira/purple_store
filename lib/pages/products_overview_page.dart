import 'package:flutter/material.dart';
import 'package:purple_store/components/product_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purple Store'),
      ),
      body: const ProductGrid(),
    );
  }
}
