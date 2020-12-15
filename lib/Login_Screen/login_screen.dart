import 'package:eat_n_go/Main_Screen/main_screen.dart';
import 'package:eat_n_go/Register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:eat_n_go/Shared/const.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.yellow[400],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Login',
              style: style.copyWith(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.yellow[400],
          ),
          body: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250.0,
                      child: Image.asset(
                        'assets/images/icon.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 45.0,
                    ),
                    emailField,
                    SizedBox(
                      height: 25.0,
                    ),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    loginButon,
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Does not have account?  ',
                          style: style.copyWith(fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: toRegisterScreen,
                          child: Text(
                            'Sign Up',
                            style: style.copyWith(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    GestureDetector(
                      onTap: toMainScreen,
                      child: Text(
                        'Continue as guest',
                        style: style.copyWith(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void toRegisterScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
  }

  void toMainScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
  }
}
