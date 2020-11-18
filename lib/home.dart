import 'dart:ui';

//import 'package:app/register.dart';
import 'package:chatapp/helper/authenticate.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ZHCET APP"),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/download.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  child: Center(
                    child: Text(
                      '''ZAKIR HUSAIN COLLEGE OF ENGINEERING AND TECHNOLOGY 
  AMU ALIGARH''',
                      style: TextStyle(
                        fontSize: 22,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          ..color = Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                width: 200,
                child: Image.asset('images/amu.png'),
              ),
              SizedBox(
                height: 40,
              ),
              Material(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(20),
                elevation: 10,
                child: MaterialButton(
                  onPressed: () {
                    print("pressed..");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authenticate()));
                  },
                  child: Text("CLICK TO PROCEED"),
                  minWidth: 200,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
