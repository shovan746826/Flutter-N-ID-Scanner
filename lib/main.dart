import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_scan_n_id/ImageToText.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingControllerUserName=new TextEditingController();
  TextEditingController textEditingControllerPassword=new TextEditingController();

  String errorData="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0),

              TextField(
                controller: textEditingControllerUserName,
                decoration: InputDecoration(labelText: "Enter User Name"),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),

              SizedBox(height: 16.0),

              TextField(
                controller: textEditingControllerPassword,
                decoration: InputDecoration(labelText: "Enter Password"),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),

              SizedBox(height: 12.0),

              RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if(textEditingControllerUserName.text=="admin" && textEditingControllerPassword.text=="admin"){
                      errorData="";
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) =>ImageToText()
                      ));
                    }else{
                      errorData = "set User Name 'admin' and Password 'admin'";
                    }
                  });
                }

              ),

              SizedBox(height: 8.0),

              Text("$errorData",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
          ),
        )
    );
  }
}
