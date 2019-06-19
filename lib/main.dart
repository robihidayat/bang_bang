import 'package:beng_beng/launcer/launcer_view.dart';
import 'package:beng_beng/utils/ColorPlate.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gojek',
      theme: new ThemeData(
        fontFamily: 'NeoSans',
        primaryColor: ColorPlate.green,
        accentColor: ColorPlate.green,
      ),
      home: new LauncherPage(),
    );
  }
}