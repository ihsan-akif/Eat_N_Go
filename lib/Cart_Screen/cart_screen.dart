import 'dart:async';
import 'dart:convert';
import 'package:eat_n_go/Cart_Screen/payment_screen.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eat_n_go/Model/user.dart';
import 'package:eat_n_go/Shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:eat_n_go/Shared/const.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toast/toast.dart';
import 'package:random_string/random_string.dart';

class CartScreen extends StatefulWidget {
  final User user;
  const CartScreen({Key key, this.user}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List cartData;
  double screenHeight, screenWidth;
  double _totalprice = 0.0;
  double amountpayable;
  String curaddress;
  double deliverycharge;
  Position _currentPosition;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController gmcontroller;
  CameraPosition _home;
  MarkerId markerId1 = MarkerId("12");
  Set<Marker> markers = Set();
  double latitude, longitude;
  String label;
  CameraPosition _userpos;
  bool _useCredit = false;

  @override
  void initState() {
    super.initState();
    _loadCart();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            title: Text(
              'MY CART',
              style: style.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            backgroundColor: Colors.yellow[400],
            automaticallyImplyLeading: false),
        body: Container(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              "Content of your Cart",
              style: style,
            ),
            SizedBox(
              height: 15,
            ),
            cartData == null
                ? Loading()
                : Expanded(
                    child: ListView.builder(
                        itemCount: cartData == null ? 1 : cartData.length + 2,
                        itemBuilder: (context, index) {
                          if (index == cartData.length) {
                            return Container(
                                height: screenHeight / 3,
                                width: screenWidth / 2.5,
                                child: InkWell(
                                  onLongPress: () => {print("Delete")},
                                  child: Card(
                                    //color: Colors.yellow,
                                    elevation: 5,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Select Your Address",
                                            style: style.copyWith(
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        // Text(
                                        //     "Weight:" +
                                        //         _weight.toString() +
                                        //         " KG",
                                        //     style: TextStyle(
                                        //         fontSize: 16.0,
                                        //         fontWeight: FontWeight.bold,
                                        //         color: Colors.white)),
                                        Expanded(
                                            child: Row(
                                          children: <Widget>[
                                            // Container(
                                            //   // color: Colors.red,
                                            //   width: screenWidth / 2,
                                            //   // height: screenHeight / 3,
                                            //   child: Column(
                                            //     children: <Widget>[
                                            //       Row(
                                            //         children: <Widget>[
                                            //           Checkbox(
                                            //             value: _selfPickup,
                                            //             onChanged:
                                            //                 (bool value) {
                                            //               _onSelfPickUp(value);
                                            //             },
                                            //           ),
                                            //           Text(
                                            //             "Self Pickup",
                                            //             style: TextStyle(
                                            //               color: Colors.white,
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    2, 1, 2, 1),
                                                child: SizedBox(
                                                    width: 2,
                                                    child: Container(
                                                      // height: screenWidth / 2,
                                                      color: Colors.grey,
                                                    ))),
                                            Expanded(
                                                child: Container(
                                              //color: Colors.blue,
                                              width: screenWidth / 2,
                                              //height: screenHeight / 3,
                                              child: Column(
                                                children: <Widget>[
                                                  // Row(
                                                  //   children: <Widget>[
                                                  //     Checkbox(
                                                  //       value: _homeDelivery,
                                                  //       onChanged:
                                                  //           (bool value) {
                                                  //         _onHomeDelivery(
                                                  //             value);
                                                  //       },
                                                  //     ),
                                                  //     Text(
                                                  //       "Home Delivery",
                                                  //       style: TextStyle(
                                                  //         color: Colors.white,
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  FlatButton(
                                                    color: Colors.yellow[400],
                                                    onPressed: () =>
                                                        {_loadMapDialog()},
                                                    child: Icon(
                                                      Icons.location_on,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text("Current Address:",
                                                      style: style),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text("  "),
                                                      Flexible(
                                                        child: Text(
                                                          curaddress ??
                                                              "Address not set",
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: style,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                ));
                          }

                          if (index == cartData.length + 1) {
                            return Container(
                                //height: screenHeight / 3,
                                child: Card(
                              elevation: 5,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Payment",
                                      style: style.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(50, 0, 50, 0),
                                      //color: Colors.red,
                                      child: Table(
                                          defaultColumnWidth:
                                              FlexColumnWidth(1.0),
                                          columnWidths: {
                                            0: FlexColumnWidth(7),
                                            1: FlexColumnWidth(3),
                                          },
                                          //border: TableBorder.all(color: Colors.white),
                                          children: [
                                            TableRow(children: [
                                              TableCell(
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    height: 20,
                                                    child: Text(
                                                        "Total Item Price ",
                                                        style: style)),
                                              ),
                                              TableCell(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text(
                                                      "RM" +
                                                              _totalprice
                                                                  .toStringAsFixed(
                                                                      2) ??
                                                          "0.0",
                                                      style: style),
                                                ),
                                              ),
                                            ]),
                                            // TableRow(children: [
                                            //   TableCell(
                                            //     child: Container(
                                            //         alignment:
                                            //             Alignment.centerLeft,
                                            //         height: 20,
                                            //         child: Text(
                                            //             "Delivery Charge ",
                                            //             style: style)),
                                            //   ),
                                            //   TableCell(
                                            //     child: Container(
                                            //       alignment:
                                            //           Alignment.centerLeft,
                                            //       height: 20,
                                            //       child: Text(
                                            //           "RM" +
                                            //                   deliverycharge
                                            //                       .toStringAsFixed(
                                            //                           2) ??
                                            //               "0.0",
                                            //           style: TextStyle(
                                            //               fontWeight:
                                            //                   FontWeight.bold,
                                            //               fontSize: 14,
                                            //               color: Colors.white)),
                                            //     ),
                                            //   ),
                                            // ]),
                                            // TableRow(children: [
                                            // TableCell(
                                            //   child: Container(
                                            //       alignment:
                                            //           Alignment.centerLeft,
                                            //       height: 20,
                                            //       child: Text(
                                            //           "Store Credit RM" +
                                            //               widget.user.credit,
                                            //           style: TextStyle(
                                            //               fontWeight:
                                            //                   FontWeight.bold,
                                            //               color:
                                            //                   Colors.white))),
                                            // ),
                                            // TableCell(
                                            //   child: Container(
                                            //     alignment:
                                            //         Alignment.centerLeft,
                                            //     height: 20,
                                            //     child: Checkbox(
                                            //       value: _storeCredit,
                                            //       onChanged: (bool value) {
                                            //         _onStoreCredit(value);
                                            //       },
                                            //     ),
                                            //   ),
                                            // ),
                                            // ]),
                                            TableRow(children: [
                                              TableCell(
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    height: 20,
                                                    child: Text("Total Amount ",
                                                        style: style)),
                                              ),
                                              TableCell(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text(
                                                      "RM" +
                                                              amountpayable
                                                                  .toStringAsFixed(
                                                                      2) ??
                                                          "0.0",
                                                      style: style),
                                                ),
                                              ),
                                            ]),
                                          ])),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    minWidth: 200,
                                    height: 40,
                                    child: Text(
                                      'Make Payment',
                                      style: style,
                                    ),
                                    color: Colors.yellow[400],
                                    textColor: Colors.black,
                                    elevation: 10,
                                    onPressed: makePaymentDialog,
                                  ),
                                ],
                              ),
                            ));
                          }
                          index -= 0;

                          return Card(
                              elevation: 10,
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Row(children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                            height: screenHeight / 8,
                                            width: screenWidth / 4.5,
                                            child: imageCard(
                                                "http://shabab-it.com/eat_n_go/food_pictures/${cartData[index]['foodid']}.png")),
                                        Text(
                                          "RM " + cartData[index]['price'],
                                          style: style,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 1, 5, 1),
                                        child: SizedBox(
                                            width: 2,
                                            child: Container(
                                              height: screenWidth / 3.5,
                                              color: Colors.grey,
                                            ))),
                                    Container(
                                        width: screenWidth / 1.45,
                                        //color: Colors.blue,
                                        child: Row(
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          //mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    cartData[index]['name'],
                                                    style: style.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 1,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Quantity: " +
                                                        cartData[index]
                                                            ['cquantity'],
                                                    style: style,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                      height: 20,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          FlatButton(
                                                            onPressed: () => {
                                                              _updateCart(
                                                                  index, "add")
                                                            },
                                                            child: Icon(
                                                              MdiIcons.plus,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            cartData[index]
                                                                ['cquantity'],
                                                            style: style,
                                                          ),
                                                          FlatButton(
                                                            onPressed: () => {
                                                              _updateCart(index,
                                                                  "remove")
                                                            },
                                                            child: Icon(
                                                              MdiIcons.minus,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Text(
                                                          "Total: RM " +
                                                              cartData[index]
                                                                  ['yourprice'],
                                                          style: style),
                                                    ],
                                                  ),
                                                  FlatButton(
                                                    onPressed: () =>
                                                        {_deleteCart(index)},
                                                    child: Icon(
                                                      MdiIcons.delete,
                                                      color: Colors.yellow[400],
                                                      size: 40,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ])));
                        })),
          ],
        )));
  }

  Widget imageCard(image) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
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
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }

