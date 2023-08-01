// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/product.dart';

class productItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // productItem(this.id, this.title, this.imageUrl);
  productItem();
  /* we are using providers and listeners so we dont need to use constructor method for navigation */

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context,
        listen:
            false); //here we fixed listen as false because we dont want to rebuild everything on pressing favourite button
    // print("product rebuilds");
     final authData=Provider.of<Auth>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            leading: /* here we are adding an alternative of provider.of just to reduce the area of rebuilding */
                Consumer<Product>(
              builder: (context, value, child) => IconButton(
                color: Color.fromARGB(255, 199, 83, 48),
                icon: Icon(product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined),
                onPressed: () {
                  product.toggleFavourite(authData.token, authData.userId);
                },
              ),
            ),
            trailing: IconButton(
              color: Theme.of(context).iconTheme.color,
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItems(product.id, product.title, product.price);
               ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to cart!',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
              },
            )),
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => ProductDetalsScreen(title),
            //   ),

            Navigator.of(context).pushNamed(ProductDetalsScreen.routename,
                arguments: product.id as String);
          },
          child:Hero(     //hero widget is for two screens transition
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
