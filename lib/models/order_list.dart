import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:purple_store/models/cart.dart';
import 'package:purple_store/models/order.dart';
import 'package:purple_store/utils/key.dart';

class OrderList with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  int get ordersCount {
    return _orders.length;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Keys.remoteDataBase}/orders.json'),
      body: jsonEncode({
        'amount': cart.totalAmount,
        'dateTime': date.toIso8601String(),
        'products': cart.items.values
            .map((cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'title': cartItem.title,
                  'quantity': cartItem.quantity,
                  'price': cartItem.price,
                })
            .toList(),
      }),
    );
    final id = json.decode(response.body)['name'];
    _orders.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        dateTime: date,
      ),
    );
    notifyListeners();
  }
}
