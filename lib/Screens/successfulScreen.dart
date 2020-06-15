import 'package:flutter/material.dart';

class SuccessfulScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue[100], Colors.blue[200], Colors.blue])),
        height: 150,
        width: 250,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(25)),
          child: Center(
            child: Text(
              'Transaction Successful!',
              //textAlign: TextAlign.center,
            ),
          ),
        ),
      )),
    );
  }
}
