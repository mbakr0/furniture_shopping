



import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:furniture_shopping/model/item.dart';

class CartModel extends ChangeNotifier{
  final List<Item> _items = [];
  double _totalPrice = 0;
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  String get totalPrice{
    if(_totalPrice < 0 ) return "0.00";
    return double.parse(_totalPrice.toString()).toStringAsFixed(2);
  }



  void add(Item item){
    _totalPrice += item.price;
    _items.add(item);
    notifyListeners();
  }

  void remove(Item item){
    _totalPrice -= item.price;
    _items.remove(item);
    notifyListeners();
  }
  void removeAll(Item item){
        _items.removeWhere((element) {
          if(element.title == item.title)
            {
              _totalPrice -= item.price;
              return true;
            }
          return false;
        }
        );
        notifyListeners();
  }
   void clearCart(){
    _items.clear();
    _totalPrice = 0;
    notifyListeners();
   }

}
