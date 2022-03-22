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

  void addProduct(Product product) {
    _itens.add(product);
    notifyListeners();
  }
}
