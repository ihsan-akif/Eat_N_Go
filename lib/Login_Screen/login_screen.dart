import 'package:eat_n_go/Login_Screen/user_login.dart';
import 'package:eat_n_go/Main_Screen/main_screen.dart';
import 'package:eat_n_go/Register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:eat_n_go/Shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight;
  TextEditingController _emailEditingCtrl = new TextEditingController();
  TextEditingController _passwordEditingCtrl = new TextEditingController();
  bool rememberMe = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    final emailField = TextField(
      controller: _emailEditingCtrl,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: _passwordEditingCtrl,
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
        onPressed: () =>
            userLogin(context, _emailEditingCtrl, _passwordEditingCtrl),
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );

    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
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
                padding: const EdgeInsets.fromLTRB(36.0, 0.0, 36.0, 0.0),
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
                      height: 15.0,
                    ),
                    passwordField,
                    // SizedBox(
                    //   height: 35.0,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                            value: rememberMe,
                            onChanged: (bool value) {
                              _onRememberMeChanged(value);
                            }),
                        Text(
                          "Remember Me",
                          style: style.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        )
                      ],
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

  void loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString("email")) ?? '';
    String password = (prefs.getString("pass")) ?? '';
    if (email.length > 1) {
      setState(() {
        _emailEditingCtrl.text = email;
        _passwordEditingCtrl.text = password;
        rememberMe = true;
      });
    }
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;
        print(rememberMe);
        if (rememberMe) {
          savepref(true);
        } else {
          savepref(false);
        }
      });

  void savepref(bool value) async {
    String email = _emailEditingCtrl.text;
    String password = _passwordEditingCtrl.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //save preference
      await prefs.setString("email", email);
      await prefs.setString("pass", password);
      Toast.show("Email and Password Saved!", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      //delete preference
      await prefs.setString("email", "");
      await prefs.setString("pass", "");
      setState(() {
        _emailEditingCtrl.text = "";
        _passwordEditingCtrl.text = "";
        rememberMe = false;
      });
      Toast.show("Email and Password Removed!", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }
}
