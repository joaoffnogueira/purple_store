import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purple_store/models/auth.dart';
import 'package:purple_store/pages/auth_page.dart';
import 'package:purple_store/pages/products_overview_page.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return Center(
            child: Text('Ocorreu um erro ao carregar dados'),
          );
        } else {
          return auth.isAuth
              ? ProductsOverviewPage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.error != null) {
                      return Center(
                        child: Text('Ocorreu um erro ao carregar dados'),
                      );
                    } else {
                      return auth.isAuth ? ProductsOverviewPage() : AuthPage();
                    }
                  },
                );
        }
      },
    );
  }
}
