import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:eat_n_go/Model/food.dart';
import 'package:eat_n_go/Model/user.dart';
import 'package:eat_n_go/Shared/const.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class FoodDetail extends StatefulWidget {
  final User user;
  final Food food;

  const FoodDetail({Key key, this.user, this.food}) : super(key: key);
  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  bool favorite;

  double screenHeight, screenWidth;
  String cartQuantity = "0";
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    print(widget.user.email);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          color: Colors.black,
          child: Center(
            child: Image(
              image: CachedNetworkImageProvider(
                  "http://shabab-it.com/eat_n_go/food_pictures/${widget.food.foodID}.png"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: screenHeight / 9.6, left: screenWidth / 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(false);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => MainScreen()));
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.yellow[400],
                  size: 30.0,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: screenHeight / 9.6, left: screenWidth / 1.4),
                child: FavoriteButton(
                    iconSize: 50.0,
                    iconColor: Colors.yellow[400],
                    valueChanged: (favorite) {
                      if (favorite = true) {
                        print('true');
                      } else {
                        print('false');
                      }
                    })),
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: screenHeight / 5.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    widget.food.foodName,
                    style: style.copyWith(
                        color: Colors.yellow[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
        Container(
            margin: EdgeInsets.only(top: screenHeight / 1.4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'RM ' + widget.food.foodPrice,
                  style: style.copyWith(
                      color: Colors.yellow[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                ),
              ],
            )),
        Container(
          margin: EdgeInsets.only(top: screenHeight / 1.2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: screenHeight / 1.12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.yellow[400],
                  child: MaterialButton(
                    minWidth: screenWidth / 1.2,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      //Navigator.of(context).pop(false);
                      _addToCartDialog();
                    },
                    child: Text("Add To Cart",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ))
      ],
    ));
  }

  _addToCartDialog() {
    quantity = 1;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, newSetState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text("Add " + widget.food.foodName + " to Cart?",
                  style: style.copyWith(fontWeight: FontWeight.bold)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Text("Select the quantity", style: style.copyWith()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => {
                              newSetState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.minus,
                              color: Colors.black,
                            ),
                          ),
                          Text(quantity.toString(), style: style),
                          FlatButton(
                            onPressed: () => {
                              newSetState(() {
                                if (quantity <
                                    (int.parse(widget.food.foodQuantity) - 2)) {
                                  quantity++;
                                } else {
                                  Toast.show("Quantity not available", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.plus,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.yellow[400],
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      _addtoCart();
                    },
                    child: Text(
                      "Yes",
                      style: style,
                    )),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.yellow[400],
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      "Cancel",
                      style: style,
                    )),
              ],
            );
          });
        });
  }

  void _addtoCart() {
    try {
      int cquantity = int.parse(widget.food.foodQuantity);
      print(cquantity);
      print(widget.food.foodID);
      print(widget.user.email);
      if (cquantity > 0) {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal, isDismissible: true);
        pr.style(message: "Add to cart...");
        pr.show();
        String urlLoadJobs =
            "http://shabab-it.com/eat_n_go/php/add_to_cart.php";
        http.post(urlLoadJobs, body: {
          "email": widget.user.email,
          "foodid": widget.food.foodID,
          "quantity": quantity.toString(),
        }).then((res) {
          print(res.body);
          if (res.body == "failed") {
            Toast.show("Failed add to cart", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            pr.hide();
            return;
          } else {
            List respond = res.body.split(",");
            setState(() {
              cartQuantity = respond[1];
              widget.user.quantity = cartQuantity;
            });
            Toast.show("Success add to cart", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
          pr.hide();
        }).catchError((err) {
          print(err);
          pr.hide();
        });
        pr.hide();
      } else {
        Toast.show("Out of Food", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show("Failed add to cart", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
