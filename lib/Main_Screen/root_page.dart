import 'package:flutter/material.dart';
import 'package:eat_n_go/Main_Screen/destination.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destination.title),
      ),
      body: SizedBox.expand(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/list');
          },
        ),
      ),
    );
  }
}
