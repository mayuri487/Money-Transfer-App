import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Transactions {
  final String id;
  final String name;
  final double amount;
  final DateTime dateTime;

  Transactions({this.id, this.name, this.amount, this.dateTime});
}



class TransactionList with ChangeNotifier {
  List<Transactions> _listTransactions = [];

  List<Transactions> get listTransactions {
    return [..._listTransactions];
  }

  List<Transactions> _topUpTransactions = [];

  List<Transactions> get topUpTransactions {
    return [..._topUpTransactions];
  }

  final String token;
  final String userId;
  final String email;

  TransactionList(this.token, this.userId, this.email);

  Future<void> fetchData() async {
    final url =
        'https://money-update-4e568.firebaseio.com/transactionHistory.json?auth=$token&orderBy="userId"&equalTo="$userId"';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Transactions> loadedData = [];
    extractedData.forEach((transactionId, data) {
      loadedData.add(Transactions(
          id: transactionId,
          name: data['name'],
          amount: data['amount'],
          dateTime: DateTime.parse(data['dateTime']))
          
          );
    });
    _listTransactions = loadedData;
    notifyListeners();
  }

  Future<void> addTransactions(String name, double amount) async {
    final url =
        'https://money-update-4e568.firebaseio.com/transactionHistory.json?auth=$token';
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'name': name,
          'amount': amount,
          'dateTime': timeStamp.toIso8601String(),
          'userId': userId
        }));
    _listTransactions.insert(
        0,
        Transactions(
            id: json.decode(response.body)['name'],
            name: name,
            amount: amount,
            dateTime: DateTime.now()));
    notifyListeners();
  }

  Future<void> fetchTopupData() async {
    final url =
      'https://money-update-4e568.firebaseio.com/topupTransaction.json?auth=$token&orderBy="userId"&equalTo="$userId"';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Transactions> loadedData = [];
    print(extractedData);
    extractedData.forEach((transactionId, data) {
      loadedData.add(Transactions(
          id: transactionId,
          name: 'Wallet Top-Up',
          amount: data['amount'],
          dateTime: DateTime.parse(data['dateTime']))
          
          );
    });
    _topUpTransactions = loadedData;
    notifyListeners();
  }

  Future<void> addTopUp(double amount) async {
    final url =
       'https://money-update-4e568.firebaseio.com/topupTransaction.json?auth=$token';
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode(
            {'dateTime': timestamp.toIso8601String(), 
            'amount': amount,
            'userId': userId
            }));
    //  print(json.decode(response.body)['name']);

    _topUpTransactions.insert(
        0,
        Transactions(
            id: json.decode(response.body)['name'],
            name: 'Wallet Top-Up',
            amount: amount,
            dateTime: timestamp,
            
            ));
    notifyListeners();
  }

  Future<void> dismissTransaction(String id) async {
    // _listTransactions.remove(id);
    final url =
        'https://money-update-4e568.firebaseio.com/transactionHistory/$id.json?auth=$token';
    final response = await http.delete(url);
    print(response.body);

    _listTransactions.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
