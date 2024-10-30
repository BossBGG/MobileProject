import 'package:flutter/material.dart'; 
import 'cart_item.dart';

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void updateItemQuantity(CartItem item, int newQuantity) {
    int index = _items.indexOf(item);
    if (index != -1) {
      _items[index] = CartItem(
        shirt: item.shirt,
        selectedSize: item.selectedSize,
        selectedColor: item.selectedColor,
        quantity: newQuantity,
      );
      notifyListeners();
    }
  }
// รวมยอดราคาทั้งหมดในตะกร้า
  double get totalCartPrice {
    return _items.fold(0, (total, item) => total + item.totalPrice);
  }
}
