import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Provider/transactions.dart';

class TopUpItem extends StatefulWidget {

  final Transactions transactions;
  TopUpItem(this.transactions);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TopUpItem> {
  @override
  Widget build(BuildContext context) {
   // final transaction = Provider.of<TransactionList>(context);
    
    return Card(
      elevation: 10,
          child: ListTile(
       leading: Icon(Icons.account_balance_wallet),
       title: Text(widget.transactions.name),
       subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.transactions.dateTime)),
        trailing: Text(' \$${widget.transactions.amount}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
          fontSize: 20
        ),
        ),
      ),
    );
  }
}