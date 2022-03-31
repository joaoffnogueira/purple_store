import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:purple_store/data/dummy_data.dart';
import 'package:purple_store/models/products.dart';
import 'package:purple_store/utils/key.dart';

class ProductList with ChangeNotifier {
  final List<Product> _itens = dummyProducts;
  final _baseUrl = Keys.remoteDataBase;

  List<Product> get itens {
    return [..._itens];
  }

  List<Product> get favoriteItens {
    return _itens.where((product) => product.isFavorite).toList();
  }

  int get itemCount {
    return _itens.length;
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/products.json'),
      body: jsonEncode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite,
      }),
    );
    final id = json.decode(response.body)['name'];
    _itens.add(Product(
      id: id,
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) {
    final index = _itens.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      _itens[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  void removeProduct(Product product) {
    final index = _itens.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      _itens.removeWhere((prod) => prod.id == product.id);
      notifyListeners();
    }
  }
}
