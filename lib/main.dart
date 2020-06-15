//import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Screens/authScreen.dart';
import './Screens/onboardingScreen.dart';
import './Screens/successfulScreen.dart';
import './Screens/settings.dart';
import './Provider/recepientList.dart';
import './Screens/homeScreen.dart';
import './Provider/wallet.dart';
import './Screens/sendingScreen.dart';
import './Provider/transactions.dart';
import './Screens/transactionsScreen.dart';
import './Screens/topUpScreen.dart';
import './Provider/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, TransactionList>(
            create: null,
            update: (ctx, auth, tran) =>
                TransactionList(auth.token, auth.userId, auth.email)),
        ChangeNotifierProvider(
          create: (ctx) => RecepientList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => WalletMoney(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xFF3594DD),
            brightness: Brightness.light,
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Color(0xFF3594DD),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)))),
        home: OnboardingScreen(),
        routes: {
          '/homeScreen': (context) => HomeScreen(),
          '/sendingScreen': (context) => SendingScreen(),
          '/transactionScreen': (context) => TransactionScreen(),
          '/topUpTransaction': (context) => TopUpScreen(),
          '/settings': (context) => SettingsScreen(),
          '/successfulScreen': (context) => SuccessfulScreen(),
          '/authScreen': (context) => AuthScreen()
        },
      ),
    );
  }
}
