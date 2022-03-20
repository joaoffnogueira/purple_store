import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_store/models/product_list.dart';
import 'package:purple_store/pages/product_detail_page.dart';
import 'package:purple_store/pages/products_overview_page.dart';
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
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
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
        home: const ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
        },
      ),
    );
  }
}
