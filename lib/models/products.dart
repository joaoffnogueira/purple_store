import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:purple_store/utils/key.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String token) async {
    try {
      isFavorite = !isFavorite;
      notifyListeners();

      final response = await http.patch(
        Uri.parse('${Keys.remoteDataBase}products/$id.json?auth=$token'),
        body: jsonEncode({'isFavorite': isFavorite}),
      );

      if (response.statusCode >= 400) {
        isFavorite = !isFavorite;
        notifyListeners();
      }
    } on Exception catch (_) {
      isFavorite = !isFavorite;
      notifyListeners();
    }
  }
}
