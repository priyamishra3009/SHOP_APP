// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/splash_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_details_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import './providers/products.dart';
import 'helpers/custom_route.dart';
import 'screens/orders_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
           create: (_) => Products(null,null,[]),
          update: (ctx, auth, previousProducts) => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items,
              ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
       
        ChangeNotifierProxyProvider<Auth, Orders>(
           create: (_) => Orders(null,null,[]),
          update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders,
              ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
        title: 'MyShop',
        theme: ThemeData(  
          pageTransitionsTheme: PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: CustomPageTransitionBuilder(),
                    TargetPlatform.iOS: CustomPageTransitionBuilder(),
                  },
                ),
          primaryColor: Color.fromARGB(255, 95, 31, 37),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Color.fromARGB(255, 199, 83, 48)),

          iconTheme: IconThemeData(color: Color.fromARGB(255, 199, 83, 48),),
          // textTheme: TextTheme(titleMedium: TextStyle(color: Colors.white,)),
        ),
        home: auth.isAuth ? productOverviewScreen() 
         : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                              ),
       
        routes: {
          ProductDetalsScreen.routename: (context) => ProductDetalsScreen(),
          CartScreen.routeName: (context) => CartScreen(),
         OrdersScreen.routeName: (context) => OrdersScreen(),
         UserProductsScreen.routeName: (context) => UserProductsScreen(),
      EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    ));
  }
}
