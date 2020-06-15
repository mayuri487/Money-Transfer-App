import '../Provider/recepient.dart';
import 'package:flutter/cupertino.dart';


class RecepientList with  ChangeNotifier{
  List<Recepient> _recepientList =[
    Recepient(id: 'm1', name: 'Jhon'),
    Recepient(id: 'm2', name: 'Devid'),
    Recepient(id: 'm3', name: 'Jessica'),
    Recepient(id: 'm4', name: 'Hannha'),
    Recepient(id: 'm5', name: 'Clay'),

  ];

  List<Recepient> get list{
    return [..._recepientList];
  }
}