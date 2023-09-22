
import 'package:flutter/foundation.dart';
import 'package:furniture_shopping/model/addressModel.dart';
import 'package:furniture_shopping/model/cardInfoModel.dart';


class UserModel extends ChangeNotifier {
  String? _name;
  String? _email;
  AddressModel? _address;
  CardInfoModel? _cardInfo;


  String? get name => _name;
  String? get email => _email;
  AddressModel? get address => _address;
  CardInfoModel? get cardInfo => _cardInfo;


  set name(String? value){
    _name = value;
    notifyListeners();
  }
  set email(String? value){
    _email = value;
    notifyListeners();
  }
  set address(AddressModel? value){
    _address = value;
    notifyListeners();
  }
  set cardInfo(CardInfoModel? value){
    _cardInfo = value;
    notifyListeners();
  }


}