// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetalsScreen extends StatelessWidget {
  // final String title;

  // ProductDetalsScreen(this.title);
  static const routename = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    //   print('kya hai bhaiya');
    // if (productId == null) {
    //   print('null hai bhaiya');
    //   Navigator.of(context).pop();
    // }

    final loadedProduct =
        Provider.of<Products>(context, listen: false).getId(productId);
    // print(loadedProduct);
    //we can extract al details of product using this id
    return Scaffold(
      // appBar: AppBar(     //here we r replacing this appbar with sliverappbar
      //   backgroundColor: Theme.of(context).primaryColor,
      //   title: Text(LoadedProduct.title),
      // ),
      body:
//        SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Container(
//               height: 300,
//               width: double.infinity,
//               child: Hero(
//                 tag: LoadedProduct.id,
//                 child: Image.network(
//                   LoadedProduct.imageUrl,
//                   fit: BoxFit.fitWidth,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Price: \$${LoadedProduct.price}',
//               style: const TextStyle(
//                 color: Colors.black54,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               width: double.infinity,
//               child: Text('Description: ${LoadedProduct.description}',

//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600 , ),
//                 // textAlign: TextAlign.center,
//                 softWrap: true,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
          CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title:  Text(
                  loadedProduct.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
            
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 10),
                Text(
                  '\$${loadedProduct.price}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    loadedProduct.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                const SizedBox(
                  height: 800,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
