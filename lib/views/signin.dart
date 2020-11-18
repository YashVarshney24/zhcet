import 'package:chatapp/helper/helperfunction.dart';
import 'package:chatapp/log.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chatroomscreen.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  final Function toggle;
  Signin({this.toggle});
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final formkey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseAuth databaseAuth = new DatabaseAuth();
  TextEditingController passwordTexteditingcontroller =
      new TextEditingController();
  TextEditingController emailTexteditingcontroller =
      new TextEditingController();
  bool isloading = false;
  QuerySnapshot snap;
  signin() {
    if (formkey.currentState.validate()) {
      // Helperfunction.savedUsernamesharedprefence(usernameTexteditingcontroller.text);
      Helperfunction.savedUseremailsharedprefence(
          emailTexteditingcontroller.text);
      setState(() {
        isloading = true;
      });
      databaseAuth.getuSerbyemaile(emailTexteditingcontroller.text).then((val) {
        snap = val;
        Helperfunction.savedUsernamesharedprefence(snap.docs[0].data()['name']);
      });
      authMethods
          .signInWithEmailAndPassword(emailTexteditingcontroller.text,
              passwordTexteditingcontroller.text)
          .then((val) {
        if (val != null) {
          Helperfunction.saveduserLoggingsharedprefence(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => User()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMain(context),
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/bg.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Form(
                        key: formkey,
                        child: Column(children: [
                          Container(
                            height: 65,
                            width: 375,
                            //color: Colors.deepOrange,
                            decoration: BoxDecoration(
                              //color: Colors.lightBlue.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)
                                    ? null
                                    : "Please provide a valid mail";
                              },
                              controller: emailTexteditingcontroller,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelText: 'E-MAIL',
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            obscureText: true,
                            validator: (value) {
                              return value.length > 6
                                  ? null
                                  : "Please provide password 6+ character";
                            },
                            controller: passwordTexteditingcontroller,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              prefixIcon: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(height: 17),
                      Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            child: Text(
                              "Forgot Password",
                              style: simpletextstyle(),
                            ),
                          )),
                      SizedBox(
                        height: 17,
                      ),
                      GestureDetector(
                          onTap: () {
                            signin();
                          },
                          child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    const Color(0xff007EF4),
                                    const Color(0xff2A75BC)
                                  ]),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ))),
                      SizedBox(
                        height: 13,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "Sign In with Google",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Dont Have account?",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)),
                          GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "Register Now",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  )))
                        ],
                      ),
                      SizedBox(
                        height: 95,
                      )
                    ],
                  ),
                ))));
  }
}
