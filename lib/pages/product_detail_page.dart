import 'package:flutter/material.dart';
import 'package:purple_store/models/products.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 300,
            width: double.infinity,
            child: Hero(
              tag: product.id,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'R\$ ${product.price}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Descrição',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.description,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      )),
    );
  }
}
