import 'package:flutter/material.dart';
import 'package:purple_store/models/cart.dart';
import 'package:purple_store/models/order.dart';

class OrderList with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  int get ordersCount {
    return _orders.length;
  }

  void addOrder(Cart cart) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}