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
      backgroundColor: Color.fromRGBO(232, 232, 232, 1),
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
                                      child: Text(
                                        'All',
                                        style: style.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('Burger',
                                          style: style.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('Fried Chicken',
                                          style: style.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('Drinks',
                                          style: style.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('Fries',
                                          style: style.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('Pizza',
                                          style: style.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Text('Sandwich',
                                          style: style.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold))),
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
                              categoriesCard(
                                  'assets/images/burgers/chicken_burger.jpg',
                                  'RM 6.50',
                                  'Chicken Burger'),
                              categoriesCard(
                                  'assets/images/burgers/beef_burger.jpg',
                                  'RM 7.50',
                                  'Beef Burger'),
                              categoriesCard(
                                  'assets/images/burgers/spicy_burger.jpg',
                                  'RM 8.00',
                                  'Spicy Chicken Burger'),
                              categoriesCard(
                                  'assets/images/fries/normal_fries.jpg',
                                  'RM 4.00',
                                  'Normal Fries'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Special Offers',
                          style: style.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          children: [
                            Container(
                                height: 250.0,
                                child: AspectRatio(
                                  aspectRatio: 2.9 / 3,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 16.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/burgers/chicken_burger.jpg')),
                                      color: Colors.black,
                                      //borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Align(
                                      alignment: Alignment(-0.8, -0.85),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Text(
                                            'RM 9.50',
                                            style: style.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                            Container(
                              height: 250,
                              child: Card(
                                color: Colors.white,
                                child: AspectRatio(
                                  aspectRatio: 1.52 / 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Chicken Burger with French Fries',
                                        textAlign: TextAlign.center,
                                        style: style.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Chicken, Tomato, Lettuce, Garlic, Cheese, Sauce, French Fries',
                                          textAlign: TextAlign.left,
                                          style: style.copyWith(fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
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

  Widget categoriesCard(image, price, title) {
    return AspectRatio(
      aspectRatio: 3 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image)),
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 2.0),
              child: Align(
                alignment: Alignment(-0.8, -0.8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      price,
                      style: style.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  title,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
