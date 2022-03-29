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

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void addProduct(Product product) {
    _itens.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final index = _itens.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      _itens[index] = product;
      notifyListeners();
    }
  }
}
