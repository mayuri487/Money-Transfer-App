import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Provider/transactions.dart';

class TransactionItem extends StatefulWidget {

  final Transactions transactions;
  TransactionItem(this.transactions);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    final transaction = Provider.of<TransactionList>(context);
    
    return Dismissible(
      key: ValueKey(widget.transactions.id),
      background: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.delete, color: Colors.white,),
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        transaction.dismissTransaction(widget.transactions.id);
      },
          child: Card(
        elevation: 10,
            child: ListTile(
         leading: CircleAvatar(
           child: Icon(Icons.attach_money)
         ),
         title: Text(widget.transactions.name),
         subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.transactions.dateTime)),
          trailing: Text(' -\$${widget.transactions.amount}',
            style: TextStyle(
            fontWeight: FontWeight.bold,
            //color: Colors.green,
            fontSize: 20
          ),
          ),
        ),
      ),
      confirmDismiss: (direction){
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove this transaction from history?'
            ),
            actions: [
              FlatButton(onPressed: (){
                Navigator.of(ctx).pop(true);
              }, child: Text('Yes')),
              FlatButton(onPressed: (){
                Navigator.of(context).pop(false);
              }, child: Text('No'))
            ],
          ),
          );
      },
    );
  }
}