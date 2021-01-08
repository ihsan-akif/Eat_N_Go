import 'package:eat_n_go/Register_screen/validator.dart';
import 'package:flutter/material.dart';
import 'package:eat_n_go/Shared/const.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:eat_n_go/Login_Screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _phoneNum = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  final focus0 = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String urlRegister = "http://shabab-it.com/eat_n_go/php/register_user.php";

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      controller: _name,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(focus0);
      },
      validator: validateName,
      onSaved: (String val) {
        _name.text = val;
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter Your Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final emailField = TextFormField(
      controller: _email,
      focusNode: focus1,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(focus2);
      },
      validator: validateEmail,
      onSaved: (String val) {
        _email.text = val;
      },
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter Your Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final phoneNumField = TextFormField(
      controller: _phoneNum,
      focusNode: focus0,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(focus1);
      },
      validator: validatePhoneNum,
      onSaved: (String val) {
        _phoneNum.text = val;
      },
      obscureText: false,
      keyboardType: TextInputType.phone,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter Your Phone Number",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextFormField(
      controller: _password,
      focusNode: focus2,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(focus3);
      },
      validator: validatePassword,
      onSaved: (String val) {
        _password.text = val;
      },
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter Your Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final registerButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.yellow[400],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: _userRegister,
        child: Text("Sign Up",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );

    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('Sign Up',
                style: style.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            centerTitle: true,
            backgroundColor: Colors.yellow[400],
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(36.0, 0, 36.0, 36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Create Account',
                            style: style.copyWith(fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Text(
                              'Enter your Name, Phone Number, Email and Password for sign up.',
                              style: style.copyWith(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    nameField,
                    SizedBox(
                      height: 25.0,
                    ),
                    phoneNumField,
                    SizedBox(
                      height: 25.0,
                    ),
                    emailField,
                    SizedBox(
                      height: 25.0,
                    ),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    registerButon,
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void _userRegister() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Registration Confirmation",
            style: style.copyWith(fontWeight: FontWeight.bold),
          ),
          content: new Container(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Are you sure you wants to register a new account?",
                  style: style,
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
                child: new Text(
                  "Yes",
                  style: style.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _checkedFormat();
                }),
            new FlatButton(
              child: new Text(
                "No",
                style: style.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _checkedFormat() {
    String name = _name.text;
    String email = _email.text;
    String phoneNum = _phoneNum.text;
    String password = _password.text;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Please wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle:
            style.copyWith(fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle:
            style.copyWith(fontSize: 19.0, fontWeight: FontWeight.w600));
    pr.show();
    http.post(urlRegister, body: {
      "name": name,
      "email": email,
      "password": password,
      "phoneNum": phoneNum,
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Navigator.pop(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
        Toast.show("Registration Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        pr.hide();
      } else {
        Toast.show("Registration Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        pr.hide();
      }
    }).catchError((err) {
      print(err);
    });
    pr.hide();
  }
}
