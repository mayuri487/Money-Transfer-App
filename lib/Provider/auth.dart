import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfer_app/http_exception.dart';
import '../Screens/authScreen.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  String _email;

    bool get isAuth{
    return token != null;
  }

  String get token {
    if(_expiryDate != null && 
    _expiryDate.isAfter(DateTime.now()) && 
    _token != null)
    {
      return _token;
    }
    return null;
  }

  
  String get userId{
    if(_userId != null){
      return _userId;
    }
    return null;
  }

  String get email{
    if(_email != null){
      return _email;
    }
    return null;
  }



  
  Future<void> signup(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyC2-YcZgHVKiIsIo_grPXjWmkVeufDLSmI';
        try{
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
        
    print(json.decode(response.body));
    final responseData = json.decode(response.body);
    if(responseData['error'] != null){
      throw HttpException(responseData['error']['message']);
    } 
     _token = responseData['idToken'];
    _userId = responseData['localId'];
    _email = responseData['email'];
    _expiryDate = DateTime.now().add(
      Duration(seconds: int.parse(
        responseData['expiresIn'])
        )
        );
        }catch(error){
          throw error;
        }
        
    notifyListeners();
  }

  Future<void> signin(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyC2-YcZgHVKiIsIo_grPXjWmkVeufDLSmI';
        try{
    final response1 = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
   // print('hi!');
    print(json.decode(response1.body));
    final responseData = json.decode(response1.body);
    if(responseData['error'] != null){
      throw HttpException(responseData['error']['message']);
    }
      _token = responseData['idToken'];
    _userId = responseData['localId'];

      _email = responseData['email'];
    _expiryDate = DateTime.now().add(
      Duration(seconds: int.parse(
        responseData['expiresIn'])
        )
        );
    //print('hi!');
        }catch(error){
          throw error; 
        }
        notifyListeners();
    
  }

  // void logOut(){
  //   _token = null;
  //   _userId = null;
  //   _expiryDate = null;
  //   Navigator.of(context).push(
  //     MaterialPageRoute(builder: (BuildContext context) => AuthScreen())
  //     );
  //   notifyListeners();
  // }

}
