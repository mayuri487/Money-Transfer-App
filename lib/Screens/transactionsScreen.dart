import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/transactionItem.dart';
import '../Provider/transactions.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  var _isInit = true;
  var _isLoading = false;

  // @override
  // void initState() {
  //  // Provider.of<TransactionList>(context).fetchData();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TransactionList>(context).fetchData().then((_) {
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
        appBar: AppBar(
          title: Text('Transaction History'),
          backgroundColor: Color(0xFF3594DD),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 550,
                      child: ListView.builder(
                          itemCount: transaction.listTransactions.length,
                          itemBuilder: (ctx, i) {
                            return TransactionItem(
                                transaction.listTransactions[i]);
                          }),
                    ),
                    Container(
                      width: 400,
                      height: 60,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/topUpTransaction');
                          },
                          child: Card(
                              color: Color(0xFF3594DD),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              /* child: RaisedButton(onPressed: (){
                          Navigator.of(context).pushNamed( '/topUpTransaction');
                          

                        },*/
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'VIEW TOP-UP TRANSACTIONS',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  Icon(Icons.arrow_right)
                                ],
                              ))),
                    ),
                  ],
                ),
              ));
  }
}
