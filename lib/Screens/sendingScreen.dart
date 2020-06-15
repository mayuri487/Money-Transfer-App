import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/successfulScreen.dart';
import '../Provider/wallet.dart';
import '../Provider/transactions.dart';

class SendingScreen extends StatefulWidget {
  @override
  _SendingScreenState createState() => _SendingScreenState();
}

class _SendingScreenState extends State<SendingScreen> {
  final inputAmount = TextEditingController();

  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context).settings.arguments as String;
    final transaction = Provider.of<TransactionList>(context, listen: false);
    final wallet = Provider.of<WalletMoney>(context, listen: false);

    return Scaffold(
        appBar: AppBar(title: Text('Transfer')),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Stack(children: [
              Image.network(
                'https://image.freepik.com/free-vector/illustration-characters-transacting-money_53876-37252.jpg',
                color: Colors.black54,
                colorBlendMode: BlendMode.darken,
              ),
              Column(
                children: [
                  SizedBox(height: 40),
                  Text('How much would you like to send?',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter a Amount',
                      ),
                      controller: inputAmount,
                    ),
                  ),
                  SizedBox(height: 40),
                  RaisedButton(
                      onPressed: () async {
                        if (double.parse(inputAmount.text) > wallet.money) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('You don\'t have enough money'),
                              content: Text('Please Top up your wallet'),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text('Ok')),
                              ],
                            ),
                          );
                          return;
                        }
                        setState(() {
                          _isLoading = true;
                        });
                        await transaction.addTransactions(
                            name, double.parse(inputAmount.text));
                        wallet.subtractMoney(double.parse(inputAmount.text));
                        setState(() {
                          _isLoading = false;
                        });
                        setState(() {
                          inputAmount.text = '';
                        });
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SuccessfulScreen()));
                        // Scaffold.of(context).showSnackBar(SnackBar(
                        //   content: Text('Transaction Successful'),
                        // ));
                      },
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text('Send to $name'))
                ],
              ),
            ]),
          ),
        ));
  }
}
