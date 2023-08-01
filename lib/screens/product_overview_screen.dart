// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/badges.dart';
import '../providers/product.dart';
import '../widgets/product_grid_view.dart';

enum filterOptions {
  favourites,
  all,
}

class productOverviewScreen extends StatefulWidget {
  const productOverviewScreen({super.key});

  @override
  State<productOverviewScreen> createState() => _productOverviewScreenState();
}

class _productOverviewScreenState extends State<productOverviewScreen> {
  bool _showFavoritesOnly = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().catchError((error) {
        print(error);
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final List<Product> LoadedProducts = [];

  @override
  Widget build(BuildContext context) {
    // final cartScreen = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: filterOptions.favourites,
                child: Text('Only Favourites'),
              ),
              PopupMenuItem(
                value: filterOptions.all,
                child: Text('Show All'),
              ),
            ],
            onSelected: (filterOptions selectedVal) {
              setState(() {
                if (selectedVal == filterOptions.favourites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
              builder: (_, cart, ch) {
                // print(cart.ItemCount.toString());
                return badge(
                  value: cart.ItemCount.toString(),
                  // color: Colors.black,
                  passedchild: ch ?? Container(),
                );
              },
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: Icon(Icons.shopping_cart),
              ))
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            )
          : ProductGridview(_showFavoritesOnly),
    );
  }
}
