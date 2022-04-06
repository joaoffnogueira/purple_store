import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:purple_store/models/cart.dart';
import 'package:purple_store/models/cart_item.dart';
import 'package:purple_store/models/order.dart';
import 'package:purple_store/utils/key.dart';

class OrderList with ChangeNotifier {
  final String _token;
  final String _userId;
  List<Order> _orders = [];

  OrderList([
    this._token = '',
    this._userId = '',
    this._orders = const [],
  ]);

  List<Order> get orders {
    return [..._orders];
  }

  int get ordersCount {
    return _orders.length;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Keys.remoteDataBase}/orders/$_userId.json?auth=$_token'),
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

  Future<void> loadOrders() async {
    final response = await http.get(
        Uri.parse('${Keys.remoteDataBase}/orders/$_userId.json?auth=$_token'));
    if (response.body == 'null') return;
    final List<Order> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(Order(
        id: orderId,
        dateTime: DateTime.parse(orderData['dateTime']),
        products: (orderData['products'] as List<dynamic>)
            .map(
              (item) => CartItem(
                id: item['id'],
                productId: item['productId'],
                price: item['price'],
                quantity: item['quantity'],
                title: item['title'],
              ),
            )
            .toList(),
        total: orderData['amount'],
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }
}