  void _loadCart() {
    _totalprice = 0.0;
    amountpayable = 0.0;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Updating cart...");
    pr.show();
    String urlLoadEbookCart = "http://shabab-it.com/eat_n_go/php/load_cart.php";
    http.post(urlLoadEbookCart, body: {
      "email": widget.user.email,
    }).then((res) {
      print(res.body);
      pr.hide();
      if (res.body == "Cart Empty") {
        //Navigator.of(context).pop(false);
        widget.user.quantity = "0";
        Container(
          child: Center(
            child: Image(image: AssetImage('assets/images/emptycart.png')),
          ),
        );
      }

      setState(() {
        var extractdata = json.decode(res.body);
        cartData = extractdata["cart"];
        for (int i = 0; i < cartData.length; i++) {
          // _weight = double.parse(cartData[i]['weight']) *
          //         int.parse(cartData[i]['cquantity']) +
          //     _weight;
          _totalprice = double.parse(cartData[i]['yourprice']) + _totalprice;
        }
        // _weight = _weight / 1000;
        amountpayable = _totalprice;

        // print(_weight);
        print(_totalprice);
      });
    }).catchError((err) {
      print(err);
      pr.hide();
    });
    pr.hide();
  }

  void makePaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Proceed with payment?',
          style: style.copyWith(fontWeight: FontWeight.bold),
        ),
        content: new Text(
          'Are you sure?',
          style: style,
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                makePayment();
              },
              child: Text(
                "Ok",
                style: style,
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancel",
                style: style,
              )),
        ],
      ),
    );
  }

  _updateCart(int index, String op) {
    int curquantity = int.parse(cartData[index]['quantity']);
    int quantity = int.parse(cartData[index]['cquantity']);
    if (op == "add") {
      quantity++;
      if (quantity > (curquantity - 2)) {
        Toast.show("Quantity not available", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }
    }
    if (op == "remove") {
      quantity--;
      if (quantity == 0) {
        _deleteCart(index);
        return;
      }
    }
    String urlLoadJobs = "http://shabab-it.com/eat_n_go/php/update_cart.php";
    http.post(urlLoadJobs, body: {
      "email": widget.user.email,
      "foodid": cartData[index]['foodid'],
      "quantity": quantity.toString()
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show("Cart Updated", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _loadCart();
      } else {
        Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }

  _deleteCart(int index) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Delete item?',
          style: style,
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                http.post("http://shabab-it.com/eat_n_go/php/delete_cart.php",
                    body: {
                      "email": widget.user.email,
                      "foodid": cartData[index]['foodid'],
                    }).then((res) {
                  print(res.body);

                  if (res.body == "success") {
                    _loadCart();
                  } else {
                    Toast.show("Failed", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  }
                }).catchError((err) {
                  print(err);
                });
              },
              child: Text(
                "Yes",
                style: style,
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancel",
                style: style,
              )),
        ],
      ),
    );
  }

  void _updatePayment() {
    _totalprice = 0.0;
    amountpayable = 0.0;
    setState(() {
      for (int i = 0; i < cartData.length; i++) {
        _totalprice = double.parse(cartData[i]['yourprice']) + _totalprice;
      }
      if (_useCredit) {
        amountpayable = _totalprice - double.parse(widget.user.credit);
      } else {
        amountpayable = _totalprice;
      }
      print("Total Item Price: $_totalprice");
      print("Total Amount: $amountpayable");
    });
  }

  _getLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    _currentPosition = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //debugPrint('location: ${_currentPosition.latitude}');
    final coordinates =
        new Coordinates(_currentPosition.latitude, _currentPosition.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      curaddress = first.addressLine;
      if (curaddress != null) {
        latitude = _currentPosition.latitude;
        longitude = _currentPosition.longitude;
        return;
      }
    });

    print("${first.featureName} : ${first.addressLine}");
  }

  _getLocationfromlatlng(double lat, double lng, newSetState) async {
    final Geolocator geolocator = Geolocator()
      ..placemarkFromCoordinates(lat, lng);
    _currentPosition = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //debugPrint('location: ${_currentPosition.latitude}');
    final coordinates = new Coordinates(lat, lng);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    newSetState(() {
      curaddress = first.addressLine;
      if (curaddress != null) {
        latitude = _currentPosition.latitude;
        longitude = _currentPosition.longitude;
        return;
      }
    });
    setState(() {
      curaddress = first.addressLine;
      if (curaddress != null) {
        latitude = _currentPosition.latitude;
        longitude = _currentPosition.longitude;
        return;
      }
    });

    print("${first.featureName} : ${first.addressLine}");
  }

  _loadMapDialog() {
    try {
      if (_currentPosition.latitude == null) {
        Toast.show("Location not available. Please wait...", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _getLocation(); //_getCurrentLocation();
        return;
      }
      _controller = Completer();
      _userpos = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 14.4746,
      );

      markers.add(Marker(
          markerId: markerId1,
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: 'Current Location',
            snippet: 'Delivery Location',
          )));

      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, newSetState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: Text(
                  "Select New Delivery Location",
                ),
                titlePadding: EdgeInsets.all(5),
                //content: Text(curaddress),
                actions: <Widget>[
                  Text(
                    curaddress,
                    style: style,
                  ),
                  Container(
                    height: screenHeight / 2 ?? 600,
                    width: screenWidth ?? 360,
                    child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _userpos,
                        markers: markers.toSet(),
                        onMapCreated: (controller) {
                          _controller.complete(controller);
                        },
                        onTap: (newLatLng) {
                          _loadLoc(newLatLng, newSetState);
                        }),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    //minWidth: 200,
                    height: 30,
                    child: Text(
                      'Close',
                      style: style,
                    ),
                    color: Colors.yellow[400],
                    textColor: Colors.black,
                    elevation: 10,
                    onPressed: () =>
                        {markers.clear(), Navigator.of(context).pop(false)},
                  ),
                ],
              );
            },
          );
        },
      );
    } catch (e) {
      print(e);
      return;
    }
  }

  void _loadLoc(LatLng loc, newSetState) async {
    newSetState(() {
      print("insetstate");
      markers.clear();
      latitude = loc.latitude;
      longitude = loc.longitude;
      _getLocationfromlatlng(latitude, longitude, newSetState);
      _home = CameraPosition(
        target: loc,
        zoom: 14,
      );
      markers.add(Marker(
          markerId: markerId1,
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: 'New Location',
            snippet: 'New Delivery Location',
          )));
    });
    _userpos = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.4746,
    );
    _newhomeLocation();
  }

  Future<void> _newhomeLocation() async {
    gmcontroller = await _controller.future;
    gmcontroller.animateCamera(CameraUpdate.newCameraPosition(_home));
    //Navigator.of(context).pop(false);
    //_loadMapDialog();
  }

  Future<void> makePayment() async {
    if (amountpayable < 0) {
      double newamount = amountpayable * -1;
      // await _payusingcredit(newamount);
      _loadCart();
      return;
    }
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyy-');
    String orderid =
        widget.user.email + "-" + formatter.format(now) + randomAlphaNumeric(6);
    print(orderid);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PaymentScreen(
                  user: widget.user,
                  val: amountpayable.toStringAsFixed(2),
                  orderid: orderid,
                )));
    _loadCart();
  }

  String generateOrderid() {
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyy-');
    String orderid = widget.user.email.substring(1, 4) +
        "-" +
        formatter.format(now) +
        randomAlphaNumeric(6);
    return orderid;
  }

  // Future<void> _payusingcredit(double newamount) async {
  //   //insert carthistory
  //   //remove cart content
  //   //update product quantity
  //   //update credit in user
  //   ProgressDialog pr = new ProgressDialog(context,
  //       type: ProgressDialogType.Normal, isDismissible: true);
  //   pr.style(message: "Updating cart...");
  //   pr.show();
  //   String urlPayment = server + "/php/payment_credit.php";
  //   await http.post(urlPayment, body: {
  //     "userid": widget.user.email,
  //     "amount": _totalprice.toStringAsFixed(2),
  //     "orderid": generateOrderid(),
  //     "newcr": newamount.toStringAsFixed(2)
  //   }).then((res) {
  //     print(res.body);
  //     pr.hide();
  //   }).catchError((err) {
  //     print(err);
  //   });
  // }
}
