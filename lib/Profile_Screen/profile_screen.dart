import 'package:flutter/material.dart';
import 'package:eat_n_go/Shared/const.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  double screenHeight, screenWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text(
            'My Profile',
            style: style.copyWith(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.yellow[400],
          automaticallyImplyLeading: false),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromRGBO(232, 232, 232, 1),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    child: ClipOval(
                  child: Image.network(
                    "https://i.pinimg.com/originals/0c/3b/3a/0c3b3adb1a7530892e55ef36d3be6cb8.png",
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Ihsan', style: style.copyWith(fontWeight: FontWeight.bold)),
              Container(
                //decoration: new BoxDecoration(color: Colors.yellow[400]),
                child: Builder(
                  builder: (BuildContext context) {
                    return TabBar(
                      controller: _controller,
                      tabs: [
                        new Tab(
                          child: Text(
                            'Info',
                            style: style.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        new Tab(
                          child: Text(
                            'Settings',
                            style: style.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                height: screenHeight / 1.94,
                child: new TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Card(
                        elevation: 10,
                        child: Container(
                          color: Colors.yellow[400],
                          padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                          //color: Colors.black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Name",
                                style: style,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Ihsan',
                                  style: style.copyWith(
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Email", style: style),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'ihsan.akif@gmail.com',
                                style:
                                    style.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Phone",
                                style: style,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '0194638227',
                                style:
                                    style.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Credit",
                                style: style,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "RM " + '10.00',
                                style:
                                    style.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Date Registered",
                                style: style,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('14/12/2020',
                                  style: style.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.yellow[400],
                      child: Expanded(

                          //color: Colors.red,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            MaterialButton(
                              onPressed: () {},
                              child: Text("Change Name",
                                  style: style.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ),
                            MaterialButton(
                              onPressed: () {},
                              child: Text("Change Password",
                                  style: style.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ),
                            MaterialButton(
                              onPressed: () {},
                              child: Text("Change Phone Number",
                                  style: style.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ),
                            MaterialButton(
                              onPressed: () {},
                              child: Text("Login Screen",
                                  style: style.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ),
                            MaterialButton(
                              onPressed: () {},
                              child: Text("Register New Account",
                                  style: style.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ),
                            MaterialButton(
                              onPressed: () {},
                              child: Text("Buy Credit",
                                  style: style.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ])),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
