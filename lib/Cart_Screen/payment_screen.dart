import 'dart:async';
import 'package:eat_n_go/Model/user.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  final String orderid, val;
  PaymentScreen({this.user, this.orderid, this.val});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('PAYMENT'), backgroundColor: Colors.white),
        body: Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                initialUrl:
                    'http://shabab-it.com/eat_n_go/php/payment.php?email=' +
                        widget.user.email +
                        '&mobile=' +
                        widget.user.phoneNum +
                        '&name=' +
                        widget.user.name +
                        '&amount=' +
                        widget.val +
                        '&orderid=' +
                        widget.orderid,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              ),
            )
          ],
        ));
  }
}
