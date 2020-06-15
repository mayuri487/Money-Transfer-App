import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    bool _switchValue = ModalRoute.of(context).settings.arguments as bool;
    return  Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Your Profile',
              style: Theme.of(context).textTheme.headline,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListTile(
              trailing: IconButton(icon: Icon(Icons.arrow_forward_ios,
              color: Colors.black,
              size: 10,
              ), 
              onPressed: (){}),
              title: Text('Mayuri Patil', style:TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: Colors.black
              )),
              subtitle: Text('View Profile', style:TextStyle(
                fontSize:15,
                color:Colors.black
              )),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.tealAccent,
                child: Text('M',
                style:Theme.of(context).textTheme.headline
                ),
              ),
              onTap: (){},
            ),
           
      
    ),
    Divider(),
    Switch(value: _switchValue,
    onChanged: (newValue){
      setState(() {
        _switchValue = newValue;
      });
    },
    
    )
   
        ]));
  }
}

