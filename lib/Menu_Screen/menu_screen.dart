import 'package:flutter/material.dart';
import 'package:eat_n_go/Shared/const.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<bool> _selections = [true, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'EAT N GO MENU',
            style: style.copyWith(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.yellow[400],
          automaticallyImplyLeading: false),
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          height: 30,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ToggleButtons(
                                children: <Widget>[
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('All')),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('Burger')),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('Fried Chicken')),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('Drinks')),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('Fries')),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('Pizza')),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('Sandwich')),
                                ],
                                fillColor: Colors.yellow[400],
                                color: Colors.black,
                                renderBorder: false,
                                borderColor: Colors.yellow[400],
                                selectedColor: Colors.black,
                                isSelected: _selections,
                                onPressed: (int index) {
                                  setState(() {
                                    for (int buttonIndex = 0;
                                        buttonIndex < _selections.length;
                                        buttonIndex++) {
                                      if (buttonIndex == index) {
                                        _selections[buttonIndex] = true;
                                      } else {
                                        _selections[buttonIndex] = false;
                                      }
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          height: 200.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              categoriesCard('music', 'Movie 1'),
                              categoriesCard('music', 'Movie 2'),
                              categoriesCard('music', 'Movie 3'),
                              categoriesCard('music', 'Movie 4'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryBox(category, bool isHighlight) {
    return AspectRatio(
        aspectRatio: 4,
        child: Container(
            margin: EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(category,
                  style:
                      isHighlight ? style : style.copyWith(color: Colors.grey)),
            )));
  }

  Widget categoriesCard(image, title) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
