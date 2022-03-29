import 'dart:math';

import 'package:flutter/material.dart';
import 'package:purple_store/data/dummy_data.dart';
import 'package:purple_store/models/products.dart';

class ProductList with ChangeNotifier {
  final List<Product> _itens = dummyProducts;

  List<Product> get itens {
    return [..._itens];
  }

  List<Product> get favoriteItens {
    return _itens.where((product) => product.isFavorite).toList();
  }

  int get itemCount {
    return _itens.length;
  }

  void addProductFromData(Map<String, Object> data) {
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    addProduct(newProduct);
  }

  void addProduct(Product product) {
    _itens.add(product);
    notifyListeners();
  }
}
