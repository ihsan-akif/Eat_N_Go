import 'package:eat_n_go/Menu_Screen/menu_screen.dart';
import 'package:eat_n_go/Shared/const.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:eat_n_go/Model/user.dart';
import 'package:eat_n_go/Main_Screen/main_screen.dart';

void userLogin(BuildContext context, TextEditingController email,
    TextEditingController password) async {
  String urlLogin = "http://shabab-it.com/eat_n_go/php/login_user.php";

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
  String _email = email.text;
  String _password = password.text;

  http.post(urlLogin, body: {
    "email": _email,
    "password": _password,
  }).then((res) {
    var string = res.body;
    print(res.body);
    List userdata = string.split(",");
    if (userdata[0] == "success") {
      User _user = new User(
          name: userdata[1],
          email: _email,
          password: _password,
          phoneNum: userdata[3],
          datereg: userdata[4],
          quantity: userdata[5],
          credit: userdata[6]);
      pr.hide();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => MainScreen(
                    user: _user,
                  )));
    } else {
      pr.hide();
      Toast.show("Login Failed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }).catchError((err) {
    print('Error: $err');
    pr.hide();
  });
}
