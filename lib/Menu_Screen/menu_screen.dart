import 'package:eat_n_go/Menu_Screen/food_detail.dart';
import 'package:eat_n_go/Model/food.dart';
import 'package:eat_n_go/Model/user.dart';
import 'package:eat_n_go/Shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:eat_n_go/Shared/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class MenuScreen extends StatefulWidget {
  final User user;
  final Food food;
  const MenuScreen({Key key, this.user, this.food}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<bool> _selections = [true, false, false, false, false, false, false];
  List foodData;
  double screenHeight, screenWidth;
  String titlecenter = "Loading products...";
  String cartQuantity = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.user.email);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(232, 232, 232, 1),
      appBar: AppBar(
          title: Text(
            'MENU',
            style: style.copyWith(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          leading: IconButton(
              icon: Image.asset('assets/images/icon_no_title.png'),
              onPressed: () {}),
          backgroundColor: Colors.yellow[400],
          automaticallyImplyLeading: false),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ToggleButtons(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Text(
                      'All',
                      style: style.copyWith(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Text('Burger',
                        style: style.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Text('Fried Chicken',
                        style: style.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Text('Drinks',
                        style: style.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Text('Fries',
                        style: style.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Text('Pizza',
                        style: style.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Text('Sandwich',
                        style: style.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold))),
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
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          foodData == null
              ? Expanded(child: Loading())
              : Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (screenWidth / screenHeight) / 0.5,
                      children: List.generate(foodData.length, (index) {
                        return Container(
                            child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              categoriesCard(
                                  "http://shabab-it.com/eat_n_go/food_pictures/${foodData[index]['id']}.png",
                                  foodData[index]['price'],
                                  foodData[index]['name'],
                                  index)
                            ],
                          ),
                        ));
                      })))
        ],
      )),
    );
  }

  Widget categoriesCard(image, price, title, index) {
    return GestureDetector(
      onTap: () => goToDetail(index),
      child: AspectRatio(
        aspectRatio: 3 / 2.9,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: image,
                placeholder: (context, url) => new Loading(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Column(
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
                          "RM " + price,
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
          ],
        ),
      ),
    );
  }

  void _loadData() async {
    String urlLoadFoods = "http://shabab-it.com/eat_n_go/php/load_foods.php";
    await http.post(urlLoadFoods, body: {}).then((res) {
      if (res.body == "nodata") {
        //cartQuantity = "0";
        titlecenter = "No product found";
        setState(() {
          foodData = null;
        });
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          foodData = extractdata["foods"];
          print(res.body);
          //cartQuantity = widget.user.quantity;
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  goToDetail(index) async {
    Food food = new Food(
        foodID: foodData[index]['id'],
        foodName: foodData[index]['name'],
        foodPrice: foodData[index]['price'],
        foodType: foodData[index]['type'],
        foodQuantity: foodData[index]['quantity']);

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                FoodDetail(user: widget.user, food: food)));
  }
}
