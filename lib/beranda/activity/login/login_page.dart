

import 'dart:convert';

import 'package:beng_beng/beranda/beranda_view.dart';
import 'package:beng_beng/landingpage/landingpage_view.dart';
import 'package:beng_beng/model/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget{

  @override
  LoginState createState() => new LoginState();
}

class LoginState extends State<Login> {


  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final _username = TextEditingController();
  final _password = TextEditingController();

  String _response = '';
  bool _apiCall = false;

  // login shared prefs
  bool alreadyLogin = false;

  // fungsi untuk kirim http post
  Future<Response> post(String url,var body)async{
    return await http
        .post(Uri.encodeFull(url), body: body, headers: {"Accept":"application/json"})
        .then((http.Response response) {

      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return Response.fromJson(json.decode(response.body));
    });
  }

  // fungsi panggil API
  void _callPostAPI() async {
         if(_username.text == _password.text){
           final prefs = await SharedPreferences.getInstance();
           setState(() {
             alreadyLogin = true;
             prefs.setBool('isLogin', alreadyLogin);
           });
         } else {
            _apiCall = false;
             _response = _username.text;
         }
        // menuju route list product
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LandingPage())
        );
  }

  Widget progressWidget() {
    if (_apiCall)
      // jika masih proses kirim API
      return AlertDialog(
        content: new Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Please wait")
          ],
        ),
      );
    else
      // jika sudah selesai kirim API
      return Center(
        child: Text(
          _response,
          style: new TextStyle(fontSize: 15.0),
        ),
      );
  }

  Future<bool> getLoginStatus() async{
    final prefs = await SharedPreferences.getInstance();
    bool loginStatus = prefs.getBool('login') ?? false;
    print('login status $loginStatus');
    return loginStatus;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      future: getLoginStatus(),
      builder: (context, snapshot) {
        try{
          return (snapshot.data) ?
          new LandingPage() :
          loginForm();
        } catch (e){
          print(e.toString());

        }

      },
    );
  }

  Widget loginForm() {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                SizedBox(
                    height: 155.0,
                    child: Image.asset(
                    "assets/images/beng-bang-logo.png",
                    fit: BoxFit.contain,),),
                SizedBox(height: 45.0),
                TextField(
                  style: style,
                  controller: _username,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "username",
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 25.0),
                TextField(
                  style: style,
                  obscureText: true,
                  controller: _password,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "password",
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 35.0,),
                Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xff01A0C7),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        setState(() {
                          _apiCall = true;
                        });
                        _callPostAPI();
                      },
                      child: Text("Login",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 35.0),
                  progressWidget(),
                  SizedBox(height: 15.0,
              ),
            ])
          ),)
        )
    );
  }


}