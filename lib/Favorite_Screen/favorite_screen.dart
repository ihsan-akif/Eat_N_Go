import 'package:flutter/material.dart';
import 'package:eat_n_go/Shared/const.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'FAVORITE',
              style: style.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            backgroundColor: Colors.yellow[400],
            automaticallyImplyLeading: false),
        body: Container(
          child: Center(
            child: Image(
                image: AssetImage('assets/images/under-construction.png')),
          ),
        ));
  }
}
