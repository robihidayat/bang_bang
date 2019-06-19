

import 'package:beng_beng/beranda/activity/login/login_page.dart';
import 'package:flutter/material.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => new _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login())
            );
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }


}