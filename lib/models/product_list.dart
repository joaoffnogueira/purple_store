import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:purple_store/exceptions/http_exception.dart';
import 'package:purple_store/models/products.dart';
import 'package:purple_store/utils/key.dart';

class ProductList with ChangeNotifier {
  List<Product> _itens = [];
  final String _token;
  final String _userId;
  final _url = '${Keys.remoteDataBase}/products.json';

  ProductList([
    this._token = '',
    this._userId = '',
    this._itens = const [],
  ]);

  List<Product> get itens {
    return [..._itens];
  }

  List<Product> get favoriteItens {
    return _itens.where((product) => product.isFavorite).toList();
  }

  int get itemCount {
    return _itens.length;
  }

  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse('$_url?auth=$_token'));
    if (response.body == 'null') return;
    final favoritesResponse = await http.get(
      Uri.parse(
          '${Keys.remoteDataBase}userFavorite/$_userId.json?auth=$_token'),
    );
    Map<String, dynamic> favData = favoritesResponse.body == 'null'
        ? {}
        : json.decode(favoritesResponse.body);
    final List<Product> loadedProducts = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((prodId, prodData) {
      final isFavorite = favData[prodId] ?? false;
      loadedProducts.add(Product(
        id: prodId,
        title: prodData['title'],
        description: prodData['description'],
        price: prodData['price'],
        imageUrl: prodData['imageUrl'],
        isFavorite: isFavorite,
      ));
    });
    _itens.clear();
    _itens.addAll(loadedProducts);
    notifyListeners();
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
      Uri.parse('$_url?auth=$_token'),
      body: jsonEncode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
      }),
    );
    final id = json.decode(response.body)['name'];
    _itens.add(Product(
      id: id,
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final index = _itens.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse(
            '${Keys.remoteDataBase}products/${product.id}.json?auth=$_token'),
        body: jsonEncode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );
      _itens[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    final index = _itens.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      final product = _itens[index];
      _itens.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse(
            '${Keys.remoteDataBase}products/${product.id}.json?auth=$_token'),
      );
      if (response.statusCode >= 400) {
        _itens.insert(index, product);
        notifyListeners();
        throw HttpException(
            message: 'Não foi possível excluir o produto.',
            statusCode: response.statusCode);
      }
    }
  }
}
