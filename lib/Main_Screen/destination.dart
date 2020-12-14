import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Destination {
  const Destination(this.title, this.icon);
  final String title;
  final IconData icon;
}

List<Destination> allDestinations = <Destination>[
  Destination('Menu', MdiIcons.menu),
  Destination('Favorite', MdiIcons.heart),
  Destination('Cart', MdiIcons.cart),
  Destination('Profile', MdiIcons.faceProfile)
];
