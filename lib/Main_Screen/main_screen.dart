import 'package:eat_n_go/Cart_Screen/cart_screen.dart';
import 'package:eat_n_go/Favorite_Screen/favorite_screen.dart';
import 'package:eat_n_go/Menu_Screen/menu_screen.dart';
import 'package:eat_n_go/Profile_Screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'main_screen_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainScreenModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: getViewForIndex(model.currentIndex),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.yellow[400],
                unselectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.grey[900],
                selectedFontSize: 14,
                currentIndex: model.currentIndex, // have to add this
                onTap: model.setIndex,
                items: [
                  BottomNavigationBarItem(
                    label: 'Menu',
                    icon: Icon(
                      Icons.restaurant_menu,
                    ),
                  ),
                  BottomNavigationBarItem(
                      label: 'Favorite',
                      icon: Icon(
                        MdiIcons.heart,
                      )),
                  BottomNavigationBarItem(
                      label: 'Cart',
                      icon: Icon(
                        MdiIcons.cart,
                      )),
                  BottomNavigationBarItem(
                      label: 'Profile',
                      icon: Icon(
                        Icons.person,
                      )),
                ],
              ),
            ),
        viewModelBuilder: () => MainScreenModel());
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return MenuScreen();
      case 1:
        return FavoriteScreen();
      case 2:
        return CartScreen();
      case 3:
        return ProfileScreen();
      default:
        return MenuScreen();
    }
  }
}
