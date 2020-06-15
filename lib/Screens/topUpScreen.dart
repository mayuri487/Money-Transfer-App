import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/transactions.dart';
import '../Widgets/topUpItem.dart';

class TopUpScreen extends StatefulWidget {
  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  var _isInit = true;
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TransactionList>(context).fetchTopupData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final transaction = Provider.of<TransactionList>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Top-Up History')),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Container(
                    height: 550,
                    child: ListView.builder(
                        itemCount: transaction.topUpTransactions.length,
                        itemBuilder: (ctx, i) {
                          return TopUpItem(transaction.topUpTransactions[i]);
                        }),
                  )
                ])));
  }
}
