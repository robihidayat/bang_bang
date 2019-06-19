

import 'dart:async';

import 'package:beng_beng/beranda/activity/login/login_page.dart';
import 'package:beng_beng/landingpage/landingpage_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => new _LauncherPageState();
}

const String spKey = 'isLogin';

class _LauncherPageState extends State<LauncherPage> {
  bool checkValue = false;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    print('init preference');
    SharedPreferences.getInstance().then((SharedPreferences sharePreference) {
      sharedPreferences = sharePreference;
      checkValue = sharedPreferences.getBool(spKey);
      // will be null if never previously saved
      if (checkValue == null) {
        checkValue = false;
        persist(checkValue); // set an initial value
      }
      setState(() {});
    });
    startLaunching();

  }

  void persist(bool value) {
    setState(() {
      checkValue = value;
    });
    sharedPreferences?.setBool(spKey, value);

  }

  startLaunching() async {
    var duration = const Duration(seconds: 1);
    sharedPreferences = await SharedPreferences.getInstance();
    checkValue = sharedPreferences.getBool(spKey);

    if (checkValue != null) {
      if (checkValue) {
        print('checkValue -> '+checkValue.toString());
        return new Timer(duration, () {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) {
            return new LandingPage();
          }));
        });
      } else {
        print('checkValue -> '+checkValue.toString());
        return new Timer(duration, () {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) {
            return new Login();
          }));
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset(
          "assets/images/beng-bang-logo.png",
          height: 100.0,
          width: 200.0,
        ),
      ),
    );
  }
}
