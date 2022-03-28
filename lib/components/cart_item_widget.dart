import 'package:flutter/material.dart';
import 'package:purple_store/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({required this.cartItem, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cartItem.title),
      subtitle: Text('R\$ ${cartItem.price}'),
      trailing: Text('${cartItem.quantity}'),
    );
  }
}
