import 'package:eat_n_go/Main_Screen/destination.dart';
import 'package:flutter/material.dart';

class TextPage extends StatelessWidget {
  const TextPage({Key key, this.destination}) : super(key: key);

  final Destination destination;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Material App Bar',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
