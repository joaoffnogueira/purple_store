import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_store/models/auth.dart';
import 'package:purple_store/models/cart.dart';
import 'package:purple_store/models/order_list.dart';
import 'package:purple_store/models/product_list.dart';
import 'package:purple_store/pages/auth_or_home_page.dart';
import 'package:purple_store/pages/cart_page.dart';
import 'package:purple_store/pages/orders_page.dart';
import 'package:purple_store/pages/product_detail_page.dart';
import 'package:purple_store/pages/product_form_page.dart';
import 'package:purple_store/pages/products_page.dart';
import 'package:purple_store/utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeData tema = ThemeData();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) => ProductList(
            auth.token ?? '',
            auth.userId ?? '',
            previous?.itens ?? [],
          ),
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) => OrderList(
            auth.token ?? '',
            previous?.orders ?? [],
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.deepPurple,
            secondary: Colors.deepPurpleAccent,
          ),
          textTheme: tema.textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'Lato',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
          AppRoutes.CART: (context) => const CartPage(),
          AppRoutes.ORDERS: (context) => const OrdersPage(),
          AppRoutes.PRODUCTS: (context) => const ProductsPage(),
          AppRoutes.PRODUCT_FORM: (context) => const ProductFormPage(),
        },
      ),
    );
  }
}
