import 'package:flutter/material.dart';
import 'package:eat_n_go/Shared/const.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'MY CART',
              style: style.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            backgroundColor: Colors.yellow[400],
            automaticallyImplyLeading: false),
        body: Column(
          children: [
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Monday, December 14',
                    style: style.copyWith(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    '(3)',
                    style: style.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  child: imageCard('assets/images/burgers/beef_burger.jpg'),
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Beef Burger',
                          style: style.copyWith(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'RM 7.50',
                          style: style.copyWith(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(children: [
                      FlatButton(
                        onPressed: () {
                          print('Minus');
                        },
                        child: Icon(MdiIcons.minus),
                      ),
                      Text(
                        '2',
                        style: style.copyWith(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      FlatButton(
                          onPressed: () {
                            print('Plus');
                          },
                          child: Icon(MdiIcons.plus)),
                      Container(
                        color: Colors.yellow[400],
                        child: IconButton(
                            icon: Icon(MdiIcons.close),
                            onPressed: () {
                              print('Delete');
                            }),
                      )
                    ])
                  ],
                )
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  child: imageCard('assets/images/burgers/spicy_burger.jpg'),
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Spicy Burger',
                          style: style.copyWith(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'RM 8.00',
                          style: style.copyWith(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(children: [
                      FlatButton(
                        onPressed: () {
                          print('Minus');
                        },
                        child: Icon(MdiIcons.minus),
                      ),
                      Text(
                        '1',
                        style: style.copyWith(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      FlatButton(
                          onPressed: () {
                            print('Plus');
                          },
                          child: Icon(MdiIcons.plus)),
                      Container(
                        color: Colors.yellow[400],
                        child: IconButton(
                            icon: Icon(MdiIcons.close),
                            onPressed: () {
                              print('Delete');
                            }),
                      )
                    ])
                  ],
                )
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  child: imageCard('assets/images/fries/normal_fries.jpg'),
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Normal Fries',
                          style: style.copyWith(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'RM 4.00',
                          style: style.copyWith(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(children: [
                      FlatButton(
                        onPressed: () {
                          print('Minus');
                        },
                        child: Icon(MdiIcons.minus),
                      ),
                      Text(
                        '3',
                        style: style.copyWith(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      FlatButton(
                          onPressed: () {
                            print('Plus');
                          },
                          child: Icon(MdiIcons.plus)),
                      Container(
                        color: Colors.yellow[400],
                        child: IconButton(
                            icon: Icon(MdiIcons.close),
                            onPressed: () {
                              print('Delete');
                            }),
                      )
                    ]),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 131,
            ),
            Material(
              elevation: 5.0,
              //borderRadius: BorderRadius.circular(30.0),
              color: Colors.yellow[400],
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {},
                child: Text("Check Out",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ));
  }

  Widget imageCard(image) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image)),
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
