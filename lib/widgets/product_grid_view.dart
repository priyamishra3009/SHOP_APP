// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGridview extends StatelessWidget {
 final bool showfavs;
 const ProductGridview(this.showfavs, {super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);  //here we r accessing products using providers and listeners
    final products = (showfavs)?productData.FavouritesItems:productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: products[i],   //second method for declaring provider..and better for instantiated objects
        child: productItem(
          // products[i].id,
          // products[i].title,
          // products[i].imageUrl,
        ),
      ),
    );
  }
}
