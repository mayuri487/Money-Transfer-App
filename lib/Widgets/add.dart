import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/wallet.dart';
import '../Provider/transactions.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final addedInput = TextEditingController();
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final transaction = Provider.of<TransactionList>(context);
    final wallet = Provider.of<WalletMoney>(context);

    return Container(child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
             labelText: 'Enter Amount' 
          ),
          controller: addedInput,
        ),
      ),
      RaisedButton(onPressed: () async {
        setState(() {
          _isLoading = true;
        });
        await transaction.addTopUp( double.parse(addedInput.text));
        wallet.addMoney(double.parse(addedInput.text));
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      },
      child: _isLoading ? CircularProgressIndicator() : Text('Add'),
      )
    ],),
      
    );
  }
}