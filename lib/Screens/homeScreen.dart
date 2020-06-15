import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/recepientList.dart';
import '../Provider/transactions.dart';
import '../Widgets/SingleRecepient.dart';
import '../Widgets/add.dart';
import '../Provider/wallet.dart';
import '../Screens/authScreen.dart';

class HomeScreen extends StatelessWidget {
  // final  value;
  // HomeScreen(this.value);

  Widget build(BuildContext context) {
    final recepientData = Provider.of<RecepientList>(context);
  final transaction = Provider.of<TransactionList>(context);

    return Scaffold(
        drawer: Drawer(
            child: Column(
          children: [
            UserAccountsDrawerHeader(
               // accountName: Text("mayu"),
                accountEmail: Text(transaction.email),
                currentAccountPicture: CircleAvatar(
              child: Icon(Icons.account_circle),
                ),
                
                ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log out'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AuthScreen()));
                })
          ],
        )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
           
              SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'My Wallet',
                  style: TextStyle(
                      //fontFamily: 'Bangers',
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 200.0,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            //Text('My Wallet'),
                            Text(
                              'Available Balance',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            Consumer<WalletMoney>(builder: (_, wallet, child) {
                              return Text(
                                '\$${wallet.money}',
                                style: TextStyle(fontSize: 30),
                              );
                            }),
                            SizedBox(height: 25),

                            RaisedButton.icon(
                                color: Color(0xFF3594DD),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return Add();
                                      });
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Top Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ],
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Choose a Recepient',
                      style: TextStyle(
                          //fontFamily: 'Bangers',
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    RaisedButton.icon(
                        color: Color(0xFF3594DD),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Text('Add'))
                  ],
                ),
              ),
              Container(
                  //color: Colors.black,
                  height: 150.0,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: recepientData.list.length,
                    itemBuilder: (ctx, i) {
                      return ChangeNotifierProvider.value(
                        value: recepientData.list[i],
                        child: SingleRecepient(),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  )),
              SizedBox(height: 30),
              Container(
                width: 400,
                height: 60,
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/transactionScreen');
                    },
                    child: Card(
                        color: Color(0xFF3594DD),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        /*child: RaisedButton(onPressed: (){
                          Navigator.of(context).pushNamed( 'transactionScreen');
                          

                        },*/
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'VIEW TRANSACTIONS',
                                style: TextStyle(fontWeight: FontWeight.w900),
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
