import 'package:flutter/cupertino.dart';


class WalletMoney with ChangeNotifier{
  var _money = 0.0;

  double get money{
    return _money;
  }

  void addMoney(double amount){
    _money = _money + amount; 
    notifyListeners();
  }

  void subtractMoney(double amount){
    _money = _money - amount;
    notifyListeners();
  }

}