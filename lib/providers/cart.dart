import 'package:flutter/material.dart';

class cartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  cartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, cartItem> _items = {};
  Map<String, cartItem> get items {
    return {..._items};
  }

  int get ItemCount {
    return _items.length;
  }

  double get TotalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += (cartItem.price * cartItem.quantity);
    });
    return total;
  }

  void addItems(
    String id,
    String title,
    double price,
  ) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (existing) => cartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          quantity: existing.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => cartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
    void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => cartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
