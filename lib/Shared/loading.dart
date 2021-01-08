import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(232, 232, 232, 1),
      child: Center(
        child: SpinKitFadingCube(
          color: Colors.yellow[400],
          size: 50.0,
          duration: Duration(seconds: 5),
        ),
      ),
    );
  }
}
