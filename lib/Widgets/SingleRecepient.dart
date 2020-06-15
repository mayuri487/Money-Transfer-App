import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/recepient.dart';

class SingleRecepient extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final recepient = Provider.of<Recepient>(context); 

    return Container(child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: (){
            Navigator.of(context).pushNamed('/sendingScreen',
            arguments: recepient.name
            );
          },
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF3594DD),
                    child: Text(recepient.name, style: TextStyle(
                      color:Colors.black
                    ),),
          radius: 50,
          ),
        ),
      ),
      Text(recepient.name)
    ],)
      
    );
  }
}