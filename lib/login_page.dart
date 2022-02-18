import 'package:eco_pop/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required String title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignIn() async {
    try {
      var user1 = await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage('assets/ECOPoP.jpg'),
                  ), //AssetImage("assets/Serenity.png"),
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  //Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //builder: (context) => MeusDados()));
                },
                label: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.green,
              ),
            ]),
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
